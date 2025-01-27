// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PieceRegistry {
    struct Piece {
        uint32 id;            // Identifiant unique de la pièce
        bytes32 name;         // Nom de la pièce (limité à 32 caractères max)
        address manufacturer; // Adresse de l'entité ayant enregistré la pièce
    }

    mapping(uint32 => Piece) public pieces; // Mapping ID → Informations sur la pièce
    uint32 public pieceCount;              // Nombre total de pièces enregistrées

    event PieceRegistered(uint32 indexed id, bytes32 name, address manufacturer);

    // Fonction pour enregistrer une nouvelle pièce
    function registerPiece(bytes32 _name) external {
        pieceCount++;
        pieces[pieceCount] = Piece({
            id: pieceCount,
            name: _name,
            manufacturer: msg.sender
        });
        emit PieceRegistered(pieceCount, _name, msg.sender);
    }

    // Fonction pour récupérer les informations d'une pièce par son ID
    function getPiece(uint32 _id) external view returns (bytes32 name, address manufacturer) {
        require(pieces[_id].id != 0, "Piece does not exist");
        Piece memory piece = pieces[_id];
        return (piece.name, piece.manufacturer);
    }
}
