import { ethers } from "hardhat";

async function main() {
  const Price = await ethers.getContractFactory("PriceFeedConsumer");
  const PriceFeed = await Price.deploy();
  await PriceFeed.deployed();
  const price = await PriceFeed.getThePrice()

  console.log("PricFeed deployed to:", PriceFeed.address);
  console.log(`The price of 1INCH/USD is ${price}`);
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
