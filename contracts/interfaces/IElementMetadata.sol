// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import { CharacterData } from "../ElementTypes.sol";

interface IElementMetadata {
    function buildMetadata(CharacterData memory data) external view returns (string memory);
}
