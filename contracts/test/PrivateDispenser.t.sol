// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/PrivateDispenser.sol";
import "../src/interfaces/IBridge.sol";

contract MockBridge is IBridge {
    event TokensSent(
        uint256 targetNetwork,
        address[] recipients,
        uint256 amount
    );

    uint256 public constant MIN_AMOUNT = 0.01 ether;
    uint256 public constant FEE_PERCENTAGE = 5; // 5% fee

    function send(
        uint256 targetNetwork,
        address[] calldata recipients,
        uint256 amount
    ) external payable override {
        emit TokensSent(targetNetwork, recipients, amount);
    }

    function getMinAmount() external pure override returns (uint256) {
        return MIN_AMOUNT;
    }

    function getBridgeFee(uint256 amount) external pure override returns (uint256) {
        return (amount * FEE_PERCENTAGE) / 100;
    }
}

contract PrivateDispenserTest is Test {
    PrivateDispenser dispenser;
    MockBridge bridge;
    address owner;
    address authorizedUser;
    address unauthorizedUser;

    function setUp() public {
        owner = address(this);
        authorizedUser = address(0x1);
        unauthorizedUser = address(0x2);
        
        dispenser = new PrivateDispenser();
        bridge = new MockBridge();
        
        dispenser.authorize(authorizedUser);
    }

    function test_Authorize() public {
        dispenser.authorize(unauthorizedUser);
        assertTrue(dispenser.authorized(unauthorizedUser));
    }

    function test_RevokeAuthorization() public {
        dispenser.revokeAuthorization(authorizedUser);
        assertFalse(dispenser.authorized(authorizedUser));
    }

    function test_Dispense() public {
        address[] memory recipients = new address[](2);
        recipients[0] = address(0x3);
        recipients[1] = address(0x4);
        
        uint256 amount = 1 ether;
        uint256 total = amount * recipients.length;

        vm.deal(authorizedUser, total);
        vm.prank(authorizedUser);
        
        dispenser.dispense{value: total}(
            1, // targetNetwork
            recipients,
            amount,
            address(bridge)
        );
    }

    function test_RevertWhen_InvalidTargetNetwork() public {
        address[] memory recipients = new address[](1);
        recipients[0] = address(0x3);
        
        vm.deal(authorizedUser, 1 ether);
        vm.prank(authorizedUser);
        
        vm.expectRevert("PrivateDispenser: invalid target network");
        dispenser.dispense{value: 1 ether}(
            0, // invalid target network
            recipients,
            1 ether,
            address(bridge)
        );
    }

    function test_RevertWhen_AmountBelowMinimum() public {
        address[] memory recipients = new address[](1);
        recipients[0] = address(0x3);
        
        vm.deal(authorizedUser, 0.005 ether);
        vm.prank(authorizedUser);
        
        vm.expectRevert("PrivateDispenser: amount below minimum");
        dispenser.dispense{value: 0.005 ether}(
            1,
            recipients,
            0.005 ether,
            address(bridge)
        );
    }

    function test_RevertWhen_UnauthorizedUserDispenses() public {
        address[] memory recipients = new address[](1);
        recipients[0] = address(0x3);
        
        vm.deal(unauthorizedUser, 1 ether);
        vm.prank(unauthorizedUser);
        
        vm.expectRevert("PrivateDispenser: caller is not authorized");
        dispenser.dispense{value: 1 ether}(
            1,
            recipients,
            1 ether,
            address(bridge)
        );
    }

    function test_RevertWhen_InsufficientFunds() public {
        address[] memory recipients = new address[](1);
        recipients[0] = address(0x3);
        
        vm.deal(authorizedUser, 0.5 ether);
        vm.prank(authorizedUser);
        
        vm.expectRevert("PrivateDispenser: insufficient funds");
        dispenser.dispense{value: 0.5 ether}(
            1,
            recipients,
            1 ether,
            address(bridge)
        );
    }
} 