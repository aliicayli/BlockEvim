const LifeMeaning = artifacts.require("LifeMeaning");

module.exports = function(deployer) {
  deployer.deploy(LifeMeaning);
};
