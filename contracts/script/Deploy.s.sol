// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/PrivateDispenser.sol";
import "../src/Proxy.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Deploy implementation
        PrivateDispenser implementation = new PrivateDispenser();
        
        // Deploy proxy
        Proxy proxy = new Proxy(address(implementation));
        
        // Initialize proxy
        address proxyAddress = address(proxy);
        (bool success, ) = proxyAddress.call(
            abi.encodeWithSignature(
                "authorize(address)",
                vm.addr(deployerPrivateKey)
            )
        );
        require(success, "Authorization failed");

        vm.stopBroadcast();

        // Log addresses
        console.log("Implementation address:", address(implementation));
        console.log("Proxy address:", proxyAddress);
    }
} 