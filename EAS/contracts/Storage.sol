// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import { Attestation } from "@ethereum-attestation-service/eas-contracts/contracts/Common.sol";
import { IEAS} from "@ethereum-attestation-service/eas-contracts/contracts/IEAS.sol";
import  {ExampleAttester} from  "./ExampleAttestation.sol";

contract Storage {
    IEAS private  _eas=IEAS(0xA1207F3BBa224E2c9c3c6D5aF63D0eb1582Ce587);

    uint256 public num;

    address public _attestor;

    constructor(address attestor){
        _attestor=attestor;
    }


    function updateNumber(bytes32 _uid,uint256 _num) external {
        Attestation memory data=_eas.getAttestation(_uid);
        require(data.recipient==msg.sender);
        require(abi.decode(data.data, (bool))==true);
        require(data.attester==_attestor);
        num=_num;
    }


}


