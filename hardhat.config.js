require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("hardhat-deploy");
require("hardhat-deploy-ethers");
require("dotenv").config();

const RINKEBY_URL = process.env.RINKEBY_URL ? process.env.RINKEBY_URL : "";
const RINKEBY_PRIVATE_KEY = process.env.RINKEBY_PRIVATE_KEY
  ? process.env.RINKEBY_PRIVATE_KEY
  : "0000000000000000000000000000000000000000000000000000000000000000";
const ETHERSCAN_API = process.env.ETHERSCAN_API ? process.env.ETHERSCAN_API : "";

module.exports = {
  solidity: "0.8.12",
  networks: {
    rinkeby: {
      url: RINKEBY_URL,
      accounts: [RINKEBY_PRIVATE_KEY, process.env.RINKEBY_PRIVATE_KEY_2, process.env.RINKEBY_PRIVATE_KEY_3],
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API,
  },
};
