// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

enum Race {
    Human,
    Demon,
    Bear,
    Bull,
    Cat,
    Robot,
    Elf,
    Frog
}

enum Gender {
    Male,
    Female
}

enum Class {
    Warrior,
    Mage,
    Druid,
    Paladin,
    Bard,
    Necromancer,
    Priest,
    Rogue
}

struct Stats {
    uint256 strength;
    uint256 dexterity;
    uint256 charisma;
    uint256 wisdom;
    uint256 intelligence;
    uint256 constitution;
}

struct CharacterData {
    string name;
    Race race;
    Gender gender;
    Class class;
    Stats stats;
}

struct VRFConfig {
    address chainlinkToken;
    address vrfCoordinator;
    bytes32 keyHash;
}
