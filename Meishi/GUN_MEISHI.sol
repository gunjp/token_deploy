// SPDX-License-Identifier: MIT
// 2023-06-07 @auther gun_bkup

pragma solidity ^0.8.9;
import "@openzeppelin/contracts@4.9.0/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts@4.9.0/access/AccessControl.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.9.0/utils/Strings.sol";

contract GUN_MEISHI is ERC1155, AccessControl, Ownable {
    constructor() ERC1155("") {
        _grantRole(ADMIN, msg.sender);
    }
    // CONST
    using Strings for uint256;
    bytes32 public constant ADMIN = "ADMIN";
    string public name = "GUN`S MEISHI";
    string public symbol = "GUN-MEISHI";
    string private _baseUri;
    string private _extension = ".json";

    // ROLE
    function grantRole(bytes32 role, address account) public override onlyOwner {
        _grantRole(role, account);
    }
    function revokeRole(bytes32 role, address account) public override onlyOwner {
        _revokeRole(role, account);
    }

    // URI
    function setBaseUri(string memory baseUri) external onlyRole(ADMIN) {
        _baseUri = baseUri;
    }
    function uri(uint256 tokenId) public view virtual override returns (string memory) {
        return string(abi.encodePacked(_baseUri, tokenId.toString(), _extension));
    }

    // MINT
    function mint(address account, uint256 id, uint256 amount, bytes memory data) public onlyOwner {
        _mint(account, id, amount, data);
    }
    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public onlyOwner{
        _mintBatch(to, ids, amounts, data);
    }
    function AirDrop(address[] memory list, uint256 id) external onlyRole(ADMIN) {
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

    // interface
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155, AccessControl) returns (bool) {
        return
            AccessControl.supportsInterface(interfaceId) ||
            ERC1155.supportsInterface(interfaceId);
    }
}
