const NFT = artifacts.require("StringToken");
const Shop = artifacts.require("gStringToken");
const ShopFactory = artifacts.require("TokenVesting");

module.exports = async function (deployer, network, accounts) {
  const owner = "0xa99d6138bF26CdBf76C1DDc017D204af4FE9273d";
  const superfluid = "0xa99d6138bF26CdBf76C1DDc017D204af4FE9273d";
  const cfa = "0xa99d6138bF26CdBf76C1DDc017D204af4FE9273d";
  const fdai = "0xa99d6138bF26CdBf76C1DDc017D204af4FE9273d";
  await deployer.deploy(NFT);
  const nft = await NFT.deployed();
  await deployer.deploy(ShopFactory, superfluid, cfa, nft.address);
  const factory = await ShopFactory.deployed();
  await factory.mintShop(superfluid, cfa, nft.address, owner, 200, fdai);
};
