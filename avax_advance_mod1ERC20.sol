// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract GameToken {
    uint public totalTokens;
    mapping(address => uint) public token_balance;
    mapping(address => mapping(address => uint)) public tokenAllowance;
    string public tokenName = "GameToken";
    string public tokenSymbol = "GME";
    uint8 public tokenDecimals = 18;

    event Token_Transfer(address indexed from, address indexed to, uint amount);
    event Token_Approval(address indexed owner, address indexed spender, uint amount);

    function transferToken(address recipient, uint amount) external returns (bool) {
        require(token_balance[msg.sender] >= amount, "Insufficient balance");
        token_balance[msg.sender] -= amount;
        token_balance[recipient] += amount;
        emit Token_Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approveToken(address spender, uint amount) external returns (bool) {
        tokenAllowance[msg.sender][spender] = amount;
        emit Token_Approval(msg.sender, spender, amount);
        return true;
    }

    function transferTokenFrom(address sender, address recipient, uint amount) external returns (bool) {
        require(tokenAllowance[sender][msg.sender] >= amount, "Allowance exceeded");
        require(token_balance[sender] >= amount, "Insufficient balance");
        tokenAllowance[sender][msg.sender] -= amount;
        token_balance[sender] -= amount;
        token_balance[recipient] += amount;
        emit Token_Transfer(sender, recipient, amount);
        return true;
    }

    function mintToken(uint amount) external {
        token_balance[msg.sender] += amount;
        totalTokens += amount;
        emit Token_Transfer(address(0), msg.sender, amount);
    }

    function burnToken(uint amount) external {
        require(token_balance[msg.sender] >= amount, "Insufficient balance");
        token_balance[msg.sender] -= amount;
        totalTokens -= amount;
        emit Token_Transfer(msg.sender, address(0), amount);
    }
}
