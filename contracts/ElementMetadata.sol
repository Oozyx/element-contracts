// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import { Race, Gender, Class, Stats, CharacterData } from "./ElementTypes.sol";
import { IElementMetadata } from "./interfaces/IElementMetadata.sol";

import { Base64 } from "@openzeppelin/contracts/utils/Base64.sol";

import "@openzeppelin/contracts/utils/Strings.sol";

contract ElementMetadata is IElementMetadata {
    mapping(Race => string) internal raceStrings;
    mapping(Gender => string) internal genderStrings;
    mapping(Class => string) internal classStrings;
    mapping(Race => mapping(Gender => string)) internal imageIpfsUrls;

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
    }

    function buildMetadata(CharacterData memory data) public view override returns (string memory) {
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
                            '"},',
                            '{"trait_type": "Strength",',
                            '"value":"',
                            Strings.toString(data.userDefinedData.stats.strength),
                            '"},',
                            '{"trait_type": "Dexterity",',
                            '"value":"',
                            Strings.toString(data.userDefinedData.stats.dexterity),
                            '"},',
                            '{"trait_type": "Charisma",',
                            '"value":"',
                            Strings.toString(data.userDefinedData.stats.charisma),
                            '"},',
                            '{"trait_type": "Wisdom",',
                            '"value":"',
                            Strings.toString(data.userDefinedData.stats.wisdom),
                            '"},',
                            '{"trait_type": "Intelligence",',
                            '"value":"',
                            Strings.toString(data.userDefinedData.stats.intelligence),
                            '"},',
                            '{"trait_type": "Constitution",',
                            '"value":"',
                            Strings.toString(data.userDefinedData.stats.constitution),
                            '"}',
                            "]",
                            "}"
                        )
                    )
                )
            );
    }
}
