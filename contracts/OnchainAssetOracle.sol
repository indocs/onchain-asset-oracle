// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * A minimal on-chain asset oracle with simple owner-based access control.
 * - Stores a price (uint256).
 * - Only the owner can update the price.
 * - Owner can transfer ownership.
 */
contract OnchainAssetOracle {
    uint256 public price;
    address public owner;

    event PriceUpdated(uint256 newPrice);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "OnchainAssetOracle: caller is not the owner");
        _;
    }

    constructor(uint256 initialPrice) {
        owner = msg.sender;
        price = initialPrice;
        emit PriceUpdated(initialPrice);
    }

    /**
     * Update the on-chain price. Restricted to the contract owner.
     */
    function updatePrice(uint256 newPrice) external onlyOwner {
        price = newPrice;
        emit PriceUpdated(newPrice);
    }

    /**
     * Transfer contract ownership to a new address.
     */
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "OnchainAssetOracle: new owner is the zero address");
        address oldOwner = owner;
        owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}
