// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IBridge
 * @dev Interface for bridge contracts
 */
interface IBridge {
    /**
     * @dev Sends tokens to multiple recipients on a target network
     * @param targetNetwork ID of the target network
     * @param recipients Array of recipient addresses
     * @param amount Amount of tokens to send to each recipient
     */
    function send(
        uint256 targetNetwork,
        address[] calldata recipients,
        uint256 amount
    ) external payable;

    /**
     * @dev Returns the minimum amount required for bridging
     * @return Minimum amount in wei
     */
    function getMinAmount() external view returns (uint256);

    /**
     * @dev Returns the bridge fee
     * @param amount Amount to bridge
     * @return Fee in wei
     */
    function getBridgeFee(uint256 amount) external view returns (uint256);
} 