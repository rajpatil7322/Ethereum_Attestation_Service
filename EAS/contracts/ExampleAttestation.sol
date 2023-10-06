// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import { IEAS, AttestationRequest,AttestationRequestData } from "@ethereum-attestation-service/eas-contracts/contracts/IEAS.sol";
import { NO_EXPIRATION_TIME, EMPTY_UID,Attestation } from "@ethereum-attestation-service/eas-contracts/contracts/Common.sol";
import { ISchemaRegistry,SchemaRecord } from "@ethereum-attestation-service/eas-contracts/contracts/ISchemaRegistry.sol";
import { ISchemaResolver } from "@ethereum-attestation-service/eas-contracts/contracts/resolver/ISchemaResolver.sol";


 // EAS contract 0xA1207F3BBa224E2c9c3c6D5aF63D0eb1582Ce587
 // Schema contract 0xA7b39296258348C78294F95B872b282326A97BDF
  // Schema 0x58893d0ecae362308f222c9cc2afab6e20cfaf5ae03c723a84e8c1c9ca6b909e
  // 0x0000000000000000000000000000000000000000
contract ExampleAttester {
    error InvalidEAS();

    // The address of the global EAS contract.
    IEAS private  _eas=IEAS(0xA1207F3BBa224E2c9c3c6D5aF63D0eb1582Ce587);

    ISchemaRegistry private  _schemaregistry=ISchemaRegistry(0xA7b39296258348C78294F95B872b282326A97BDF);

   

    function attestUint(bytes32 schema,bool _isdeveloper) external returns (bytes32) {
        return
            _eas.attest(
                AttestationRequest({
                    schema: schema,
                    data: AttestationRequestData({
                        recipient: msg.sender, // No recipient
                        expirationTime: NO_EXPIRATION_TIME, // No expiration time
                        revocable: true,
                        refUID: EMPTY_UID, // No references UI
                        data: abi.encode(_isdeveloper), // Encode a single uint256 as a parameter to the schema
                        value: 0 // No value/ETH
                    })
                })
            );
    }

    function getRecepient(bytes32 attestUid) public view returns(address){
        Attestation memory data=_eas.getAttestation(attestUid);
        return data.recipient;
    }

    function get(bytes32 schemauid) public view returns(string memory){
        SchemaRecord memory data=_schemaregistry.getSchema(schemauid);
        return data.schema;
    }

    function registerSchema(string memory schema,ISchemaResolver _resolver,bool _revcoable) public returns(bytes32){
        return _schemaregistry.register(schema, _resolver, _revcoable);
    }
}