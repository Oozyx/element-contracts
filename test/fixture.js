const { ethers, deployments } = require("hardhat");

const fixture = deployments.createFixture(async () => {
  // deploy the mock vrf coordinator
  const baseFee = ethers.utils.parseUnits("1", 0);
  const gasPriceLink = ethers.utils.parseUnits("1", 0);
  const VrfCoordinator = await ethers.getContractFactory("MockVRFCoordinator");
  const vrfCoordinator = await VrfCoordinator.deploy(baseFee, gasPriceLink);
  await vrfCoordinator.deployed();

  const mintPrice = ethers.utils.parseEther("0.1");

  const vrfConfig = [
    ethers.constants.AddressZero, // chainlink token
    vrfCoordinator.address,
    ethers.constants.HashZero,
  ];

  const Element = await ethers.getContractFactory("Element");
  const element = await Element.deploy(mintPrice, vrfConfig);
  await element.deployed();

  // fund the subscription
  tx = await vrfCoordinator.fundSubscription(await element.subscriptionId(), ethers.utils.parseEther("100"));
  await tx.wait();

  return {
    element,
    vrfCoordinator,
    mintPrice,
  };
});

module.exports = { fixture };
