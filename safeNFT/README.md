# safeNFT

The [challenge](https://quillctf.super.site/challenges/quillctf-challenges/bulletproof-nft) is to claim multiple NFTs for the price of one.

## Vulnerability

In the safeNFT contract, a user can buy an NFT using `buyNFT`, and they need to claim it using `claim()`. The problem is that the safeNFT contract updates the `canClaim` after sending the NFT. This creates a reentrancy vulnerability in the safeNFT contract.

## Attack

As we know there is a reentrancy vulnerability, we created a [contract](./contracts/Attack.sol) to exploit it.

We imported OpenZeppelin's `IERC721Receiver.sol` to execute some statements whenever our contract receives an NFT. To exploit reentrancy, we will repeatedly call the `claim()` function inside `onERC721Received` whenever we receive an NFT. This leads to the safeNFT contract minting us NFTs repeatedly because they still need to update their state on each NFT transfer. As it can lead to an infinite loop due to unlimited supply, we will limit our NFT mint to 6 NFTs. After the entire 6 NFTs are minted, the state is then updated in the safeNFT contract.
