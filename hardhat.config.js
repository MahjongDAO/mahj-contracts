const fs = require('fs');

require("dotenv").config();

require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-waffle");
require("hardhat-gas-reporter");
require("solidity-coverage");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});



// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    version: "0.8.9",
    settings: {
      optimizer: { // EIP 170: 24576
        enabled: true,
        runs: 4000000000
      }
    }
  },
  networks: {
    ropsten: {
      url: "https://ropsten.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
      chainId: 3,
      accounts:
        [fs.readFileSync("./.private_keys/test.key", "utf8").trim()],
    },
    avaxfuji: {
      url: "https://api.avax-test.network/ext/bc/C/rpc",
      chainId: 43113,
      accounts:
        [fs.readFileSync("./.private_keys/test.key", "utf8").trim()],
    },
    avax: {
      url: "https://api.avax.network/ext/bc/C/rpc",
      chainId: 43114,
      accounts:
        [fs.readFileSync("./.private_keys/main.key", "utf8").trim()],
    },
    ether: {
      url: "https://mainnet.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
      chainId: 1,
      accounts:
        [fs.readFileSync("./.private_keys/main.key", "utf8").trim()],
    },
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey: ""
  },
};
