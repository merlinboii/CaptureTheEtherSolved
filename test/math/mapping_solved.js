const ethers = require("ethereumjs-util");
const { BigNumber } = require ("ethers");

const arrayBeginSlot = BigNumber.from(
  ethers.keccakFromHexString(
    `0x0000000000000000000000000000000000000000000000000000000000000001`
  )
);
const overrideSlot = BigNumber.from(2).pow(256).sub(arrayBeginSlot)

console.log(arrayBeginSlot);
console.log(overrideSlot);

//THEN PASS (overrideSlot,1) to set() function => set(overrideSlot,1)
