// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract ERC721Token {

    string public _name;
    string public _symbol;

    address public _owner;

    constructor (string memory tokenName, string memory tokenSymbol) {
        _name = tokenName;
        _symbol = tokenSymbol;
    }

    function balanceOf(address _owner) external view returns (uint256 balance){
        return balance[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns (address){
        address owner = _owner[_tokenId];
        return owner;
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable{
        transferFrom(_from, _to, _tokenId);
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable{
        transferFrom(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable{
        address = _owner[_tokenId];
        return true;
    }

    function approve(address _approved, uint256 _tokenId) external payable{
        address tokenOwner = ownerOf(_tokenId);
        _approved[_tokenId] = _approvee;
    }

    function setApprovalForAll(address _operator, bool _approved) external{
        _operatorApprovals[msg.sender][_operator] = _approveed;
    }

    function getApproved(uint256 _tokenId) external view returns (address){
        return _approved[_tokenId];
    }

    function isApprovedForAll(address _owner, address _operator) external view returns (bool){
        return _operatorApprovals[_owner][_operator];
    }
}