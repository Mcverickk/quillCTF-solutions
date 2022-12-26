const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const Attack = await ethers.getContractFactory("Attack");
  const amount = ethers.utils.parseEther("0.6");
  const attack = await Attack.deploy({ value: amount });

  console.log("Attack address:", attack.address);

  console.log("Destructing contract...");
  await attack.destruction();
  console.log("Funds transfered!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
