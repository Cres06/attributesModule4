# Project Module 4
    Are you up for a challenge that will put your skills to the test? Degen Gaming 🎮, a renowned game studio, has approached you to create a unique token that can reward players and take their game to the next level. You have been tasked with creating a token that can be earned by players in their game and then exchanged for rewards in their in-game store. A smart step towards increasing player loyalty and retention 🧠

    To support their ambitious plans, Degen Gaming has selected the Avalanche blockchain, a leading blockchain platform for web3 gaming projects, to create a fast and low-fee token. With these tokens, players can not only purchase items in the store, but also trade them with other players, providing endless possibilities for growth📈

    Are you ready to join forces with Degen Gaming and help turn their vision into a reality? The gaming world is counting on you to take it to the next level. Will you rise to the challenge 💪, or will it be game over ☠️ for you?

# Codes

  Attributes.sol
  
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

  CresOwned.sol

    //SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    contract CresOwned {
    address public Cres;
    address public newAccountholder;

    event NewOwnerTransfer(address indexed oldAccount, address indexed newOwner);
    event CancelledOwnership(address indexed oldAccount);

    constructor() {
        Cres = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == Cres, "Account: Caller is not the owner");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Account: New owner is the zero address");
        emit NewOwnerTransfer(Cres, newOwner);
        Cres = newOwner;
    }

    function cancelTransfer() public onlyOwner {
        require(newAccountholder != address(0), "Account: New owner is the zero address");
        emit NewOwnerTransfer(Cres, newAccountholder);
        Cres = newAccountholder;
    }
    }

# Author

    NTC
    Alcansado, Cresilda B.
    8210118@ntc.edu.ph
    
