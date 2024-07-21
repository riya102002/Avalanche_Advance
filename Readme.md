
# GameToken and GameVault Contracts

## Overview

GameToken and GameVault are the two primary contracts for this project. An implementation of an ERC-20 token with minting and burning features is the GameToken contract. Users can deposit, withdraw, stake, and unstake GameToken tokens using the GameVault contract. Additionally, the GameVault has a staking feature that pays out to users according on how long they stake.

## Contracts

### GameToken

`GameToken` is an ERC-20 token with the following features:
- Transfer tokens
- Approve tokens for spending
- Transfer tokens on behalf of others
- Mint new tokens
- Burn tokens

### GameVault

`GameVault` interacts with the `GameToken` contract to provide the following functionalities:
- Deposit `GameToken` tokens to receive shares
- Withdraw `GameToken` tokens by burning shares
- Stake `GameToken` tokens to earn rewards
- Unstake tokens to receive the staked amount plus rewards

## Deployment

### Deploying GameToken

1. Gather the contract for {GameToken}.
2. Set up the `GameToken} contract on the blockchain network of your choice.

### Deploying GameVault

1. Gather the contract for {GameVault}.
2. Integrate the `GameVault` contract into the `GameToken` contract's blockchain network.
3. Give the GameVault constructor the deployed GameToken contract address as a parameter.

## Usage

### Minting Tokens

To mint tokens, call the `mintToken` function from an account. This will increase the total token supply and credit the minted tokens to the caller's balance.

### Burning Tokens

To burn tokens, call the `burnToken` function from an account. This will decrease the caller's balance and reduce the total token supply.

### Transferring Tokens

To transfer tokens to another account, use the `transferToken` function specifying the recipient and the amount.

### Approving Tokens

To approve another account to spend your tokens, use the `approveToken` function specifying the spender and the amount.

### Depositing Tokens into the Vault

Use the `deposit_tokens` function with the desired deposit amount to place tokens into the vault and obtain shares.

### Withdrawing Tokens from the Vault

To withdraw tokens from the vault, use the `withdrawTokens` function specifying the amount of shares to burn.

### Staking Tokens

Use the `stakeTokens` function with the desired amount to stake in order to begin collecting rewards for staking tokens.

### Unstaking Tokens

To unstake tokens and receive the staked amount plus rewards, use the `unstakeTokens` function.

## License

This project is licensed under the MIT License.

## Author

@RiyaKesharwani [https://github.com/riya102002]
