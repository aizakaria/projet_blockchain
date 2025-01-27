const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("PieceRegistry", function () {
    it("Devrait enregistrer une nouvelle pièce", async function () {
        const PieceRegistry = await ethers.getContractFactory("PieceRegistry");
        const pieceRegistry = await PieceRegistry.deploy();
        await pieceRegistry.deployed();

        const tx = await pieceRegistry.registerPiece(ethers.utils.formatBytes32String("Engine"));
        await tx.wait();

        const piece = await pieceRegistry.getPiece(1);
        expect(ethers.utils.parseBytes32String(piece.name)).to.equal("Engine");
    });
});

