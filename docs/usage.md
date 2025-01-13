# Onchain Asset Oracle - Usage Guide

This repository contains a minimal on-chain asset oracle implemented in Solidity with tests and deployment scripts managed by Hardhat.

Highlights:
- Read-only on-chain asset price retrieval via a simple Oracle interface
- Local Hardhat tests to verify expected behavior without relying on external price feeds
- Lightweight deployment script to deploy the oracle contract on a local network

How to run locally:
1. Install dependencies:
   - npm install
2. Compile contracts:
   - npx hardhat compile
3. Run tests:
   - npx hardhat test
4. Deploy to a local network:
   - npx hardhat run scripts/deploy.ts --network localhost

Notes:
- This repository is designed to be extended. If you add more assets or need different price sources, keep the interface stable and update tests accordingly.
- Avoid introducing external dependencies for tests to keep the suite fast and deterministic.
