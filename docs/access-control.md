# Access control notes for OnchainAssetOracle

This document provides a quick reference for interacting with the OnchainAssetOracle contract with respect to access control and owner-only actions.

Key points:

- The contract restricts state-changing operations to the owner. Non-owner accounts attempting to call restricted functions should revert.
- Use a proper owner-signed transaction when updating oracle data or performing administrative actions.
- In tests, you can verify access control by deploying the contract, attempting a restricted call from a non-owner account (which should fail), and then performing the same call from the owner account (which should succeed).

Common operations:

- Deploy contract as the owner.
- Call owner-only setters to update oracle values.
- Read-only view functions to fetch current oracle data.

Example workflow (pseudo-steps):

1. Deploy OnchainAssetOracle as the deploying account (owner).
2. From a non-owner account, attempt to call an owner-only setter. Expect a revert.
3. From the owner account, call the same setter. Expect success and updated state.

Notes for test authors:
- Ensure the test harness uses Hardhat's default accounts, where accounts[0] is typically the deployer/owner.
- Use expect(...).to.be.revertedWith(...) to assert access-control failures.

This file is intentionally lightweight and focuses on guidance without introducing additional contract logic.