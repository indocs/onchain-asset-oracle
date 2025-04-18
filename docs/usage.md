# Onchain Asset Oracle usage

This repository contains a minimal on-chain oracle that exposes an asset price on-chain. The tests in `test/OnchainAssetOracle.test.ts` exercise core read/write flows.

Usage outline:

- Compile contracts: `npm run build` (or `npx hardhat compile`).
- Run tests: `npm test`.
- Deploy locally (Hardhat network): `npm run deploy:local` (defined in scripts/deploy.ts and configured in hardhat.config.ts).

Key considerations:

- Access control (who can write prices) is handled within the contract (see the Solidity source in `contracts/OnchainAssetOracle.sol`).
- The oracle price is exposed via a public getter and can be consumed by off-chain systems.

Notes:

- This repo is designed for small, incremental updates. If you plan to extend the oracle (e.g., add multiple assets, or allow multi-owner governance), consider introducing a mapping of asset identifiers to price data and a robust access-control layer.
