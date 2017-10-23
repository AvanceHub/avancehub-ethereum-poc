var ENS = artifacts.require("./lib/ENS.sol");
var Ownable = artifacts.require("./lib/Ownable.sol");
var PublicResolver = artifacts.require("./lib/PublicResolver.sol");
var Upgradable = artifacts.require("./Upgradable.sol");


module.exports = function(deployer) {
  // deployer.deploy(Ownable);
  // deployer.link(Ownable, Upgradable);
  // deployer.deploy(PublicResolver);
  // deployer.link(PublicResolver, Upgradable);
  // deployer.deploy(ENS);
  // deployer.link(ENS, Upgradable);
  deployer.deploy(Upgradable);
};
