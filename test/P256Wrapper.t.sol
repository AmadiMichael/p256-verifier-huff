// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import "forge-std/Test.sol";
import {stdJson} from "forge-std/StdJson.sol";
import {HuffDeployer} from "lib/foundry-huff/src/HuffDeployer.sol";

interface P256 {
    function verifySignatureAllowMalleability(bytes32 message_hash, uint256 r, uint256 s, uint256 x, uint256 y)
        external
        view
        returns (bool);

    function verifySignature(bytes32 message_hash, uint256 r, uint256 s, uint256 x, uint256 y)
        external
        view
        returns (bool);
}

contract P256Test is Test {
    uint256[2] public pubKey;
    P256 p256;

    function setUp() public {
        address verifier = HuffDeployer.config().with_evm_version("paris").deploy("P256HuffVerifier/Verifier");
        p256 = P256(
            HuffDeployer.config().with_code(
                string.concat("\n #define constant VERIFIER_ADDRESS = ", vm.toString(verifier))
            ).with_evm_version("paris").deploy("P256SamplePoc")
        );

        pubKey = [
            0x65a2fa44daad46eab0278703edb6c4dcf5e30b8a9aec09fdc71a56f52aa392e4,
            0x4a7a9e4604aa36898209997288e902ac544a555e4b5e0a9efef2b59233f3f437
        ];
    }

    function testMalleable() public {
        // Malleable signature. s is > n/2
        uint256 r = 0x01655c1753db6b61a9717e4ccc5d6c4bf7681623dd54c2d6babc55125756661c;
        uint256 s = 0xf073023b6de130f18510af41f64f067c39adccd59f8789a55dbbe822b0ea2317;

        bytes32 hash = 0x267f9ea080b54bbea2443dff8aa543604564329783b6a515c6663a691c555490;

        bool res = p256.verifySignatureAllowMalleability(hash, r, s, pubKey[0], pubKey[1]);
        assertEq(res, true);

        res = p256.verifySignature(hash, r, s, pubKey[0], pubKey[1]);
        assertEq(res, false);
    }

    function testNonMalleable() public {
        // Non-malleable signature. s is <= n/2
        uint256 r = 0x01655c1753db6b61a9717e4ccc5d6c4bf7681623dd54c2d6babc55125756661c;
        uint256 s = 7033802732221576339889804108463427183539365869906989872244893535944704590394;

        bytes32 hash = 0x267f9ea080b54bbea2443dff8aa543604564329783b6a515c6663a691c555490;

        bool res = p256.verifySignatureAllowMalleability(hash, r, s, pubKey[0], pubKey[1]);
        assertEq(res, true);

        res = p256.verifySignature(hash, r, s, pubKey[0], pubKey[1]);
        assertEq(res, true);
    }
}
