// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IBridge.sol";

/**
 * @title IAcross
 * @dev Interface for Across bridge
 */
interface IAcross is IBridge {
    /**
     * @dev Sends tokens through Across bridge
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
     * @dev Returns the bridge fee
     * @param targetNetwork ID of the target network
     * @param amount Amount to bridge
     * @return Fee in wei
     */
    function getBridgeFee(uint256 targetNetwork, uint256 amount)
        external
        view
        returns (uint256);

    /**
     * @dev Returns the estimated time for bridging
     * @param targetNetwork ID of the target network
     * @return Estimated time in seconds
     */
    function getEstimatedTime(uint256 targetNetwork)
        external
        view
        returns (uint256);
} 