# Vip Bank

The [challenge](https://quillctf.super.site/challenges/quillctf-challenges/vip-bank) is to lock the VIP user balance forever into the contract.


## Vulnerability

In the Vip Bank, the contract wants to limit the withdrawal to `maxETH` (0.5 ETH) for the Vip addresses. But, the require statement instead of checking `_amount <= maxETH` check for  `address(this).balance <= maxETH`.

This introduces an attack point where if someone sends a lot of ether( >>0.5 ETH) to this contract, this `require` statement will always revert, and funds will get locked forever.

## Attack

To attack, we need to send ETH to the Vip Bank contract so that the contract balance exceeds 0.5 ETH, leading to the `require` statement reverting all the time, hence the funds getting locked. But, as the Vip Bank contract does not contain a `fallback` or `receive` function, we can not directly send ETH to the contract address.

We will create our [contract](./contracts/Attack.sol) and provide it with some ETH. We will create a function inside this contract which will `selfdestruct` on function call. `selfdestruct` is always provided with an address parameter, where the contract funds are transferred forcefully on contract destruction. We will give the Vip Bank contract address in the `selfdestruct` parameter and call for contract destruction. As our contract is destructed, the funds are transferred forcefully to Vip Bank, which will lead to the withdrawal of funds getting stopped.

