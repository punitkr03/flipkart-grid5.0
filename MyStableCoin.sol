// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.3/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.3/access/Ownable.sol";

contract MyStableCoin is ERC20, Ownable {
    uint256 public constant loyaltyPointsPercentage = 5;

    error MyStableCoin__AddressInvalid();
    error MyStableCoin__BalanceMustBeMoreThanZero();

    constructor() ERC20("MyStableCoin", "MSC") {}

    function mint(address user, uint256 _amount) external onlyOwner returns (bool) {
        if(user == address(0)){
            revert MyStableCoin__AddressInvalid();
        }
        if(_amount <= 0){
            revert MyStableCoin__BalanceMustBeMoreThanZero();
        }
        _mint(user, _amount);
        return true;
    }
}

