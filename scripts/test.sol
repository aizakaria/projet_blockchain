// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Certification {
    struct Piece {
        uint id;
        string name;
        string certificationDate;
        address certifiedBy;
    }

    mapping(uint => Piece) public pieces;
    uint public pieceCount;

    event PieceCertified(uint id, string name, string certificationDate, address certifiedBy);

    function certifyPiece(string memory _name, string memory _certificationDate) public {
        pieceCount++;
        pieces[pieceCount] = Piece(pieceCount, _name, _certificationDate, msg.sender);
        emit PieceCertified(pieceCount, _name, _certificationDate, msg.sender);
    }

    function getPiece(uint _id) public view returns (string memory, string memory, address) {
        Piece memory p = pieces[_id];
        return (p.name, p.certificationDate, p.certifiedBy);
    }
}
