const { ethers } = require("hardhat");

async function main() {
  const LINK = "0x01BE23585060835E02B77ef475b0Cc51aA1e0709";
  const VRF_COORDINATOR = "0x6168499c0cFfCaCD319c818142124B7A15E857ab";
  const KEY_HASH = "0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc";

  const mintPrice = 0;

  const Element = await ethers.getContractFactory("Element");
  const element = await Element.deploy(mintPrice, [LINK, VRF_COORDINATOR, KEY_HASH]);
  await element.deployed();

  console.log(element.address);
}

main()
  .then(() => {
    process.exit(0);
  })
  .catch((e) => {
    console.error(e);
    process.exit(1);
  });
