// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Proxy
 * @dev This contract implements a transparent proxy pattern for upgradeable contracts
 */
contract Proxy {
    /**
     * @dev Storage slot with the address of the current implementation.
     */
    address public implementation;
    
    /**
     * @dev Storage slot with the admin of the contract.
     */
    address public admin;

    /**
     * @dev Emitted when the implementation is upgraded.
     */
    event Upgraded(address indexed implementation);

    /**
     * @dev Initializes the proxy with an implementation contract.
     * @param _implementation Address of the initial implementation
     */
    constructor(address _implementation) {
        implementation = _implementation;
        admin = msg.sender;
    }

    /**
     * @dev Upgrades the implementation address.
     * @param newImplementation Address of the new implementation
     */
    function upgradeTo(address newImplementation) external {
        require(msg.sender == admin, "Proxy: caller is not admin");
        require(newImplementation != address(0), "Proxy: new implementation is zero address");
        
        implementation = newImplementation;
        emit Upgraded(newImplementation);
    }

    /**
     * @dev Delegates the current call to the implementation.
     */
    fallback() external payable {
        address impl = implementation;
        require(impl != address(0), "Proxy: implementation not set");

        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let result := delegatecall(gas(), impl, ptr, calldatasize(), 0, 0)
            let size := returndatasize()
            returndatacopy(ptr, 0, size)

            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }

    /**
     * @dev Fallback function that delegates calls to the implementation.
     */
    receive() external payable {
        _fallback();
    }

    /**
     * @dev Internal fallback function that delegates calls to the implementation.
     */
    function _fallback() internal {
        address impl = implementation;
        require(impl != address(0), "Proxy: implementation not set");

        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let result := delegatecall(gas(), impl, ptr, calldatasize(), 0, 0)
            let size := returndatasize()
            returndatacopy(ptr, 0, size)

            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }
} 