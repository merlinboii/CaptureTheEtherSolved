pragma solidity 0.8.7;

interface GuessTheNumberChallenge {
    function isComplete() external view returns (bool);
    function guess(uint8 num) external payable; 
}

contract GuessTheNumberChallengeHack{
    GuessTheNumberChallenge public gtnInstance;
    uint256 public balance;

    constructor (GuessTheNumberChallenge _gtnInstance) {
        gtnInstance = _gtnInstance;
    }

    receive() external payable{}

    function attack() public payable{
        require(msg.value == 1 ether);
        gtnInstance.guess{value: msg.value}(42); 

        require(gtnInstance.isComplete(), "Attack is not complete");
        payable(tx.origin).transfer(address(this).balance);
    }
}