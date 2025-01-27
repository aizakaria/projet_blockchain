// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Certification {
    struct Certificate {
        uint64 certificationDate; // Date de certification (en timestamp)
        address certifiedBy;      // Adresse de l'entité ayant certifié
    }

    mapping(uint32 => Certificate) public certificates; // Mapping ID → Informations de certification

    event PieceCertified(uint32 indexed pieceId, uint64 certificationDate, address certifiedBy);

    // Fonction pour certifier une pièce
    function certifyPiece(uint32 _pieceId, uint64 _certificationDate) external {
        require(_pieceId > 0, "Invalid piece ID");
        require(certificates[_pieceId].certifiedBy == address(0), "Piece already certified");

        certificates[_pieceId] = Certificate({
            certificationDate: _certificationDate,
            certifiedBy: msg.sender
        });
        emit PieceCertified(_pieceId, _certificationDate, msg.sender);
    }

    // Fonction pour récupérer les informations de certification d'une pièce
    function getCertificate(uint32 _pieceId)
        external
        view
        returns (uint64 certificationDate, address certifiedBy)
    {
        require(certificates[_pieceId].certifiedBy != address(0), "Certificate does not exist");
        Certificate memory cert = certificates[_pieceId];
        return (cert.certificationDate, cert.certifiedBy);
    }
}
