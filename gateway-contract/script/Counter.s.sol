// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {IdentityGateway} from "../src/Identity.sol";

contract CounterScript is Script {
    IdentityGateway public identityGateway;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        identityGateway = new IdentityGateway();

        vm.stopBroadcast();
    }
}
