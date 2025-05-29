const Voting = artifacts.require("Voting");

// Replace this with the **WFO token address** from your Ganache deployment
//const WFO_TOKEN_ADDRESS = "0xYourWfoTokenAddressHere"; 
const WFO_TOKEN_ADDRESS ="0xf1f7BCeD1f30867284dA9a1F52F9AcD014F25a6E";

module.exports = async function(deployer, network, accounts) {
  const proposals = ["SD Bhsoale", "HumanRobot", "No Voting"];
  await deployer.deploy(Voting, WFO_TOKEN_ADDRESS, proposals);
};
