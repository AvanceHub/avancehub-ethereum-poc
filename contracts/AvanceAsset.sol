pragma solidity ^0.4.15;

import './lib/Ownable.sol';
import './lib/ERC223/AbstractERC223.sol';

/**
 * @title AvanceAsset
 * @dev An asset that is part of one or more Avancehub projects, can be a divisible asset
 *
 */
contract AvanceAsset is Ownable, AbstractERC223 {

  /**
   * @dev Contructor called with asset is issued
   *
   */
  function AvanceAsset() public;
}
