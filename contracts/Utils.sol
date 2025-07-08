// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Lightweight utility library to support safe math-like operations
// without pulling in external dependencies.
library AssetMath {
    // Safe addition: reverts on overflow.
    function addSafe(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "AssetMath: addition overflow");
        return c;
    }

    // Safe subtraction: reverts if b > a.
    function subSafe(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "AssetMath: subtraction underflow");
        return a - b;
    }

    // Safe multiplication: reverts on overflow.
    function mulSafe(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0 || b == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "AssetMath: multiplication overflow");
        return c;
    }
}
