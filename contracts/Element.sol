// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import { Race, Gender, Class, Trait, Skill, Region, Stats, UserDefinedData, RandomizedData, CharacterData, VRFConfig } from "./ElementTypes.sol";
import { ElementMetadata } from "./ElementMetadata.sol";
import { IElement } from "./interfaces/IElement.sol";
import { ElementUtils } from "./libraries/ElementUtils.sol";

import { LinkTokenInterface } from "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import { VRFCoordinatorV2Interface } from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import { VRFConsumerBaseV2 } from "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Element is IElement, ElementMetadata, ERC721, VRFConsumerBaseV2 {
    uint64 public subscriptionId;
    uint256 private mintPrice;
    VRFConfig private vrfConfig;
    uint256 private mintCount;

    mapping(uint256 => CharacterData) public characterData;
    mapping(uint256 => uint256) private randomRequestIdToMintId;
    mapping(uint256 => bool) private mintInitialized;

    constructor(uint256 _mintPrice, VRFConfig memory _vrfConfig)
        ERC721("Element", "ELMNT")
        VRFConsumerBaseV2(_vrfConfig.vrfCoordinator)
    {
        mintPrice = _mintPrice;
        vrfConfig = _vrfConfig;

        subscriptionId = VRFCoordinatorV2Interface(vrfConfig.vrfCoordinator).createSubscription();
        // Add this contract as a consumer of its own subscription.
        VRFCoordinatorV2Interface(vrfConfig.vrfCoordinator).addConsumer(subscriptionId, address(this));

        mintCount = 0;
    }

    function mint(UserDefinedData calldata data) external payable override {
        require(msg.value == mintPrice, "Invalid msg.value");
        require(ElementUtils.verifyStats(data.stats), "Invalid stats");

        // generate randomized data
        RandomizedData memory randomized = RandomizedData(
            Region.Region1,
            [Trait.Trait1, Trait.Trait1],
            [Skill.Skill1, Skill.Skill1]
        ); // default data will be overwritten
        uint256 requestId = _requestRandomWords(mintCount); // will be fulfilled later

        characterData[mintCount] = CharacterData(data, randomized);

        emit ElementMint(mintCount, requestId);

        _safeMint(msg.sender, mintCount++);
    }

    function mintFromExisting(
        address collection,
        uint256 tokenId,
        UserDefinedData calldata data
    ) external payable override {}

    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal virtual override {
        // get character data
        CharacterData storage data = characterData[randomRequestIdToMintId[requestId]];

        // set randomized data
        uint256 newRandomWord;
        uint256 result;

        (result, newRandomWord) = _rollDice(17, randomWords[0]); // 1 out of 17
        data.randomizedData.region = Region(result);

        (result, newRandomWord) = _rollDice(4, newRandomWord); // 1 out of 4
        data.randomizedData.traits[0] = Trait(result);
        (result, newRandomWord) = _rollDice(4, newRandomWord); // 1 out of 4
        data.randomizedData.traits[1] = Trait(result);

        (result, newRandomWord) = _rollDice(4, newRandomWord); // 1 out of 4
        data.randomizedData.skills[0] = Skill(result);
        (result, newRandomWord) = _rollDice(4, newRandomWord); // 1 out of 4
        data.randomizedData.skills[1] = Skill(result);

        mintInitialized[randomRequestIdToMintId[requestId]] = true;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(mintInitialized[tokenId], "Invalid token id");
        return buildTokenURI(characterData[tokenId]);
    }

    function _requestRandomWords(uint256 mintId) internal returns (uint256) {
        uint256 requestId = VRFCoordinatorV2Interface(vrfConfig.vrfCoordinator).requestRandomWords(
            vrfConfig.keyHash,
            subscriptionId,
            3, // number of confirmations
            100000, // gas callback limit
            1 // number of random words
        );
        randomRequestIdToMintId[requestId] = mintId;
        return requestId;
    }

    function _rollDice(uint8 maxNumber, uint256 randomNumber) internal pure returns (uint8, uint256) {
        return (uint8(randomNumber % maxNumber), randomNumber / 10);
    }
}
