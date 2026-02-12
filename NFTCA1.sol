// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTCA1 is ERC721, Ownable {
    uint256 public tokenCounter;

    mapping(uint256 => string) private _tokenURIs;

    constructor()
        ERC721("NFT CA1", "NFTCA")
        Ownable(msg.sender)
    {
        tokenCounter = 0;
    }

    function mintAssetNFT(
        address recipient,
        string memory metadataURI
    ) public onlyOwner returns (uint256) {
        uint256 newTokenId = tokenCounter;
        _safeMint(recipient, newTokenId);
        _setTokenURI(newTokenId, metadataURI);
        tokenCounter++;
        return newTokenId;
    }

    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        _tokenURIs[tokenId] = uri;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(ownerOf(tokenId) != address(0), "Token does not exist");
        return _tokenURIs[tokenId];
    }
}
