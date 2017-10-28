pragma solidity ^0.4.15;

import '../lib/Ownable.sol'; // TODO: Change this to use ENSOwnable.sol
import '../lib/ENS/ENS.sol';
import '../lib/ENS/PublicResolver.sol';

/**
 * @title Upgradable
 * @dev Contracts inheriting from Upgradeable can have their contract function calls routed to a new contract
 * if the contract is upgraded
 */
contract Upgradable is Ownable {
    ENS ens;
    bytes32 node;

    event nodeChanged(bytes32 newNode);

    function Upgradable(ENS _ens, bytes32 _node) public {
        ens = _ens;
        node = _node;
        nodeChanged(_node);
    }

    /**
     * Sets a new ENS node to check for if an upgrade has been set
     * @param newNode The ENS node.
     */
    function changeNode(bytes32 newNode) public onlyOwner {
        nodeChanged(newNode);
    }

    /**
     * Uses the current contract function if no upgrade has been set (through ENS)
     * If an upgrade has been set, send the call to the new function
     * The upgraded function must have the same interface
     * Once upgraded, only the upgraded contract can access the old contract's methods
     */
    modifier upgradeable () {
        address upgradedContract = PublicResolver(ens.resolver(node)).addr(node);

        if (upgradedContract != address(this)) {
            if (upgradedContract == msg.sender) {
                // Allow the new upgraded contract to still make calls, if needed
                _;
            } else {
                // Route the message to the new contract
                upgradedContract.delegatecall(msg.data);
            }
        } else {
            // Execute as normal
            _;
        }
    }
}

contract AbstractWallet {
    event Deposit(address deposit, uint amount);
    event Withdrawal(address withdrawal, uint amount);
    function deposit() public payable;
    function withdrawal() public;
}

contract SimpleWalllet is AbstractWallet, Upgradable {
    mapping (address => uint) public balances;
    // What will happen to the state of the new contract???

    event Deposit(address deposit, uint amount);
    event Withdrawal(address withdrawal, uint amount);

    function SimpleWalllet(ENS _ens, bytes32 _node) Upgradable(_ens, _node) public {}

    function deposit() upgradeable public payable {
        balances[msg.sender] += msg.value;
        Deposit(msg.sender, msg.value);
    }

    function withdrawal() upgradeable public {
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        Withdrawal(msg.sender, balances[msg.sender]);
        msg.sender.transfer(amount);

    }
}

contract UpgradedWallet is AbstractWallet, Upgradable {
    mapping (address => uint) public balances;
    SimpleWalllet simplewallet;

    function UpgradedWallet(ENS _ens, bytes32 _node, SimpleWalllet _simplewallet) Upgradable(_ens, _node) {
        simplewallet = _simplewallet;
    }

    function deposit() upgradeable public payable {
        if (msg.value < 1 ether) revert(); // Upgrade contract so that only deposits of 1 Ether or more are accepted
        balances[msg.sender] += msg.value;
        Deposit(msg.sender, msg.value);
    }

    function withdrawal() upgradeable public {
        uint amount =   balances[msg.sender];
        balances[msg.sender] = 0;
        Withdrawal(msg.sender, balances[msg.sender]);
        msg.sender.transfer(amount);

    }
}
