// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IBridge.sol";

/**
 * @title PrivateDispenser
 * @dev Contract for cross-chain token distribution through various bridges
 */
contract PrivateDispenser {
    address public owner;
    mapping(address => bool) public authorized;
    address public constant MULTICALL = 0xcA11bde05977b3631167028862bE2a173976CA11;

    event Dispensed(
        uint256 indexed targetNetwork,
        address[] recipients,
        uint256 amount,
        address bridge
    );

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "PrivateDispenser: caller is not owner");
        _;
    }

    modifier onlyAuthorized() {
        require(authorized[msg.sender], "PrivateDispenser: caller is not authorized");
        _;
    }

    /**
     * @dev Authorizes an address to use the dispenser
     * @param _address Address to authorize
     */
    function authorize(address _address) external onlyOwner {
        authorized[_address] = true;
    }

    /**
     * @dev Revokes authorization from an address
     * @param _address Address to revoke authorization from
     */
    function revokeAuthorization(address _address) external onlyOwner {
        authorized[_address] = false;
    }

    /**
     * @dev Calculates the amount after bridge fees
     * @param amount Original amount
     * @param bridge Bridge contract address
     * @return Amount after fees
     */
    function _calculateAmountAfterFees(uint256 amount, address bridge) internal view returns (uint256) {
        uint256 fee = IBridge(bridge).getBridgeFee(amount);
        return amount - fee;
    }

    /**
     * @dev Distributes tokens to multiple addresses through a bridge
     * @param targetNetwork ID of the target network
     * @param recipients Array of recipient addresses
     * @param amount Amount of tokens to send to each recipient
     * @param bridge Address of the bridge contract
     */
    function dispense(
        uint256 targetNetwork,
        address[] calldata recipients,
        uint256 amount,
        address bridge
    ) external payable onlyAuthorized {
        require(recipients.length > 0, "PrivateDispenser: no recipients");
        require(amount > 0, "PrivateDispenser: amount must be greater than 0");
        
        uint256 minAmount = IBridge(bridge).getMinAmount();
        require(amount >= minAmount, "PrivateDispenser: amount below minimum");

        uint256 totalAmount = amount * recipients.length;
        require(msg.value >= totalAmount, "PrivateDispenser: insufficient funds");

        // Calculate amount after fees for each recipient
        uint256 amountAfterFees = _calculateAmountAfterFees(amount, bridge);
        require(amountAfterFees > 0, "PrivateDispenser: amount too small after fees");

        // Verify target network is supported
        require(targetNetwork > 0, "PrivateDispenser: invalid target network");

        IBridge(bridge).send{value: totalAmount}(
            targetNetwork,
            recipients,
            amountAfterFees
        );

        emit Dispensed(targetNetwork, recipients, amountAfterFees, bridge);
    }

    /**
     * @dev Allows the contract to receive ETH
     */
    receive() external payable {}
} 