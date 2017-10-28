pragma solidity ^0.4.15;

import './lib/SlockitDAO/DAO.sol';
import './AvanceCore.sol';

/**
 * @title AvanceManager
 * @dev ...
 *
 * Proposal to move a more robust investigated DAO-like contract system later
 *   for now shall just use it to illustrate concept
 */
contract AbstractAvanceManager is DAO {
  AvanceCore public avanceCore;

  /**
   * @dev Constructs a new
   *
   * @param _curator The address of the ENS
   * @param _proposalDeposit The hash of the rootnode.
   * @param _token Token contract to be used for voting
   */
  function AvanceProject(address _curator, uint _proposalDeposit, Token _token) public;

  /**
   * @dev Grants rewards in the form of AvanceTokens to a contributor for assets or developmen contributions
   *
   * @param beneficiary The user to be rewarded
   */
  function rewardContribution(address beneficiary) public;

  /**
   * @dev Grants rewards in the form of AvanceTokens to a contributor for assets or developmen contributions
   *
   * @param beneficiary The user to be rewarded
   */
  function projectTokenAuction(bytes32 projectID) public;
}

contract AvanceManager is AbstractAvanceManager {

}
