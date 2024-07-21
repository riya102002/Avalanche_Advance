// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IGameToken {
    function totalTokens() external view returns (uint);
    function tokenBalance(address account) external view returns (uint);
    function transferToken(address recipient, uint amount) external returns (bool);
    function tokenAllowance(address owner, address spender) external view returns (uint);
    function approveToken(address spender, uint amount) external returns (bool);
    function transferTokenFrom(address sender, address recipient, uint amount) external returns (bool);
    function mintToken(uint amount) external;
    function burnToken(uint amount) external;
    event TokenTransfer(address indexed from, address indexed to, uint amount);
    event TokenApproval(address indexed owner, address indexed spender, uint amount);
}

contract GameVault {
    IGameToken public immutable gameToken;
    uint public totalShares;
    mapping(address => uint) public shareBalance;
    mapping(address => uint) public stakedBalance;
    mapping(address => uint) public stakingTimestamp;
    uint public rewardRate = 10; // reward rate in percentage per year

    constructor(address _token) {
        gameToken = IGameToken(_token);
    }

    function mintShares(address _to, uint _shares) private {
        totalShares += _shares;
        shareBalance[_to] += _shares;
    }

    function burnShares(address _from, uint _shares) private {
        totalShares -= _shares;
        shareBalance[_from] -= _shares;
    }

    function deposit_tokens(uint _amount) external {
        uint shares;
        if (totalShares == 0) {
            shares = _amount;
        } else {
            shares = (_amount * totalShares) / gameToken.tokenBalance(address(this));
        }
        mintShares(msg.sender, shares);
        gameToken.transferTokenFrom(msg.sender, address(this), _amount);
    }

    function withdrawTokens(uint _shares) external {
        uint amount = (_shares * gameToken.tokenBalance(address(this))) / totalShares;
        burnShares(msg.sender, _shares);
        gameToken.transferToken(msg.sender, amount);
    }

    function stakeTokens(uint _amount) external {
        require(_amount > 0, "Amount must be greater than zero");
        stakedBalance[msg.sender] += _amount;
        stakingTimestamp[msg.sender] = block.timestamp;
        gameToken.transferTokenFrom(msg.sender, address(this), _amount);
    }

    function unstakeTokens() external {
        uint staked = stakedBalance[msg.sender];
        require(staked > 0, "No staked tokens");
        uint stakingDuration = block.timestamp - stakingTimestamp[msg.sender];
        uint reward = (staked * rewardRate * stakingDuration) / (365 days * 100);
        stakedBalance[msg.sender] = 0;
        stakingTimestamp[msg.sender] = 0;
        gameToken.mintToken(reward);
        gameToken.transferToken(msg.sender, staked + reward);
    }
}
