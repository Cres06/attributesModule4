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
