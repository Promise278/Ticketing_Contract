const { expect } = require("chai");
const { ethers }  = require("hardhat");

describe("Ticket", () => {
  let factory;

  beforeEach(async () => {
    factory = await (await ethers.getContractFactory("TicketFactory")).deploy();
  });

  it("starts with no events", async () => {
    expect((await factory.getAllEvents()).length).to.equal(0);
  });

  it("creates an event", async () => {
    await factory.createEvent("Dev Conf", "SYM", 100, 200, 9999999999, "Lagos");
    const event = await factory.getSingleEvent(0);
    expect(event.name).to.equal("Dev Conf");
    expect(event.price).to.equal(100);
    expect(event.maxTickets).to.equal(200);
    expect(event.soldTickets).to.equal(0);
    expect(event.location).to.equal("Lagos");
  });

  it("sets creator to msg.sender", async () => {
    const [owner] = await ethers.getSigners();
    await factory.createEvent("Dev Conf", "SYM", 100, 200, 9999999999, "Lagos");
    const event = await factory.getSingleEvent(0);
    expect(event.creator).to.equal(owner.address);
  });

  it("returns all events", async () => {
    await factory.createEvent("Event 1", "SYM", 100, 50, 9999999999, "Lagos");
    await factory.createEvent("Event 2", "SYM", 200, 100, 9999999999, "Abuja");
    expect((await factory.getAllEvents()).length).to.equal(2);
  });

  it("reverts on invalid index", async () => {
    await expect(factory.getSingleEvent(0)).to.be.revertedWith("Event does not exist");
  });
});