// SPDX-License-Identifier: MIT
// An example of a consumer contract that relies on a arbitum rinkeby to get the price of LINK/ETH from chainlink datafeeds.
pragma solidity ^0.8.4;
//import the needed contracts we want to use. 
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
contract PriceFeedConsumer{

     AggregatorV3Interface internal priceFeed;
    /**
    *Network :Ethereum Mainnet
    *Aggregator = 1INCH/USD
    *Aggregator address = 0xc929ad75B72593967DE83E7F7Cda0493458261D9
    *Decimal = 8 
    */
     constructor() {
        priceFeed = AggregatorV3Interface(0xc929ad75B72593967DE83E7F7Cda0493458261D9);
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
