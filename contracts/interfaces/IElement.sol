// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import { UserDefinedData } from "../ElementTypes.sol";

interface IElement {
    function mint(UserDefinedData calldata data) external payable;

    function mintFromExisting(
        address collection,
        uint256 tokenId,
        UserDefinedData calldata data
    ) external payable;
}
