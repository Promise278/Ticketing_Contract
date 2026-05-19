// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract Erc20Token {

    string public _name;
    string public _symbol;
    uint8 public _decimals = 18;

    address public owner;
    uint256 private _totalSupply;

    constructor (string memory tokenName, string memory tokenSymbol, uint256 initialSupply) {
        _name = tokenName;
        _symbol = tokenSymbol;
        _decimals = 18;
        _totalSupply = initialSupply * decimals;
    }

    function name() public view returns (string){
        return _name;
    }

    function symbol() public view returns (string){
        return _symbol;
    }

    function decimals() public view returns (uint8){
        return _decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balance[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        approve[_from][msg.sender] -= _value;
        balanceOf[_from]             -= _value;
        balanceOf[_to]               += _value;
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        approve[msg.sender][_spender] = _value;
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return approve[_owner][_spender];
    }
    
}