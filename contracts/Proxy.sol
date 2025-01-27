// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PieceRegistry.sol";
import "./Certification.sol";

contract Proxy {
    address public pieceRegistryAddress;
    address public certificationAddress;

    constructor(address _pieceRegistryAddress, address _certificationAddress) {
        require(_pieceRegistryAddress != address(0), "Invalid PieceRegistry address");
        require(_certificationAddress != address(0), "Invalid Certification address");

        pieceRegistryAddress = _pieceRegistryAddress;
        certificationAddress = _certificationAddress;
    }

    // Fonction pour enregistrer une pièce via le contrat PieceRegistry
    function registerPiece(bytes32 _name) external {
        PieceRegistry(pieceRegistryAddress).registerPiece(_name);
    }

    // Fonction pour certifier une pièce via le contrat Certification
    function certifyPiece(uint32 _pieceId, uint64 _certificationDate) external {
        Certification(certificationAddress).certifyPiece(_pieceId, _certificationDate);
    }

    // Fonction pour obtenir toutes les informations combinées sur une pièce
    function getPieceInfo(uint32 _pieceId)
        external
        view
        returns (bytes32 name, address manufacturer, uint64 certificationDate, address certifiedBy)
    {
        (name, manufacturer) = PieceRegistry(pieceRegistryAddress).getPiece(_pieceId);
        (certificationDate, certifiedBy) = Certification(certificationAddress).getCertificate(_pieceId);
        return (name, manufacturer, certificationDate, certifiedBy);
    }
}
