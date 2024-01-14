const PhoneNumberReport = artifacts.require("PhoneNumberReport");

module.exports = function(deployer) {
  deployer.deploy(PhoneNumberReport);
};
