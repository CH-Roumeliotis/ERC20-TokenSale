const CHRToken = artifacts.require("contracts/ERC20basic.sol");
const TokenSale = artifacts.require("contracts/Sale.sol");

module.exports = async function (deployer) {
    await deployer.deploy(CHRToken, 1000000);
    const tokenInstance = await CHRToken.deployed();
    
    await deployer.deploy(TokenSale, tokenInstance.address, 1000000000000000);
    const saleInstance = await TokenSale.deployed();

    await tokenInstance.transfer(saleInstance.address, "5000000");
};