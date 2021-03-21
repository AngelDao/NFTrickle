// HARP
const StringToken = artifacts.require("StringToken");
const gStringToken = artifacts.require("gStringToken");
const TokenVesting = artifacts.require("TokenVesting");
const LatestFarm = artifacts.require("LatestFarm");
const LUSDLP = artifacts.require("LUSDLPToken");
const ETHLP = artifacts.require("ETHLPToken");
const LQTYToken = artifacts.require("LQTYToken");
const StringStaking = artifacts.require("StringStaking");
const LUSDToken = artifacts.require("LUSDToken.sol");
const StabilityFactory = artifacts.require("StabilityFactory.sol");
const { addresses } = require("../src/utils/handleContracts/addresses");

module.exports = async function (deployer, network, accounts) {
  const deploy = "kovan";

  // HARP
  // 2nd Ganache
  // Token Contract
  const HarpDAOAddress = "0x0cbde7d648C1F51253d53ca1dB099030Fc35490a";
  const owner = accounts[1];

  await deployer.deploy(LUSDToken, accounts[0], accounts[1]);
  await deployer.deploy(LQTYToken, accounts[0], accounts[1]);

  let lusdToken, lqtyToken, stabilityPool;

  if (deploy === "kovan") {
    lusdToken = addresses.kovan.lusdToken;
    lqtyToken = addresses.kovan.lqtyToken;
    stabilityPool = addresses.kovan.stabilityPool;
  } else if (deploy === "ganache") {
    stabilityPool = addresses.kovan.stabilityPool;
    lusdToken = await LUSDToken.deployed();
    lqtyToken = await LQTYToken.deployed();
  }
  await deployer.deploy(
    StringToken,
    "ozString",
    "ozSTRING",
    HarpDAOAddress,
    owner
  );
  const stringToken = await StringToken.deployed();

  // 3rd Ganache
  // Vesting Contract
  const AngelDAOAddress = accounts[2];
  const years = 365 * 2;
  await deployer.deploy(
    TokenVesting,
    AngelDAOAddress,
    years,
    stringToken.address
  );
  const tokenVesting = await TokenVesting.deployed();

  const vestingAddress = tokenVesting.address;

  await stringToken.addVestingAddress(vestingAddress, { from: owner });

  // 1st Ganache
  // Farm Deployments

  await deployer.deploy(LUSDLP, accounts[0], accounts[1]);
  await deployer.deploy(ETHLP, accounts[0], accounts[1]);
  await deployer.deploy(gStringToken, owner);
  const gstringToken = await gStringToken.deployed();
  await deployer.deploy(
    StringStaking,
    stringToken.address,
    100,
    lqtyToken.address,
    gstringToken.address
  );

  const ethLPToken = await ETHLP.deployed();
  const lusdLPToken = await LUSDLP.deployed();
  // 10e18 = 1000000000000000000
  //   base reward per block = 0.358974359
  // await deployer.deploy(
  //   Farm,
  //   ethLPToken.address,
  //   lusdLPToken.address,
  //   stringToken.address,
  //   358974359000000000
  // );
  await deployer.deploy(LatestFarm, stringToken.address, 100);

  const farm = await LatestFarm.deployed();
  const stringStaking = await StringStaking.deployed();

  await gstringToken.addVestingAddress(stringStaking.address, { from: owner });
  await stringToken.addVestingAddress(stringStaking.address, { from: owner });
  await stringToken.addVestingAddress(farm.address, { from: owner });
  await farm.add(80, ethLPToken.address, true);
  await farm.add(20, lusdLPToken.address, true);

  await deployer.deploy(
    StabilityFactory,
    stringStaking.address,
    lusdToken.address,
    stringToken.address,
    stabilityPool.address
  );
};
