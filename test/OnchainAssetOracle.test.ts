import { ethers } from "hardhat";
import { expect } from "chai";

describe("OnchainAssetOracle", function () {
  it("should deploy with initial price and owner, allow owner to update", async function () {
    const [owner, addr1] = await ethers.getSigners();
    const initialPrice = 100;

    const Oracle = await ethers.getContractFactory("OnchainAssetOracle", owner);
    const oracle = await Oracle.deploy(initialPrice);
    await oracle.deployed();

    // initial state
    expect(await oracle.price()).to.equal(initialPrice);
    expect(await oracle.owner()).to.equal(await owner.getAddress());

    // owner updates price
    await oracle.updatePrice(200);
    expect(await oracle.price()).to.equal(200);
  });

  it("should revert when non-owner tries to update price", async function () {
    const [owner, nonOwner] = await ethers.getSigners();
    const initialPrice = 50;

    const Oracle = await ethers.getContractFactory("OnchainAssetOracle", owner);
    const oracle = await Oracle.deploy(initialPrice);
    await oracle.deployed();

    // try non-owner update
    const oracleAsNonOwner = oracle.connect(nonOwner);
    await expect(oracleAsNonOwner.updatePrice(999)).to.be.revertedWith("OnchainAssetOracle: caller is not the owner");
  });

  it("should allow owner to transfer ownership", async function () {
    const [owner, newOwner] = await ethers.getSigners();
    const oracle = await (await ethers.getContractFactory("OnchainAssetOracle", owner)).deploy(10);
    await oracle.deployed();

    expect(await oracle.owner()).to.equal(await owner.getAddress());

    await oracle.transferOwnership(await newOwner.getAddress());
    expect(await oracle.owner()).to.equal(await newOwner.getAddress());
  });
});
