const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("Proxy", function () {
    it("Devrait enregistrer et certifier une pièce via Proxy", async function () {
        const PieceRegistry = await ethers.getContractFactory("PieceRegistry");
        const Certification = await ethers.getContractFactory("Certification");
        const Proxy = await ethers.getContractFactory("Proxy");

        const pieceRegistry = await PieceRegistry.deploy();
        await pieceRegistry.deployed();

        const certification = await Certification.deploy();
        await certification.deployed();

        const proxy = await Proxy.deploy(pieceRegistry.address, certification.address);
        await proxy.deployed();

        // Enregistrer une pièce
        await proxy.registerPiece(ethers.utils.formatBytes32String("Engine"));

        // Certifier la pièce
        await proxy.certifyPiece(1, 1672531200);

        // Vérifier les informations via le Proxy
        const pieceInfo = await proxy.getPieceInfo(1);
        expect(ethers.utils.parseBytes32String(pieceInfo.name)).to.equal("Engine");
        expect(pieceInfo.certificationDate).to.equal(1672531200);
    });
});
