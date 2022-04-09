const EthUtil = require("ethereumjs-util");
const {Transaction} = require("ethereumjs-tx");
requrie('dotenv').config
var Web3 = require("web3");
var web3 = new Web3(
  Web3.givenProvider ||
    process.env.PROVIDER_URL // url of ropsten wss provider
);

/**
 * @desc We can find public key if we know the raw Tx hash of any address
 */
const getPublicKey = async () => {
  const TxData = await web3.eth.getTransaction(
    "0xabc467bedd1d17462fcc7942d0af7874d6f8bdefee2b299c9168a216d3ff0edb"
  );

  const TxFilter = {
    gasLimit: parseInt(TxData.gas),
    gasPrice: parseInt(TxData.gasPrice),
    data: TxData.input,
    nonce: TxData.nonce == 0 ? '0x0' : TxData.nonce,
    r: TxData.r,
    s: TxData.s,
    v: TxData.v,
    to: TxData.to,
    value: TxData.value == 0 ? '0x0' : TxData.value,               
  }

  const txRaw = new Transaction(
    TxFilter,
    { chain: 'ropsten', hardfork: 'petersburg' },
  )

  const address = EthUtil.bufferToHex(txRaw.getSenderAddress());
  const publicKey = EthUtil.bufferToHex(txRaw.getSenderPublicKey());

  console.log(`Address : ${address}`);
  console.log(`Public key: ${publicKey}`);
};

getPublicKey();
