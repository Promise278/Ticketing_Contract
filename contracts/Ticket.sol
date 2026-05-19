// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract TicketFactory {
    struct Event {
      string name;
      uint256 price;
      uint256 maxTickets;
      uint256 soldTickets;
      uint256 date;
      string location;
      address creator;
    }

    Event[] public events;

    function createEvent( string memory _name, string memory _symbol, uint256 _price, uint256 _maxTickets, uint256 _date, string memory _location) public {
      require(bytes(_name).length > 0, "Event name required");
      require(_price > 0, "Event Price is required");
      
      events.push(Event({
        name: _name,
        price: _price,
        maxTickets: _maxTickets,
        soldTickets: 0,
        date: _date,
        location: _location,
        creator: msg.sender
      }));
    }

    function getAllEvents() public view returns (Event[] memory) {
      return events;
    }

    function getSingleEvent(uint256 _index) public view returns (Event memory) {
      require(_index < events.length, "Event does not exist");
      return events[_index];
    }

    function deleteEvent(uint256 _index) public returns (Event memory) {
      require(_index < events.length, "Event does not exist");
      Event storage eventItem = events[_index];
      delete events[_index];
    }
}