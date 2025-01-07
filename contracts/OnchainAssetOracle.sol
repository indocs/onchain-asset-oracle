// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";

// A compact, real-state on-chain data feed with access control and verifiable events.
contract OnchainAssetOracle is AccessControl {
    bytes32 public constant UPDATER_ROLE = keccak256("UPDATER_ROLE");

    struct Feed {
        uint256 value;          // latest reported value (e.g., price, rate, etc.)
        uint256 timestamp;      // when the value was last updated
        string symbol;            // human-friendly symbol, e.g., ETH/USD
    }

    // symbol => Feed
    mapping(string => Feed) private feeds;

    // Events for attestations and updates
    event FeedUpdated(string indexed symbol, uint256 value, uint256 timestamp, address updater);
    event FeedCreated(string indexed symbol, uint256 value, uint256 timestamp, address creator);

    constructor(address admin) {
        _setupRole(DEFAULT_ADMIN_ROLE, admin);
        _setupRole(UPDATER_ROLE, admin);
    }

    modifier onlyUpdater() {
        require(hasRole(UPDATER_ROLE, msg.sender), "OA: caller is not updater");
        _;
    }

    function createFeed(string calldata symbol, uint256 initialValue) external onlyUpdater {
        require(bytes(symbol).length > 0, "OA: empty symbol");
        Feed storage f = feeds[symbol];
        require(f.timestamp == 0, "OA: feed exists");
        f.value = initialValue;
        f.timestamp = block.timestamp;
        f.symbol = symbol;
        emit FeedCreated(symbol, initialValue, block.timestamp, msg.sender);
        emit FeedUpdated(symbol, initialValue, block.timestamp, msg.sender);
    }

    function updateFeed(string calldata symbol, uint256 newValue) external onlyUpdater {
        Feed storage f = feeds[symbol];
        require(f.timestamp != 0, "OA: feed not found");
        f.value = newValue;
        f.timestamp = block.timestamp;
        emit FeedUpdated(symbol, newValue, block.timestamp, msg.sender);
    }

    function getFeed(string calldata symbol) external view returns (uint256 value, uint256 timestamp, string memory sym) {
        Feed storage f = feeds[symbol];
        require(f.timestamp != 0, "OA: feed not found");
        return (f.value, f.timestamp, f.symbol);
    }

    // Convenience: check stale feeds (e.g., if older than threshold)
    function isFeedStale(string calldata symbol, uint256 maxAge) external view returns (bool) {
        Feed storage f = feeds[symbol];
        if (f.timestamp == 0) return true;
        return (block.timestamp - f.timestamp) > maxAge;
    }
}
