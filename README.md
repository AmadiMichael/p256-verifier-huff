## P256 Curve Verifier Huff implementation

Secp256r1 (a.k.a p256) curve signature verifier rewritten and optimized in [Huff Language](https://huff.sh). This was greatly inspired by [dcposch's](https://github.com/dcposch) and [nalinbhardwaj's](https://github.com/nalinbhardwaj) implementation [here](https://github.com/daimo-eth/p256-verifier/blob/master/src/P256Verifier.sol) and [pcaversaccio's](https://github.com/pcaversaccio) Vyper implementation [here](https://github.com/pcaversaccio/p256-verifier-vyper/blob/main/src/P256Verifier.vy). Also, for more technical details, please refer to [EIP-7212](https://eips.ethereum.org/EIPS/eip-7212).

    This is experimental software and is provided on an "as is" and "as available" basis. We do not give any warranties and will not be liable for any losses incurred through any use of this code base.

### Benchmark

- [Solidity p256 Verifier](https://github.com/daimo-eth/p256-verifier/blob/master/src/P256Verifier.sol): 330,000 gas
- [Huff p256 Verifier](https://github.com/AmadiMichael/p256-verifier-huff/blob/master/src/P256Verifier/Verifier.huff): 240,000 gas

### Further References

- Daimo's GitHub Repository: [daimo-eth/p256-verifier](https://github.com/daimo-eth/p256-verifier)
- Daimo's Blog: [blog/p256verifier](https://daimo.xyz/blog/p256verifier)
- Daimo's Website: [p256.eth.limo](https://p256.eth.limo/)
