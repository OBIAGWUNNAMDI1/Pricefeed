// SPDX-License-Identifier: MIT
// An example of a consumer contract that relies on a ethereum rinkeby to get the price of LINK/ETH from chainlink datafeeds.
pragma solidity ^0.8.4;
//import the needed contracts we want to use. 
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
contract PriceFeedConsumer{

     AggregatorV3Interface internal priceFeed;
    /**
    *Network :Rinkeby Testnet
    *Aggregator = LINK/USD
    *Aggregator address = 0xd8bD0a1cB028a31AA859A21A3758685a95dE4623
    *Decimal = 8 
    */
     constructor() {
        priceFeed = AggregatorV3Interface(0xd8bD0a1cB028a31AA859A21A3758685a95dE4623);
    }

    function getThePrice() public view returns (int, uint) {
       
        (
            , 
            int price,
            ,
            ,
        ) = priceFeed.latestRoundData();
        uint decimal = priceFeed.decimals();

        return (price, decimal);
    }


}
