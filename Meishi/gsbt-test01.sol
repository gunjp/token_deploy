// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.9.0/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract Gsbt_test is ERC1155, Ownable {
    constructor() ERC1155("") {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    function AirDrop(address[] memory list, uint256 id) public onlyOwner {
        require(bytes(uri(id)).length != 0, "Not initialized");
        for (uint256 i = 0; i < list.length; i++) {
            _mint(list[i], id, 1, "");
        }
    }

    // SBT - override
    function setApprovalForAll(address, bool) public virtual override {
        revert("SBT...");
    }
    function _beforeTokenTransfer(address, address from, address to, uint256[] memory ids, uint256[] memory, bytes memory) internal virtual override {
        for (uint256 i = 0; i < ids.length; i++) {
            require(from == address(0) || to == address(0), "SBT...");
        }
    }
}
