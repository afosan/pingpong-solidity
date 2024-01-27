// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {PingPong} from "../src/PingPong.sol";

contract PingPongTest is Test {
    PingPong public pingpong;

    function setUp() public {
        pingpong = new PingPong();
    }
}
