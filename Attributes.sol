// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "./CresOwned.sol";

contract Attributes is ERC20, CresOwned {
    mapping(uint256 => uint256) public attributes;

    mapping(address => mapping(uint256 => bool)) public redemptions;

    event ItemRedeemed(address indexed player, uint256 indexed attId, uint256 amount);
    event AttributeDelivered(address indexed player, uint256 indexed attId);

    constructor(uint256 initialSupply) ERC20("Degen", "DGN") {
        _mint(msg.sender, initialSupply * 10 ** decimals());
        _initializeAttributes();
    }

    function _initializeAttributes() internal {
        attributes[1] = 2000; // Strength
        attributes[2] = 1000; // Intelligence
        attributes[3] = 1000; // Dexterity
        attributes[4] = 1000; // Constitution
        attributes[5] = 2000; // Defense
        attributes[6] = 1000; // Recovery
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    function setAttribute(uint256 attId, uint256 amount) external onlyOwner {
        attributes[attId] = amount;
    }

    function redeemAttribute(uint256 attId) external {
        require(!redemptions[msg.sender][attId], "Already Redeemed");
        uint256 cost = attributes[attId];
        require(cost > 0, "Invalid Attribute");
        require(balanceOf(msg.sender) >= cost, "Insufficient Exp");

        _burn(msg.sender, cost);
        redemptions[msg.sender][attId] = true;

        emit ItemRedeemed(msg.sender, attId, cost);
        emit AttributeDelivered(msg.sender, attId);
    }

    function redeemAndReceiveAttribute(uint256 attId) external {
        require(!redemptions[msg.sender][attId], "Already Redeemed");
        uint256 cost = attributes[attId];
        require(cost > 0, "Invalid Attribute");
        require(balanceOf(msg.sender) >= cost, "Insufficient Exp");

        _burn(msg.sender, cost);
        redemptions[msg.sender][attId] = true;

        emit ItemRedeemed(msg.sender, attId, cost);
        emit AttributeDelivered(msg.sender, attId);
    }
}
