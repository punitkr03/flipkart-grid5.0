// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {OracleLib} from "./libraries/CheckOraclePriceFeed.sol";

contract PriceConversion{
    using OracleLib for AggregatorV3Interface;
    AggregatorV3Interface internal priceFeed;
    uint256 private constant MSC_ETH_RATIO = 5;// assume 5 MSC = 1 ETH
    uint256 public constant UsdToInr = 8322;//2 place decimal precision is required here.
    uint256 private constant priceFeed_Precision = 1e10;
    uint256 private constant EthToWeiprecision = 1e18;
    uint256 private constant decimal_precision = 1e2;

    //since the stablecoin will be tied to eth, use eth/usd pricefeed address.
    constructor(address _priceFeedAddress){
        priceFeed = AggregatorV3Interface(_priceFeedAddress);
    }

    function fetchEthInrPrice() public view returns (uint256) {
        //first  we need to fetch the EthToUsd price using chainlink.
        (, int256 price, , , ) = priceFeed.staleCheckLatestRoundData();
        uint256 _price = uint256(price);
        //ETH -> USD has 8 decimal places, so Chainlink will send value of eth/usd * 1e8.
        //returns the value of 1 eth to inr.
        return _price * UsdToInr * priceFeed_Precision / (EthToWeiprecision * decimal_precision) ;
    }

    function getTokenAmountFromInr(uint256 inrAmountInWei) public pure returns (uint256) {
        //fetchEthInrVal() => 1 eth to inr
        //1 eth - 1e18 wei
        //1e18wei = inr
        //loyalty amt in wei = 1e18/inr * loyalty pts inr
        //assuming 5 MSC = 1 ETH, 1e18 wei
        //(5/1e18) MSc = 1 wei
        //loyalty MSC = 5/1e18*loyalty amt in wei
        return ((inrAmountInWei * MSC_ETH_RATIO) / EthToWeiprecision);
    }
}
