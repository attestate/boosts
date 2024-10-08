# Boosts

Boosts allow a Kiwi News user to pay to increase the ranking of a story on the
Hot feed.

Let's say you have a story that you want Kiwi News users to see. But you know
that it'll be hard to mobilize people to upvote it. In this case you can opt to
boost the story. When you boost your story, Kiwi News will make sure that your
story is seen for a while on the Hot feed!

Here's how it works:

1. We aim to have 1 boost every 24 hours. If everyone agrees to just boost a
   story every 24 hours, then the price of the boost will be 0.000777 ether.
2. However, if the community decides to boost more than every 24 hours it'll
   cost quadratically (`x**2 * 0.000777 ether`) more to boost.

Here are the costs:

<img width="646" alt="Screenshot 2024-10-08 at 14 20 08" src="https://github.com/user-attachments/assets/a7e8cec6-a7f4-44bb-9d57-e59b08dedfdf">


## Deployment

CREATE2 is used to deploy the contract to a deterministic address independent
  of chainId.
- `DEPLOYER`: 0x0000000000ffe8b47b3e2130213b802212439497
- `SALT`: 0x0000000000000000000000000000000000000000f00df00df00df00df00df00d
- `INITCODE`: 0x608060405234801561001057600080fd5b50426000556103e5806100246000396000f3fe6080604052600436106100345760003560e01c80631afb8be714610039578063720e9fde1461004e578063a035b1fe14610076575b600080fd5b61004c6100473660046101ac565b61008b565b005b34801561005a57600080fd5b5061006460005481565b60405190815260200160405180910390f35b34801561008257600080fd5b50610064610157565b6000610095610157565b9050803410156100b8576040516349798bf960e11b815260040160405180910390fd5b426000556040517f549f9c330853d834bf1b2f13f6e7b234c7e1d3ef8100c0fb455120c43b6fe519906100ee908590859061021e565b60405180910390a1604051731337e2624ffec537087c6774e9a18031cfeaf0a9903490600081818185875af1925050503d806000811461014a576040519150601f19603f3d011682016040523d82523d6000602084013e61014f565b606091505b505050505050565b600080600054426101689190610263565b90506000610179826201518061027c565b90506001811015610188575060015b6607e3140766c00061019b600283610382565b6101a59190610398565b9250505090565b600080602083850312156101bf57600080fd5b823567ffffffffffffffff808211156101d757600080fd5b818501915085601f8301126101eb57600080fd5b8135818111156101fa57600080fd5b86602082850101111561020c57600080fd5b60209290920196919550909350505050565b60208152816020820152818360408301376000818301604090810191909152601f909201601f19160101919050565b634e487b7160e01b600052601160045260246000fd5b818103818111156102765761027661024d565b92915050565b60008261029957634e487b7160e01b600052601260045260246000fd5b500490565b600181815b808511156102d95781600019048211156102bf576102bf61024d565b808516156102cc57918102915b93841c93908002906102a3565b509250929050565b6000826102f057506001610276565b816102fd57506000610276565b8160018114610313576002811461031d57610339565b6001915050610276565b60ff84111561032e5761032e61024d565b50506001821b610276565b5060208310610133831016604e8410600b841016171561035c575081810a610276565b610366838361029e565b806000190482111561037a5761037a61024d565b029392505050565b600061039160ff8416836102e1565b9392505050565b80820281158282048414176102765761027661024d56fea26469706673582212209310f8f1cc4652a27fe4d9e9db973705be4c4adf938490c2ed8d2f8dbd76d3c564736f6c63430008110033
- `ADDRESS`: 0x62cdd4c9cbfd7f93b9e82c30d56517277310a1b7
- Deployed to:
  - Optimism

## Updates and verifying on Etherscan

```
ETHERSCAN_API_KEY=abc forge verify-contract address Ad --watch --chain 10
```

## License

SPDX-License-Identifier: AGPL-3.0
