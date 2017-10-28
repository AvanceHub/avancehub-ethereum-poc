pragma solidity ^0.4.15;

import '../lib/ENS/ENS.sol';
import '../lib/ENS/PublicResolver.sol';

/**
 * @title ENSOwnable
 * @dev The ENSOwnable contract has an owner, set as the resolved address of an ENS node,
 * and provides basic authorization control functions,
 * this simplifies the implementation of "user permissions".
 *
 * Design is based off Ownable
 * https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/ownership/Ownable.sol
 *
 */

contract ENSAddressResolver {
  ENS ens;

  function ENSAddressResolver(ENS _ens) {
    ens = _ens;
  }

  function resolveAddress(bytes32 node) returns (address addr) {
    PublicResolver publicResolver = PublicResolver(ens.resolver(node));
    require(publicResolver.supportsInterface(0x3b3b57de));
    addr = publicResolver.addr(node);
    require(addr != address(0));
  }
}

contract ENSOwnable is ENSAddressResolver {
  bytes32 ownerNode;

  event OwnershipTransferred(bytes32 indexed previousOwner, bytes32 indexed newOwner);

  /**
   * @dev The Ownable constructor sets the original owners ENS node
   *
   * @param _ens The address of the ENS contract
   * @param _ownerNode The ENS node of the owner
   */
  function ENSOwnable(ENS _ens, bytes32 _ownerNode) ENSAddressResolver(_ens) public {
    ownerNode = _ownerNode;
  }


  /**
   * @dev Throws if called by any address other than the owner.
   */
  modifier onlyENSOwner() {
    require(msg.sender == resolveAddress(ownerNode));
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a new ower by choosing their ENS address.
   * @param newOwnerNode The address to transfer ownership to.
   */
  function transferOwnership(bytes32 newOwnerNode) onlyENSOwner public {
    require(resolveAddress(newOwnerNode) != address(0));
    OwnershipTransferred(ownerNode, newOwnerNode);
    ownerNode = newOwnerNode;
  }
}
