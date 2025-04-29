// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IBridge.sol";

/**
 * @title ILiFi
 * @dev Interface for LiFi bridge
 */
interface ILiFi is IBridge {
    /**
     * @dev Sends tokens through LiFi bridge
     * @param targetNetwork ID of the target network
     * @param recipients Array of recipient addresses
     * @param amount Amount of tokens to send to each recipient
     */
    function send(
        uint256 targetNetwork,
        address[] calldata recipients,
        uint256 amount
    ) external payable override;

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