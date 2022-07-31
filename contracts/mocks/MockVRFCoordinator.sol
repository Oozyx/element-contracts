// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import { VRFCoordinatorV2Mock } from "@chainlink/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";

contract MockVRFCoordinator is VRFCoordinatorV2Mock {
    constructor(uint96 baseFee, uint96 gasPriceLink) VRFCoordinatorV2Mock(baseFee, gasPriceLink) {}
}
