const MyContract = artifacts.require("TransactionManagement");

module.exports = function (deployer) {
  deployer.deploy(MyContract);
};