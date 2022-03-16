import { ethers } from "hardhat";
import { BigNumber, Signer } from "ethers";

async function Swap() {
  const UNIROUTER = "0xf164fC0Ec4E93095b804a4795bBe1e041497b92a";
  const InchAddress = "0x111111111117dC0aa78b770fA6A738034120C302";
  const InchHolder = "0x23360d94c13c1508bda63beb5a404b9e2e3f62b5";
  const UsdtAddress = "0xdAC17F958D2ee523a2206206994597C13D831ec7";
  const WETHAddress = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2";
  const amount = new BigNumber(100e18);
  const signer = await ethers.getSigner(InchHolder);
  const Router = await ethers.getContractAt("IRouter", UNIROUTER, signer);
  const linkContract = await ethers.getContractAt("IERC20", InchAddress);
  const UsdtContract = await ethers.getContractAt("IERC20", UsdtAddress);
  //   console.log(`balance before ${await linkContract.balanceOf(InchHolder)}`);
  //   console.log(`balance before ${await UsdtContract.balanceOf(InchHolder)}`);

  // account impersonantion of the linkHolder so we can use his account.
  // @ts-ignore
  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [InchHolder],
  });
  // approving the UNIROUTER TO SPEND THE AMOUNT STATED.
  await linkContract.approve(UNIROUTER, amount);
  console.log(`swapping ${amount} LINK`);
  // THIS SWAPS THE LINK TO USDT.
  await Router.swapExactTokensForTokens(
    amount,
    1000,
    [InchAddress, WETHAddress, UsdtAddress],
    InchHolder
  );
}
Swap().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
