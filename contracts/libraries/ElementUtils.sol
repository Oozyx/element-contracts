// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import { Stats } from "../ElementTypes.sol";

library ElementUtils {
    function verifyStats(Stats calldata stats) internal pure returns (bool) {
        uint256 total = stats.strength +
            stats.dexterity +
            stats.charisma +
            stats.wisdom +
            stats.intelligence +
            stats.constitution;

        return total == 100;
    }
}
