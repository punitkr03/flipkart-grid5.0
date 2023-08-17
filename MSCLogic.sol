// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {MyStableCoin} from "./MyStableCoin.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConversion} from "./PriceConversion.sol";
import {OracleLib} from "./libraries/CheckOraclePriceFeed.sol";

contract MSCLogic is ReentrancyGuard{

    using OracleLib for AggregatorV3Interface;

    MyStableCoin private immutable i_msc;
    AggregatorV3Interface internal priceFeed;
    uint256 constant UsdToInr = 8322; //2 place decimal precision is required here.
    uint256 private constant priceFeed_Precision = 1e10;
    uint256 private constant EthToWeiprecision = 1e18;
    uint256 private constant decimal_precision = 1e2;

    error MSCLogic__NeedsMoreThanZero();
    error MSCLogic__MintFailed();

    modifier moreThanZero(uint256 amount){
        if(amount == 0){
            revert MSCLogic__NeedsMoreThanZero();
        }
        _;
    }

    constructor(address mscAddress, address _priceFeedAddress) {
        i_msc = MyStableCoin(mscAddress);
        priceFeed = AggregatorV3Interface(_priceFeedAddress);
    }

    mapping (address user => uint256 amountMSCMinted) s_MSCMinted;

    function mintMSC(uint256 amtOfMSCToBeMinted) external moreThanZero(amtOfMSCToBeMinted) nonReentrant{
        s_MSCMinted[msg.sender] += amtOfMSCToBeMinted;
        bool minted = i_msc.mint(msg.sender, amtOfMSCToBeMinted);
        if (minted != true) {
            revert MSCLogic__MintFailed();
        }
    }

    function _getAccountInformation(address user) private view returns (uint256 totalMscMinted){
        totalMscMinted = s_MSCMinted[user];
    }

    function getMsc() external view returns (address) {
        return address(i_msc);
    }

    /*function calculateTokensToMint(
        AggregatorV3Interface ethUsdPriceFeed,
        AggregatorV3Interface usdInrPriceFeed,
        uint256 ethAmount
    ) public view returns (uint256) {
        // Get the latest ETH/USD price
        (, int256 ethUsdPrice, , , ) = staleCheckLatestRoundData(ethUsdPriceFeed);

        // Get the latest USD/INR price
        (, int256 usdInrPrice, , , ) = staleCheckLatestRoundData(usdInrPriceFeed);

        // Calculate the value of the provided ETH amount in USD
        uint256 ethValueInUsd = uint256(ethUsdPrice) * ethAmount / 1e8;

        // Calculate the value of the ETH amount in INR using the USD/INR rate
        uint256 ethValueInInr = ethValueInUsd * uint256(usdInrPrice) / 1e8;

        // Calculate the number of tokens to mint based on the initial pegging ratio (5:1)
        uint256 tokensToMint = ethValueInInr * 5;

        return tokensToMint;
    }*/
}