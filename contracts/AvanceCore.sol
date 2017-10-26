pragma solidity ^0.4.15;

import './lib/Ownable.sol';
import './AvanceProject.sol';
import './AvanceManager.sol';

/**
 * @title AvanceCore
 * @dev Configuration state for the AvanceManager contract
 *      Contains varibles and pointers to other contracts that the AvanceManager contract can read/write
 *
 */
contract AbstractAvanceCore is Ownable {
  AvanceManager public avanceManager;

  struct Project {
    AvanceProject avanceProject;
  }

  mapping (address => Project) public projects;

  /**
   * @dev Sets a project
   *
   * @param ...
   * @return True if successfully changed
   */
  function setProject() onlyOwner internal returns (bool);
}

contract AvanceCore is AbstractAvanceCore {

}
