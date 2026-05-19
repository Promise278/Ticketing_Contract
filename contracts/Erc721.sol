// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract ERC721Token {
    string  public _name;
    string  public _symbol;
    address public contractOwner;

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => address) private _approvals;
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    constructor(string memory tokenName, string memory tokenSymbol) {
        _name         = tokenName;
        _symbol       = tokenSymbol;
        contractOwner = msg.sender;
    }

    function balanceOf(address _owner) external view returns (uint256) {
        return _balances[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        return _owners[_tokenId];
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        _balances[_from]  -= 1;
        _balances[_to]    += 1;
        _owners[_tokenId]  = _to;
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external {
        transferFrom(_from, _to, _tokenId);
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external {
        transferFrom(_from, _to, _tokenId);
    }

    function approve(address _approvee, uint256 _tokenId) external {
        _approvals[_tokenId] = _approvee;
    }

    function setApprovalForAll(address _operator, bool _approved) external {
        _operatorApprovals[msg.sender][_operator] = _approved;
    }

    function getApproved(uint256 _tokenId) external view returns (address) {
        return _approvals[_tokenId];
    }

    function isApprovedForAll(address _owner, address _operator) external view returns (bool) {
        return _operatorApprovals[_owner][_operator];
    }
}