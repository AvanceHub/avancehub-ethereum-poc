pragma solidity ^0.4.15;

import './lib/SlockitDAO/DAO.sol';
import './AvanceManager.sol';

/**
 * @title AvanceProject
 * @dev ...
 *
 * Proposal to move a more robust investigated DAO-like contract system later
 *   for now shall just use it to illustrate concept
 */
contract AbstractAvanceProject is DAO {
  AvanceManager public avanceManager;

  /**
   * @dev Constructs a new Registrar, with the provided address as the owner of the root node.
   *
   * @param _curator The Curator
   * @param _proposalDeposit The deposit to be paid for a regular proposal
   * @param _token Token contract to be used for voting
   */
  function AvanceProject(address _curator, uint _proposalDeposit, Token _token) public;

  /**
   * @dev Function to submit dispute to AvanceManager
   *
   * @param ...
   */
  function submitDispute() onlyTokenholders public;
}

contract AvanceProject is AbstractAvanceProject {

}
