var HDWalletProvider = require("truffle-hdwallet-provider");

// Be sure to match this mnemonic with that in Ganache!
var mnemonic = "candy maple cake sugar pudding cream honey rich smooth crumble sweet treat";

module.exports = {
  networks: {
    // development: {
    //   provider: function() {
    //     return new HDWalletProvider(mnemonic, "http://127.0.0.1:8545/", 0, 10);
    //   },
    //   network_id: '*',
    //   gas: 9999999
    // },
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*", // Match any network id
      // gas: 4500000,        // rinkeby has a lower block limit than mainnet
      // gasPrice: 10000000000
    },
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      // version: "0.5.0",    // Fetch exact version from solc-bin (default: truffle's version)
      version: "0.4.25",      // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  }
};