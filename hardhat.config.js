require("@nomiclabs/hardhat-ethers");
require("dotenv").config;
require("hardhat-deploy");
require("@nomiclabs/hardhat-etherscan");

const RPC_URL = process.env.RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY;
module.exports = {
  solidity: "0.8.18",
  defaultNetwork: "hardhat",
  // networks: {
  //   sepolia: {
  //     url: RPC_URL,
  //     chainId: 1115111,
  //     accounts: [PRIVATE_KEY],
  //   },
  // },
  // etherscan: {
  //   apiKey: {
  //     sepolia: ETHERSCAN_API_KEY,
  //   },
  // },
};
