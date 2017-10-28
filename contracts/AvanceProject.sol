pragma solidity ^0.4.15;

import './lib/SlockitDAO/DAO.sol';
import './AvanceManager.sol';
import './AvanceAsset.sol';
import './AvanceJob.sol';

/**
 * @title AvanceProject
 * @dev ...
 *
 * Proposal to move a more robust investigated DAO-like contract system later
 *   for now shall just use it to illustrate concept
 */
contract AbstractAvanceProject is DAO {
  AvanceManager public avanceManager;
  mapping (bytes32 => AvanceAsset) assets;
  mapping (bytes32 => AvanceJob) jobs;

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
  function submitDisputeToAvanceManager() onlyTokenholders public;

  /**
   * @dev Gets the address of the Avancehub Marketplace token, from the AvanceCore contract
   *
   * @returns address - The address of the Avancehub token
   */
  function getAvanceToken() internal returns (address);
}

contract AvanceProject is AbstractAvanceProject {

}
