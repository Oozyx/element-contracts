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

enum Trait {
    Trait1,
    Trait2,
    Trait3,
    Trait4
}
enum Skill {
    Skill1,
    Skill2,
    Skill3,
    Skill4
}

enum Region {
    Region1,
    Region2,
    Region3,
    Region4,
    Region5,
    Region6,
    Region7,
    Region8,
    Region9,
    Region10,
    Region11,
    Region12,
    Region13,
    Region14,
    Region15,
    Region16,
    Region17
}

struct Stats {
    uint256 strength;
    uint256 dexterity;
    uint256 charisma;
    uint256 wisdom;
    uint256 intelligence;
    uint256 constitution;
}

struct UserDefinedData {
    Race race;
    Gender gender;
    Class class;
    Stats stats;
    string name;
    string affinity;
}

struct RandomizedData {
    Region region;
    Trait[2] traits;
    Skill[2] skills;
}

struct CharacterData {
    UserDefinedData userDefinedData;
    RandomizedData randomizedData;
}

struct VRFConfig {
    address chainlinkToken;
    address vrfCoordinator;
    bytes32 keyHash;
}
