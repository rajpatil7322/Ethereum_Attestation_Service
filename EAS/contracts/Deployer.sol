// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;
import  {ExampleAttester} from  "./ExampleAttestation.sol";

contract Deployer {
    address public eas_contract;

    function deploy(uint _salt) external returns(address) {
        ExampleAttester _contract = new ExampleAttester{
            salt: bytes32(_salt)    // the number of salt determines the address of the contract that will be deployed
        }();
        return address(_contract);
    }

    function getAddress(uint _salt) public {
        bytes memory bytecode = type(ExampleAttester).creationCode;
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff), address(this), _salt, keccak256(abi.encodePacked(bytecode))
            )
        );
        eas_contract=address (uint160(uint(hash)));
    }
}

