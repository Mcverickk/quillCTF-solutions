# Road Closed

The [challenge](https://quillctf.super.site/challenges/quillctf-challenges/road-closed) is to 

1. Become the owner of the contract 

2. Change the value of hacked to `true`.

## Vulnerability

What we want to do is to become the owner of the contract and to change the value of `hack` to true. If we go through this contract, we'll see we want to call three functions. First, we want to call `addToWhitelist` to add our address to the whitelist. Secondly, we want to call `changeOwner` to change the ownership to our address and finally; we want to call the `pwn` function with the parameter so that we can change the value of hack to true. These functions contain a common `require` statement to check if the address is a contract address. It is done by calling the `isContract` function, which uses `size := extcodesize(addr)` to calculate the contract size. The contract size for a deployed smart contract is >0 & for an EOA is 0.

The vulnerability here is that the size of a contract is non-zero only after the contract is deployed and not while it is being deployed. If we call `isContract` from the constructor of a smart contract, then the contract size will be 0, and hence the return value will be false.

Let's see how we can use it to attack the contract.


## Attack

Create a [smart contract](./contracts/Attack.sol) which will call the following functions in the Road Block contract in the following order. We will call these functions from the constructor of our contract to attack the vulnerability we discussed above.
1.	`addToWhitelist(address addr)` 
2.	`changeOwner(address addr)`
3.	`pwn(address addr)`

The moment our contract is deployed, it will call these functions inside the Road Block contract and make our contract address the owner and change the value of `hack` to true.

