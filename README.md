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
- `INITCODE`: 
- `ADDRESS`: 
- Deployed to:
  - Optimism

## Updates and verifying on Etherscan

```
ETHERSCAN_API_KEY=abc forge verify-contract address Ad --watch --chain 10
```

## License

SPDX-License-Identifier: AGPL-3.0
