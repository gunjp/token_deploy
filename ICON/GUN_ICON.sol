// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GUN_ICON is ERC721, Ownable {
    constructor() ERC721("GUN_ICON", "GUN_ICON") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://storage.gunjp.xyz/ICON/";
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }
}
