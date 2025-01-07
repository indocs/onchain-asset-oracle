// Deployment script for Hardhat
import { ethers } from 'hardhat';

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log('Deploying from:', deployer.address);

  const OA = await ethers.getContractFactory('OnchainAssetOracle');
  const oracle = await OA.deploy(deployer.address);
  await oracle.deployed();

  console.log('OnchainAssetOracle deployed at:', oracle.address);
  // Optional: set up initial updater or perform a test update if env vars allow
}

main().catch((err) => {
  console.error(err);
  process.exitCode = 1;
});
