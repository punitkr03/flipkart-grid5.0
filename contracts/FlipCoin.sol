// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FlipCoin is ERC20 {
    address public owner;
    
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    
    function mintTokens(address to, uint256 amount) external payable {
        _mint(to, amount);
    }
}