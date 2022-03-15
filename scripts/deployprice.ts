import { ethers } from "hardhat";
import { Signer } from "ethers";

async function main() {
  const Aggregatoraddress = "0xFABe80711F3ea886C3AC102c81ffC9825E16162E";
  const UNIROUTER = "0xf164fC0Ec4E93095b804a4795bBe1e041497b92a";
  const linkAddress = "0x514910771AF9Ca656af840dff83E8264EcF986CA";
  
  const Price = await ethers.getContractFactory("PriceFeedConsumer");
  const PriceFeed = await Price.deploy(Aggregatoraddress);
  PriceFeed.deployed();
  await PriceFeed.deployed();

  console.log(await PriceFeed.getThePrice());
  console.log("Greeter deployed to:", PriceFeed.address);
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
