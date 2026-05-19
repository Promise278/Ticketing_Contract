// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./Erc20.sol";

contract FactoryContract {
    struct Tokens {
        string name;
        string symbol;
        uint8 decimals;
        address  creator;
    }

    Tokens[] public tokens;

    event TokenCreated( string name, string symbol, uint8 decimals, address indexed creator);

    function createToken(string memory _name, string memory _symbol) public {
        EventToken newToken = new EventToken(_name, _symbol);
        uint8 tokenDecimals = newToken.decimals();

        tokens.push(Token({
            name: _name,
            symbol: _symbol,
            decimals: tokenDecimals,
            creator: msg.sender
        }));
        emit TokenCreated( _name, _symbol, tokenDecimals);
    }

    function getAllToken() public view returns (Tokens[] memory) {
      return tokens;
    }
}