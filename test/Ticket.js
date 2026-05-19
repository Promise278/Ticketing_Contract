const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Ticket", function () {

  let factory;
  let owner;
  let user;

  beforeEach(async function () {

    [owner, user] = await ethers.getSigners();

    const TicketFactory =
      await ethers.getContractFactory(
        "TicketFactory"
      );

    factory = await TicketFactory.deploy();

    await factory.waitForDeployment();
  });

  it("Should create event", async function () {

    await factory.createEvent(
      "Blockchain Summit",
      ethers.parseEther("1"),
      100,
      2000000000,
      "Lagos"
    );

    const event =
      await factory.getSingleEvent(0);

    expect(event.name)
      .to.equal("Blockchain Summit");

    expect(event.location)
      .to.equal("Lagos");
  });

  it("Should update event", async function () {

    await factory.createEvent(
      "Old Event",
      ethers.parseEther("1"),
      100,
      2000000000,
      "Abuja"
    );

    await factory.updateEvent(
      0,
      "New Event",
      ethers.parseEther("2"),
      200,
      3000000000,
      "Lagos"
    );

    const event =
      await factory.getSingleEvent(0);

    expect(event.name)
      .to.equal("New Event");
  });

  it("Should delete event", async function () {

    await factory.createEvent(
      "Delete Me",
      ethers.parseEther("1"),
      100,
      2000000000,
      "Lagos"
    );

    await factory.deleteEvent(0);

    const event =
      await factory.getSingleEvent(0);

    expect(event.name).to.equal("");
  });

  it("Should prevent non creator update", async function () {

    await factory.createEvent(
      "Private Event",
      ethers.parseEther("1"),
      100,
      2000000000,
      "Lagos"
    );

    await expect(
      factory.connect(user).updateEvent(
        0,
        "Hack Event",
        ethers.parseEther("1"),
        100,
        2000000000,
        "Abuja"
      )
    ).to.be.revertedWith(
      "Not event creator"
    );
  });
});