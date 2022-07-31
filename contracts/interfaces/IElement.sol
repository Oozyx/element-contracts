// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import { CharacterData } from "../ElementTypes.sol";

interface IElement {
    function mint(CharacterData calldata data) external payable;

    function mintFromExisting(
        address collection,
        uint256 tokenId,
        CharacterData calldata data
    ) external payable;
}
