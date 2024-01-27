// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

/**
 * @title PingPongEvents
 * @dev events for PingPong.
 */
contract PingPongEvents {
    /// @notice emit for pings
    event Ping();
    /// @notice emit for pongs
    /// @param txHash in response to Ping() emitted by transaction with the hash
    event Pong(bytes32 txHash);
}

/**
 * @title PingPong
 * @dev one pings, other pongs.
 */
contract PingPong is PingPongEvents {
    /// @notice only address allowed to ping
    address public pinger;

    /// @notice caller is expected to be the pinger of the contract
    /// @dev revert reason if `msg.sender` != `pinger`
    error NotPinger();

    /// @notice ensures caller is the pinger of the contract
    /// @dev ensures `msg.sender` == `pinger`
    modifier onlyPinger() {
        if (msg.sender != pinger) {
            revert NotPinger();
        }
        _;
    }

    /// @notice pinger is set to caller
    constructor() {
        pinger = msg.sender;
    }

    /// @notice pinger pings
    function ping() external onlyPinger {
        emit Ping();
    }

    /// @notice someone pongs
    /// @param txHash in response to Ping() emitted by transaction with the hash
    function pong(bytes32 txHash) external {
        emit Pong(txHash);
    }
}
