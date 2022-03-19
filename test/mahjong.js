const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MahjongDAO", function () {
  it("Should work", async function () {
    const accounts = await ethers.getSigners();

    const MahjongDAO = await ethers.getContractFactory("MahjongDAO");
    const mahjong = await MahjongDAO.deploy();
    await mahjong.deployed();

    expect(await mahjong['name()']()).to.equal('Mahjong DAO Tokens');
    expect(await mahjong['symbol()']()).to.equal('MAHJ');
    expect(await mahjong['balanceOf(address,uint256)'](accounts[0].address, 1)).to.equal(0);

    await mahjong['mint(address,uint256,uint256,bytes)'](accounts[0].address, 1, 1024, '0x');
    expect(await mahjong['balanceOf(address,uint256)'](accounts[0].address, 1)).to.equal(1024);

    try {
      await mahjong['safeTransferFrom(address,address,uint256,uint256,bytes)'](accounts[0].address, mahjong.address, 1, 1024, '0x');
      expect(false).to.equal(true);
    } catch (err) {
      expect(err.message).to.contain("reverted with reason string 'non ERC1155Receiver'")
    }

    const Airdrop = await hre.ethers.getContractFactory("MahjongDAOAirdrop");
    const airdrop = await Airdrop.deploy(mahjong.address);
    await airdrop.deployed();

    expect(await mahjong['balanceOf(address,uint256)'](airdrop.address, 1)).to.equal(0);
    await mahjong['safeTransferFrom(address,address,uint256,uint256,bytes)'](accounts[0].address, airdrop.address, 1, 1024, '0x');
    expect(await mahjong['balanceOf(address,uint256)'](airdrop.address, 1)).to.equal(1024);

    try {
      await airdrop['claim(uint256)'](1);
      expect(false).to.equal(true);
    } catch (err) {
      expect(err.message).to.contain("reverted with reason string 'airdrop not exists'")
    }

    await airdrop['setAirdrop(uint256,uint256)'](1, 100);
    await airdrop['claim(uint256)'](1);
    expect(await mahjong['balanceOf(address,uint256)'](airdrop.address, 1)).to.equal(924);
    expect(await mahjong['balanceOf(address,uint256)'](accounts[0].address, 1)).to.equal(100);

    try {
      await airdrop['claim(uint256)'](1);
      expect(false).to.equal(true);
    } catch (err) {
      expect(err.message).to.contain("reverted with reason string 'condition not met'")
    }
  });
});
