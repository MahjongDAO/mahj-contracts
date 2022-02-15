const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Mahjong", function () {
  it("Should return the new greeting once it's changed", async function () {
    const accounts = await ethers.getSigners();

    for (const account of accounts) {
      console.log(account.address);
    }
    const Mahjong = await ethers.getContractFactory("Mahjong");
    const mahjong = await Mahjong.deploy();
    await mahjong.deployed();

    expect(await mahjong.greet()).to.equal("Hello, world!");

    const setGreetingTx = await mahjong.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await mahjong.greet()).to.equal("Hola, mundo!");
  });
});
