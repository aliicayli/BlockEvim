// migrations/2_deploy_contracts.js
const StorageContract = artifacts.require("StorageContract");

module.exports = function (deployer) {
    deployer.deploy(StorageContract);
};
