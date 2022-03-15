// SPDX-License-Identifier: MIT
// An example of a consumer contract that relies on a arbitum rinkeby to get the price of LINK/ETH from chainlink datafeeds.
pragma solidity ^0.8.4;
//import the needed contracts we want to use. 
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.8/interfaces/FlagsInterface.sol";
contract PriceFeedConsumer{

AggregatorV3Interface internal priceFeed;
    constructor(address aggregatorAddress) {
        priceFeed = AggregatorV3Interface(aggregatorAddress);
    }

//Identifier of the Sequencer offline flag on the Flags contract 
    // address constant private FLAG_ARBITRUM_SEQ_OFFLINE = address(bytes20(bytes32(uint256(keccak256("chainlink.flags.arbitrum-seq-offline")) - 1)));
    // FlagsInterface internal chainlinkFlags;

    // constructor(){
    //     chainlinkFlags = FlagsInterface(0x491B1dDA0A8fa069bbC1125133A975BF4e85a91b);
    // }
    /**
    *Network :Ethereum Rinkeby
    *Aggregator = LINK/ETH
    *Aggregator address = 0xFABe80711F3ea886C3AC102c81ffC9825E16162E
    */

    function getThePrice() public view returns (int) {
        //  bool isRaised = chainlinkFlags.getFlag(FLAG_ARBITRUM_SEQ_OFFLINE);
        // if (isRaised) {
        //     // If flag is raised we shouldn't perform any critical operations
        //     revert("Chainlink feeds are not being updated");
        // }

        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint updatedAt,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();

        return price;
    }


}

contract SwapTokens {

     function approve(address spender, uint value) external returns (bool){}

