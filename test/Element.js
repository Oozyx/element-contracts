const { ethers } = require("hardhat");
const { expect } = require("chai");
const { mine } = require("@nomicfoundation/hardhat-network-helpers");

const { fixture } = require("./fixture");

describe("Element", async () => {
  let element;
  let vrfCoordinator;
  let mintPrice;

  beforeEach(async () => {
    ({ element, vrfCoordinator, mintPrice } = await fixture());
  });

  it("should test", async () => {
    // character data
    const characterData = [0, 0, 0, [20, 20, 20, 20, 20, 0], "George", "ETH"];

    // mint
    tx = await element.mint(characterData, { value: mintPrice });
    receipt = await tx.wait();
    const requestId = receipt.events[1].args[1];

    // fulfill randomness
    tx = await vrfCoordinator.fulfillRandomWordsWithOverride(requestId, element.address, [123456789]);
    receipt = await tx.wait();

    // mine blocks
    mine(1000);

    // get token metadata
    const metadata = await element.tokenURI(0);
    console.log("Metadata:", metadata);
  });
});
