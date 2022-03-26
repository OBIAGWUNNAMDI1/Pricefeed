import { ethers } from "hardhat";
import { BigNumber, Signer } from "ethers";

async function Swap() {
  const UNIROUTER = "0xf164fC0Ec4E93095b804a4795bBe1e041497b92a";
  const LINKAddress = "0x514910771AF9Ca656af840dff83E8264EcF986CA";
  const LINKHolder = "0x7abe0ce388281d2acf297cb089caef3819b13448";
  const UsdtAddress = "0xdAC17F958D2ee523a2206206994597C13D831ec7";
  const WETHAddress = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2";
  const amount = ethers.utils.parseUnits("1500", 18);
  const signer = await ethers.getSigner(LINKHolder);
  const Router = await ethers.getContractAt("IRouter", UNIROUTER, signer);
  const linkContract = await ethers.getContractAt(
    "IERC20",
    LINKAddress,
    signer
  );
  const UsdtContract = await ethers.getContractAt(
    "IERC20",
    UsdtAddress,
    signer
  );
  // console.log(`balance before ${await linkContract.balanceOf(LINKHolder)}`);
  // console.log(`balance before ${await UsdtContract.balanceOf(LINKHolder)}`);

  // account impersonantion of the linkHolder so we can use his account.
  // @ts-ignore
  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [LINKHolder],
  });
  // approving the UNIROUTER TO SPEND THE AMOUNT STATED.
  await linkContract.approve(UNIROUTER, amount);
  console.log(`swapping ${amount} LINK`);

  // THIS SWAPS THE LINK TO USDT.
  /**
   * For Swapping you need the amount to be swapped, the path from the from account to the to account
   * address to which is the LINKHOLDER account
   * Timeframe
   */

  // Swaps from LINK TO USDT
  const SwapLINKUSDT = await Router.swapExactTokensForTokens(
    amount,
    100,
    [LINKAddress, WETHAddress, UsdtAddress],
    LINKHolder,
    1647451431
  );
  console.log(SwapLINKUSDT);
  console.log(`Balance now is ${await UsdtContract.balanceOf(LINKHolder)}`);

  
}
Swap().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
