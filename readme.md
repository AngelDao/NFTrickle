# NFTrickle

**Purpose**

NFTrickle is a NFTHack 2021 project, utilizing erc20, erc1155 and [SuperFluid](https://docs.superfluid.finance/superfluid/). This project is meant to offer a unique pattern that might be useful for selling erc1155 and giving proportional ownership to contributers within a given timeframe using the SuperFluid framework.

## Contracts

- Shop
- ShopFactory

## ShopFactory

The ShopFactory is called by the seller of the NFT which then mints a Shop and moves the sellers NFT to the Shop in escrow for the length of the Shops sale, which is given by the seller.

## Shop

The Shop holds the NFT in escrow and receives the outflows of the streams until the endBlock given buy the seller is reached. Once it is reached the stop function can be called by anyone which will end all streams collect the sum of all flows by each buyer then send the seller the sum.

The buyers must individually claim their NFT by calling the claim function which simply distributes to them their portion of the NFT based on their contribution to the Shop.
