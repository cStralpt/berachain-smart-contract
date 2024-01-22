import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";
import * as dotenv from "dotenv";
const env = dotenv.config().parsed;

const config: HardhatUserConfig = {
  solidity: "0.8.19",
  networks: {
    // For localhost network
    hardhat: {
      chainId: 1337,
    },
    // NOTE: hardhat viem currently doesn't yet support this method for custom chains through Hardhat config ↴
    berachainTestnet: {
      chainId: parseInt(`${env.CHAIN_ID}`),
      url: `${env.RPC_URL || ""}`,
      accounts: env.WALLET_PRIVATE_KEY ? [`${env.WALLET_PRIVATE_KEY}`] : [],
    },
  },
  // For Contract Verification
  etherscan: {
    apiKey: `${env.BLOCK_EXPLORER_API_KEY}`,
    customChains: [
      {
        network: "Berachain Testnet",
        chainId: parseInt(`${env.CHAIN_ID}`),
        urls: {
          apiURL: `${env.BLOCK_EXPLORER_API_URL}`,
          browserURL: `${env.BLOCK_EXPLORER_URL}`,
        },
      },
    ],
  },
};

export default config;
