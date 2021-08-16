pragma solidity >=0.4.22 <0.9.0;

import "contracts/ERC20basic.sol";

contract tokenSale {
    address payable owner;
    CHRToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event sell(address _buyer, uint256 _amount);

    constructor(CHRToken _tokenContract, uint256 _tokenPrice) public {
        owner = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(
            msg.value == _numberOfTokens * tokenPrice,
            "Number of tokens does not match with the value"
        );
        require(
            tokenContract.balanceOf(address(this)) >= _numberOfTokens,
            "Contact does not have enough tokens"
        );
        require(
            tokenContract.transfer(msg.sender, _numberOfTokens),
            "Some problem with token transfer"
        );
        tokensSold += _numberOfTokens;
        emit sell(msg.sender, _numberOfTokens);
    }

    function endSale() public {
        require(msg.sender == owner, "Only the owner");
        require(
            tokenContract.transfer(
                msg.sender,
                tokenContract.balanceOf(address(this))
            ),
            "Unable to transfer tokens"
        );
        // destroy contract
        selfdestruct(owner);
    }
}