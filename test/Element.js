const { ethers } = require("hardhat");
const { expect } = require("chai");

const { fixture } = require("./fixture");

describe("Element", async () => {
  let element;
  let mintPrice;

  beforeEach(async () => {
    ({ element, mintPrice } = await fixture());
  });

  it("should test", async () => {
    // character data
    const characterData = ["George", 0, 0, 0, [20, 20, 20, 20, 20, 0]];

    // mint
    tx = await element.mint(characterData, { value: mintPrice });
    await tx.wait();

    // get token metadata
    const metadata = await element.tokenURI(0);
    console.log("Metadata:", metadata);
  });
});
