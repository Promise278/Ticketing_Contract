const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Ticket", function () {

  let ticket;
  let owner;
  let user;

  beforeEach(async function () {

    [owner, user] = await ethers.getSigners();

    const Ticket = await ethers.getContractFactory("TicketFactory");

    ticket = await Ticket.deploy();
  });

  it("Should create event", async function () {

    await ticket.createEvent(
      "Blockchain Summit",
      "BSM",
      ethers.parseEther("1"),
      100,
      2000000000,
      "Lagos"
    );

    const event = await ticket.getSingleEvent(0);

    expect(event.name).to.equal("Blockchain Summit");

    expect(event.location).to.equal("Lagos");
  });

  it("Should delete event", async function () {

    await ticket.createEvent(
      "Delete Me",
      "DEL",
      ethers.parseEther("1"),
      100,
      2000000000,
      "Lagos"
    );

    await ticket.deleteEvent(0);

    const allEvents = await ticket.getAllEvents();

    expect(allEvents.length).to.equal(0);
  });

  it("Should prevent non creator update", async function () {

    await ticket.createEvent(
      "Private Event",
      "PVT",
      ethers.parseEther("1"),
      100,
      2000000000,
      "Lagos"
    );

    await expect(
      ticket.connect(user).updateEvent(
        0,
        "Hack Event",
        ethers.parseEther("2"),
        100,
        3000000000,
        "Abuja"
      )
    ).to.be.revertedWith("Not creator");
  });

});