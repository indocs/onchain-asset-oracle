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

## Usage

This project uses Hardhat for local development, testing, and deployment. Below are the common workflows.

- Install dependencies
  - npm install
- Configure environment
  - Create a .env file with at least:
    - RPC_URL=<your Ethereum or compatible node RPC URL>
    - DEPLOYER_PRIVATE_KEY=<private key for deployment>
    - ETHERSCAN_API_KEY=<optional, for contract verification on supported networks>
- Compile
  - npx hardhat compile
- Test
  - npx hardhat test
- Local node (optional)
  - npx hardhat node
  - In a separate terminal, connect to the local node via RPC_URL and deploy
- Deploy
  - npx hardhat run scripts/deploy.ts --network <network-name>
  - Example: npx hardhat run scripts/deploy.ts --network hardhat
- Verify (if ETHERSCAN_API_KEY provided)
  - npx hardhat verify <CONTRACT_ADDRESS> --network <network-name> [constructor-args...]
  - See scripts/deploy.ts for constructor arguments used on deployment

Notes:
- The deployment script (scripts/deploy.ts) handles provisioning and initialization for the OnchainAssetOracle contract.
- Ensure the deployed network is configured in hardhat.config.ts and matches RPC_URL in .env.

## Design Notes

- Security
  - Access control: Uses role-based access (AccessControl) to govern who can update feeds and attestations.
  - Attestation and validation: External data feeds are validated before they are committed to-chain to minimize attack surface.
  - Revocation paths: Role-based revoke and pause capabilities to respond to compromised feeds oracles.
  - Event visibility: Attestation and update events enable off-chain monitoring and alerting.

- Gas and efficiency
  - Efficient state updates: Minimize on-chain state churn by batching updates where possible and avoiding unnecessary writes.
  - Read optimization: Public read access is designed to be cheap; off-chain indexing can be used to reduce on-chain compute for consumers.
  - Event design: Emit meaningful events to support off-chain indexing without requiring excessive on-chain calls.

- Compliance and interoperability
  - EVM compatibility: Designed to work with EVM-compatible networks (Ethereum, Layer 2s, and forks).
  - Verification readiness: Hardhat verification hooks are included for convenient contract verification on supported networks.

- Testing and reliability
  - Thorough unit tests