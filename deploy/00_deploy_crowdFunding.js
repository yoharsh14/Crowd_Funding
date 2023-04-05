const { network } = require("hardhat");
const { developmentChains } = require("../helper_hardhat.config");
const { verify } = require("../utils/verify");
module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deployer } = await getNamedAccounts();
  const { deploy, log } = deployments;

  const crowFund = await deploy("crowdFunding", {
    from: deployer,
    args: [],
    log: true,
  });
  if (!developmentChains.includes(network.name)) {
    log("verifying...")
    await verify(crowFund.address, []);
  }
};
