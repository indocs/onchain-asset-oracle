# onchain-asset-oracle

A reusable on-chain data feed toolkit that validates external feeds, reduces oracle risk, and streamlines integration for dApps.

## Outline

- Overview
- Design goals
- Local development with Hardhat
- Contracts
- Tests
- Deployment
- Verification

## Quickstart

1. Install dependencies
2. Configure environment
3. Compile, test, and deploy

## Deployment (Hardhat)

- Deploy with a local node or a remote provider via .env RPC_URL
- Verify contract on Etherscan-compatible networks (via Hardhat verification)

## Architecture

- AccessControl-based data feed registry
- Safe update paths with role-based access
- Events for attestation and integration hooks

## Roadmap

- Add multiple feed sources
- Integrate with off-chain attestation pipelines
- Gas optimization and batch updates

---

## OUTLINE

- contracts/OnchainAssetOracle.sol: core stateful contract
- test/OnchainAssetOracle.test.ts: tests for core behaviors
- scripts/deploy.ts: deployment script
- hardhat.config.ts: tooling configuration
- package.json: dependencies and scripts
- README.md: this document
