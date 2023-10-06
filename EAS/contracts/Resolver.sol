// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import { SchemaResolver } from "@ethereum-attestation-service/eas-contracts/contracts/resolver/SchemaResolver.sol";


import { IEAS, AttestationRequest,AttestationRequestData } from "@ethereum-attestation-service/eas-contracts/contracts/IEAS.sol";
import { NO_EXPIRATION_TIME, EMPTY_UID,Attestation } from "@ethereum-attestation-service/eas-contracts/contracts/Common.sol";

/**
 * @title A sample schema resolver that checks whether the attestation is from a specific attester.
 */

 // EAS contract 0xA1207F3BBa224E2c9c3c6D5aF63D0eb1582Ce587
contract AttesterResolver is SchemaResolver {
    address private immutable _targetRecepient;

    constructor(IEAS eas, address targetRecepient) SchemaResolver(eas) {
        _targetRecepient = targetRecepient;
    }

    function onAttest(Attestation calldata attestation, uint256 /*value*/) internal view override returns (bool) {
        return attestation.recipient == _targetRecepient;
    }

    function onRevoke(Attestation calldata /*attestation*/, uint256 /*value*/) internal pure override returns (bool) {
        return true;
    }
}