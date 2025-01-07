// SPDX-License-Identifier: MIT
import { expect } from 'chai';
import { ethers } from 'hardhat';

describe('OnchainAssetOracle', function () {
  it('deploys with admin and updater roles, creates and updates feeds', async function () {
    const [deployer, updater, other] = await ethers.getSigners();

    const OA = await ethers.getContractFactory('OnchainAssetOracle');
    const oracle = await OA.deploy(deployer.address);
    await oracle.deployed();

    // Transfer updater role to updater address
    await oracle.grantRole(await oracle.UPDATER_ROLE(), updater.address);

    // Create a feed
    await expect(oracle.connect(updater).createFeed('ETH/USD', 1800)).to.emit(oracle, 'FeedCreated').withArgs('ETH/USD', 1800, anyValue => true, updater.address);

    // Update feed
    await expect(oracle.connect(updater).updateFeed('ETH/USD', 1810)).to.emit(oracle, 'FeedUpdated').withArgs('ETH/USD', 1810, anyValue => true, updater.address);

    // Read feed
    const [val, ts] = await oracle.getFeed('ETH/USD').then(r => [r[0], r[1]]);
    expect(val).to.equal(1810);
    expect(ts).to.be.above(0);

    // Unauthorized update should fail
    await expect(oracle.connect(other).updateFeed('ETH/USD', 1820)).to.be.revertedWith('OA: caller is not updater');
  });
});
