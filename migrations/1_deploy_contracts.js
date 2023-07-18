const LandLedger = artifacts.require("LandLedger");

module.exports = function(deployer) {
    deployer.deploy(LandLedger);
};