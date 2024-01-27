// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

import {Test, console} from "forge-std/Test.sol";
import {PingPong, PingPongEvents} from "../src/PingPong.sol";

contract PingPongTest is Test, PingPongEvents {
    PingPong public pingpong;
    address alice;
    address bob;

    function setUp() public {
        alice = makeAddr("alice");
        bob = makeAddr("bob");
        vm.deal(alice, 1 ether);
        vm.deal(bob, 1 ether);

        vm.startPrank(alice);
        pingpong = new PingPong();
        vm.stopPrank();
    }

    function test_Deploy() public {
        assertEq(alice, pingpong.pinger());
    }

    function test_Ping() public {
        vm.startPrank(alice);
        vm.expectEmit(false, false, false, false, address(pingpong));
        emit Ping();

        pingpong.ping();
        vm.stopPrank();

        vm.startPrank(bob);
        vm.expectRevert(abi.encodeWithSelector(PingPong.NotPinger.selector));
        pingpong.ping();
        vm.stopPrank();
    }

    function test_Pong() public {
        vm.startPrank(bob);
        bytes32 data = hex"01";

        vm.expectEmit(false, false, false, true, address(pingpong));
        emit Pong(data);

        pingpong.pong(data);
        vm.stopPrank();
    }
}
