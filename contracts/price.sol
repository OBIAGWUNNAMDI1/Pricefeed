// SPDX-License-Identifier: MIT
// An example of a consumer contract that relies on a ethereum rinkeby to get the price of LINK/ETH from chainlink datafeeds.
pragma solidity ^0.8.4;
//import the needed contracts we want to use. 
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./IERC20.sol";
contract PriceFeedConsumer{

     AggregatorV3Interface internal priceFeed;
    /**
    *Network :Rinkeby Testnet
    *Aggregator = LINK/USD
    Aggregator address = 0xd8bD0a1cB028a31AA859A21A3758685a95dE4623
    *Decimal = 8 
    */
    uint8 public decimals; 
    int public ExchangeRate;
     constructor() {
        priceFeed = AggregatorV3Interface(0xd8bD0a1cB028a31AA859A21A3758685a95dE4623);
    }

    function getThePrice() public returns (int, uint) {
       
        (
            , 
            int price,
            ,
            ,
        ) = priceFeed.latestRoundData();
        ExchangeRate = price ;
        decimals = priceFeed.decimals();

        return (ExchandgRate, decimals);
    }

    function swapLinktoUsd(address tokenA, address TokenB, uint256 amount)public returns(uint256 TotalAmount){
        require(IERC20(tokenA).balanceOf >= amount , "insufficient amount in account");
        uint swaprate =uint256 (ExchangeRate) /decimals;
        TotalAmount = swaprate * amount;

    }

    function swapUsdtoLink(address tokenA , address TokenB, uint256 amount) public returns (uint TotalAmount){
          require(IERC20(tokenB).balanceOf >= amount , "insufficient amount in account");
        uint swaprate =uint256 (ExchangeRate) /decimals;
        TotalAmount = (amount *1000)/swaprate;


    }


}
