pragma solidity 0.8.7;

interface IGuessTheSecretNumberChallenge {
    function isComplete() external view returns (bool);
    function guess(uint8) external payable; 
}

contract GuessTheSecretNumberChallengeHack {
    IGuessTheSecretNumberChallenge public gtnInstance;
    bytes32 answerHash = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;

    constructor (IGuessTheSecretNumberChallenge _gtnInstance) {
        gtnInstance = _gtnInstance;
    }

    receive() external payable{}

    function attack() public payable{
        require(msg.value == 1 ether);
        uint8 number;
        while (keccak256(abi.encodePacked(number)) != answerHash) {
            number++;
        }
        gtnInstance.guess{value: msg.value}(number);    

        require(gtnInstance.isComplete(), "Attack is not complete");
        payable(tx.origin).transfer(address(this).balance);
    }
}