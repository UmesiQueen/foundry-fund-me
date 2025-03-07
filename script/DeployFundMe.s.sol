// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function deployContract() public returns (FundMe, HelperConfig) {
        // Any code before the startBroadcast is not a real tx
        HelperConfig helperConfig = new HelperConfig();
        address priceFeed = helperConfig
            .getConfigByChainId(block.chainid)
            .priceFeed;

        //After startBroadcast - Real tx
        vm.startBroadcast();
        FundMe fundMe = new FundMe(priceFeed);
        vm.stopBroadcast();

        return (fundMe, helperConfig);
    }

    function run() external returns (FundMe, HelperConfig) {
        return deployContract();
    }
}
