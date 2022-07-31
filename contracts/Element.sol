// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import { Race, Gender, Class, Stats, CharacterData, VRFConfig } from "./ElementTypes.sol";
import { ElementMetadata } from "./ElementMetadata.sol";
import { IElement } from "./interfaces/IElement.sol";
import { ElementUtils } from "./libraries/ElementUtils.sol";

import { LinkTokenInterface } from "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import { VRFCoordinatorV2Interface } from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import { VRFConsumerBaseV2 } from "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

contract Element is IElement, ElementMetadata, ERC721, VRFConsumerBaseV2 {
    uint256 private mintPrice;
    VRFConfig private vrfConfig;
    uint64 private subscriptionId;
    uint256 private mintCount;

    mapping(uint256 => CharacterData) public characterData;

    constructor(uint256 _mintPrice, VRFConfig memory _vrfConfig)
        ERC721("Element", "ELMNT")
        VRFConsumerBaseV2(vrfConfig.vrfCoordinator)
    {
        mintPrice = _mintPrice;
        vrfConfig = _vrfConfig;

        subscriptionId = VRFCoordinatorV2Interface(vrfConfig.vrfCoordinator).createSubscription();
        // Add this contract as a consumer of its own subscription.
        VRFCoordinatorV2Interface(vrfConfig.vrfCoordinator).addConsumer(subscriptionId, address(this));

        mintCount = 0;
    }

    /**

     */
    function mint(CharacterData calldata data) external payable override {
        require(msg.value == mintPrice, "Invalid msg.value");
        require(ElementUtils.verifyStats(data.stats), "Invalid stats");

        characterData[mintCount] = data;
        console.log("Inside contract - ", data.stats.strength);

        _safeMint(msg.sender, mintCount++);
    }

    /**
    
     */
    function mintFromExisting(
        address collection,
        uint256 tokenId,
        CharacterData calldata data
    ) external payable override {}

    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal virtual override {}

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return buildMetadata(characterData[tokenId]);
    }
}
