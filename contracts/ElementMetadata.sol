// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.12;

import { Race, Gender, Class, Trait, Skill, Region, Stats, CharacterData } from "./ElementTypes.sol";
import { IElementMetadata } from "./interfaces/IElementMetadata.sol";

import { Base64 } from "@openzeppelin/contracts/utils/Base64.sol";
import { Strings } from "@openzeppelin/contracts/utils/Strings.sol";

import "hardhat/console.sol";

contract ElementMetadata is IElementMetadata {
    mapping(Race => string) internal raceStrings;
    mapping(Gender => string) internal genderStrings;
    mapping(Class => string) internal classStrings;
    mapping(Region => string) internal regionStrings;
    mapping(Race => mapping(Gender => string)) internal imageIpfsUrls;
    mapping(Race => mapping(Trait => string)) internal traitStrings;
    mapping(Class => mapping(Skill => string)) internal skillStrings;

    constructor() {
        raceStrings[Race.Human] = "Human";
        raceStrings[Race.Demon] = "Demon";
        raceStrings[Race.Bear] = "Bear";
        raceStrings[Race.Bull] = "Bull";
        raceStrings[Race.Cat] = "Cat";
        raceStrings[Race.Robot] = "Robot";
        raceStrings[Race.Elf] = "Elf";
        raceStrings[Race.Frog] = "Frog";

        genderStrings[Gender.Male] = "Male";
        genderStrings[Gender.Female] = "Female";

        classStrings[Class.Warrior] = "Warrior";
        classStrings[Class.Mage] = "Mage";
        classStrings[Class.Druid] = "Druid";
        classStrings[Class.Paladin] = "Paladin";
        classStrings[Class.Bard] = "Bard";
        classStrings[Class.Necromancer] = "Necromancer";
        classStrings[Class.Priest] = "Priest";
        classStrings[Class.Rogue] = "Rogue";

        regionStrings[Region.Region1] = "Montreal, Canada";
        regionStrings[Region.Region2] = "Berlin, Germany";
        regionStrings[Region.Region3] = "Chicago, USA";
        regionStrings[Region.Region4] = "Miami, USA";
        regionStrings[Region.Region5] = "NYC, USA";
        regionStrings[Region.Region6] = "Mexico City, Mexico";
        regionStrings[Region.Region7] = "Buenos Aires, Argentina";
        regionStrings[Region.Region8] = "London, UK";
        regionStrings[Region.Region9] = "Moscow, Russia";
        regionStrings[Region.Region10] = "Paris, France";
        regionStrings[Region.Region11] = "Amsterdam, The Netherlands";
        regionStrings[Region.Region12] = "Stockholm, Sweden";
        regionStrings[Region.Region13] = "Tokyo, Japan";
        regionStrings[Region.Region14] = "Shanghai, China";
        regionStrings[Region.Region15] = "Seoul, South Korea";
        regionStrings[Region.Region16] = "Melbourne, Australia";
        regionStrings[Region.Region17] = "Rio de Janeiro, Brazil";

        imageIpfsUrls[Race.Human][Gender.Male] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Human_A.png";
        imageIpfsUrls[Race.Human][Gender.Female] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Human_B.png";
        imageIpfsUrls[Race.Demon][Gender.Male] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Demon_A.png";
        imageIpfsUrls[Race.Demon][Gender.Female] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Demon_B.png";
        imageIpfsUrls[Race.Bear][Gender.Male] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Bear_A.png";
        imageIpfsUrls[Race.Bear][Gender.Female] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Bear_B.png";
        imageIpfsUrls[Race.Bull][Gender.Male] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Bull_A.png";
        imageIpfsUrls[Race.Bull][Gender.Female] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Bull_B.png";
        imageIpfsUrls[Race.Cat][Gender.Male] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Cat_A.png";
        imageIpfsUrls[Race.Cat][Gender.Female] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Cat_B.png";
        imageIpfsUrls[Race.Robot][Gender.Male] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Robot_A.png";
        imageIpfsUrls[Race.Robot][Gender.Female] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Robot_B.png";
        imageIpfsUrls[Race.Elf][Gender.Male] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Elf_A.png";
        imageIpfsUrls[Race.Elf][Gender.Female] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Elf_B.png";
        imageIpfsUrls[Race.Frog][Gender.Male] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Pepe_A.png";
        imageIpfsUrls[Race.Frog][Gender.Female] = "ipfs://QmSRp9STByPHrurTCvpwgBfz8ZX5FbkxamXjEk7HRw7PDr/Pepe_B.png";

        traitStrings[Race.Human][Trait.Trait1] = "Shrewd Diplomacy";
        traitStrings[Race.Human][Trait.Trait2] = "Beast Taming";
        traitStrings[Race.Human][Trait.Trait3] = "Ardent Explorer";
        traitStrings[Race.Human][Trait.Trait4] = "Opposable Thumbs";
        traitStrings[Race.Demon][Trait.Trait1] = "Bloodlust";
        traitStrings[Race.Demon][Trait.Trait2] = "Dark Vision";
        traitStrings[Race.Demon][Trait.Trait3] = "The Floor is Lava";
        traitStrings[Race.Demon][Trait.Trait4] = "A Tempting Offer";
        traitStrings[Race.Bear][Trait.Trait1] = "Just Wait and See";
        traitStrings[Race.Bear][Trait.Trait2] = "Perpetual Pessimist";
        traitStrings[Race.Bear][Trait.Trait3] = "Bubble Popper";
        traitStrings[Race.Bear][Trait.Trait4] = "See, I Told you";
        traitStrings[Race.Bull][Trait.Trait1] = "Up Only";
        traitStrings[Race.Bull][Trait.Trait2] = "Throw a Dart";
        traitStrings[Race.Bull][Trait.Trait3] = "To the Moon";
        traitStrings[Race.Bull][Trait.Trait4] = "Day Trader";
        traitStrings[Race.Cat][Trait.Trait1] = "Meme Scene";
        traitStrings[Race.Cat][Trait.Trait2] = "It's not a phase";
        traitStrings[Race.Cat][Trait.Trait3] = "Meow";
        traitStrings[Race.Cat][Trait.Trait4] = "Add me on DeviantArt";
        traitStrings[Race.Robot][Trait.Trait1] = "Built to Last";
        traitStrings[Race.Robot][Trait.Trait2] = "Deep Blue";
        traitStrings[Race.Robot][Trait.Trait3] = "Plug in Baby";
        traitStrings[Race.Robot][Trait.Trait4] = "Static Shock";
        traitStrings[Race.Elf][Trait.Trait1] = "Arcane Affinity";
        traitStrings[Race.Elf][Trait.Trait2] = "One with Nature";
        traitStrings[Race.Elf][Trait.Trait3] = "Into the Shadows";
        traitStrings[Race.Elf][Trait.Trait4] = "Light Footed";
        traitStrings[Race.Frog][Trait.Trait1] = "We're all in this Together";
        traitStrings[Race.Frog][Trait.Trait2] = "The Future of France";
        traitStrings[Race.Frog][Trait.Trait3] = "In it for the Tech";
        traitStrings[Race.Frog][Trait.Trait4] = "What's a Whitepaper?";

        skillStrings[Class.Warrior][Skill.Skill1] = "Whirlwind";
        skillStrings[Class.Warrior][Skill.Skill2] = "Shield Block";
        skillStrings[Class.Warrior][Skill.Skill3] = "Fury";
        skillStrings[Class.Warrior][Skill.Skill4] = "Comradery";
        skillStrings[Class.Mage][Skill.Skill1] = "Arcane Blast";
        skillStrings[Class.Mage][Skill.Skill2] = "Fireball";
        skillStrings[Class.Mage][Skill.Skill3] = "Frost Bolt";
        skillStrings[Class.Mage][Skill.Skill4] = "Two for One";
        skillStrings[Class.Druid][Skill.Skill1] = "Maul";
        skillStrings[Class.Druid][Skill.Skill2] = "Rejuvenation";
        skillStrings[Class.Druid][Skill.Skill3] = "Shapeshift";
        skillStrings[Class.Druid][Skill.Skill4] = "Enchant";
        skillStrings[Class.Paladin][Skill.Skill1] = "Smite";
        skillStrings[Class.Paladin][Skill.Skill2] = "Guiding Light";
        skillStrings[Class.Paladin][Skill.Skill3] = "Wall of Justice";
        skillStrings[Class.Paladin][Skill.Skill4] = "Lay on Hands";
        skillStrings[Class.Bard][Skill.Skill1] = "Song of Rest";
        skillStrings[Class.Bard][Skill.Skill2] = "Jack of all Trades";
        skillStrings[Class.Bard][Skill.Skill3] = "Free Compliments";
        skillStrings[Class.Bard][Skill.Skill4] = "A Twinkling Eye";
        skillStrings[Class.Necromancer][Skill.Skill1] = "Skeleton Army";
        skillStrings[Class.Necromancer][Skill.Skill2] = "Brittle Bones";
        skillStrings[Class.Necromancer][Skill.Skill3] = "Suspicious Pet";
        skillStrings[Class.Necromancer][Skill.Skill4] = "Pestilence";
        skillStrings[Class.Priest][Skill.Skill1] = "Healing Prayer";
        skillStrings[Class.Priest][Skill.Skill2] = "Touch of Light";
        skillStrings[Class.Priest][Skill.Skill3] = "Soothing Aura";
        skillStrings[Class.Priest][Skill.Skill4] = "Shackles from Above";
        skillStrings[Class.Rogue][Skill.Skill1] = "Pickpocket";
        skillStrings[Class.Rogue][Skill.Skill2] = "Fan of Knives";
        skillStrings[Class.Rogue][Skill.Skill3] = "Shadow Strike";
        skillStrings[Class.Rogue][Skill.Skill4] = "Poisoned Blade";
    }

    function buildTokenURI(CharacterData memory data) public view override returns (string memory) {
        return
            string(
                abi.encodePacked("data:application/json;base64,", Base64.encode(abi.encodePacked(_buildMetadata(data))))
            );
    }

    function _buildMetadata(CharacterData memory data) internal view returns (string memory) {
        // MUST CONCATENATE THESE STRINGS IN THIS ORDER
        console.log(string.concat(_buildCharacterMetadata(data), _buildStatsMetadata(data.userDefinedData.stats)));
        return string.concat(_buildCharacterMetadata(data), _buildStatsMetadata(data.userDefinedData.stats));
    }

    function _buildCharacterMetadata(CharacterData memory data) internal view returns (string memory) {
        return
            string(
                abi.encodePacked(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            data.userDefinedData.name,
                            '", "description":"',
                            "Element Protocol",
                            '", "image": "',
                            imageIpfsUrls[data.userDefinedData.race][data.userDefinedData.gender],
                            '", "attributes": ',
                            "[",
                            '{"trait_type": "Affinity",',
                            '"value":"',
                            data.userDefinedData.affinity,
                            '"},',
                            '{"trait_type": "Region",',
                            '"value":"',
                            regionStrings[data.randomizedData.region],
                            '"},',
                            '{"trait_type": "Trait 1",',
                            '"value":"',
                            traitStrings[data.userDefinedData.race][data.randomizedData.traits[0]],
                            '"},',
                            '{"trait_type": "Trait 2",',
                            '"value":"',
                            traitStrings[data.userDefinedData.race][data.randomizedData.traits[1]],
                            '"},',
                            '{"trait_type": "Skill 1",',
                            '"value":"',
                            skillStrings[data.userDefinedData.class][data.randomizedData.skills[0]],
                            '"},',
                            '{"trait_type": "Skill 2",',
                            '"value":"',
                            skillStrings[data.userDefinedData.class][data.randomizedData.skills[1]],
                            '"},',
                            '{"trait_type": "Race",',
                            '"value":"',
                            raceStrings[data.userDefinedData.race],
                            '"},',
                            '{"trait_type": "Gender",',
                            '"value":"',
                            genderStrings[data.userDefinedData.gender],
                            '"},',
                            '{"trait_type": "Class",',
                            '"value":"',
                            classStrings[data.userDefinedData.class],
                            '"},'
                        )
                    )
                )
            );
    }

    function _buildStatsMetadata(Stats memory stats) internal pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    bytes(
                        abi.encodePacked(
                            '{"trait_type": "Strength",',
                            '"value":',
                            Strings.toString(stats.strength),
                            "},",
                            '{"trait_type": "Dexterity",',
                            '"value":',
                            Strings.toString(stats.dexterity),
                            "},",
                            '{"trait_type": "Charisma",',
                            '"value":',
                            Strings.toString(stats.charisma),
                            "},",
                            '{"trait_type": "Wisdom",',
                            '"value":',
                            Strings.toString(stats.wisdom),
                            "},",
                            '{"trait_type": "Intelligence",',
                            '"value":',
                            Strings.toString(stats.intelligence),
                            "},",
                            '{"trait_type": "Constitution",',
                            '"value":',
                            Strings.toString(stats.constitution),
                            "}",
                            "]",
                            "}"
                        )
                    )
                )
            );
    }
}
