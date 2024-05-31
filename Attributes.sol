//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

import "./CresOwned.sol";

contract Attributes is ERC20, CresOwned
{
    mapping(uint256 => uint256) public attribute;

    event ItemRedeemed(address indexed player, uint256 indexed attId, uint256 Amount);

    constructor(uint256 initialSupply) ERC20("Degen", "DGN") {
        _mint(msg.sender, initialSupply * 10 ** decimals());
        attribute[1] = 2000; // Strength
        attribute[2] = 1000; // Intelligence
        attribute[3] = 1000; // Dexterity
        attribute[4] = 1000; // Constitution
        attribute[5] = 2000; // Defense
        attribute[6] = 1000; // Recovery
    }

    function burn(uint256 Amount) external {
        _burn(msg.sender, Amount);
    }

    function mint(address account, uint256 Amount) public onlyOwner {
        _mint(account, Amount);
    }

    function setAttribute(uint256 attId, uint256 Amount) external onlyOwner {
        attribute[attId] = Amount;
        attribute[attId] = Amount;
        attribute[attId] = Amount;
    }

    function redeemAttribute(uint256 attId) external {
        uint256 exp = attribute[attId];
        require(exp > 0, "Invalid");
        require(balanceOf(msg.sender) >= exp, "Insufficient Exp");

        _transfer(msg.sender, Cres, exp);
        emit ItemRedeemed(msg.sender, attId, exp);
    }

    
}
