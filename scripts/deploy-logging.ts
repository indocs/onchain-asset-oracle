import { ethers } from "hardhat";

async function main() {
  const [signer] = await ethers.getSigners();
  console.log("[deploy-logging] Active signer:", signer.address);
}

main().catch((error) => {
  console.error("[deploy-logging] Error:", error);
  process.exitCode = 1;
});
