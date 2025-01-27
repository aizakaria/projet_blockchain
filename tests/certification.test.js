const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("Certification", function () {
    it("Devrait certifier une pièce", async function () {
        const Certification = await ethers.getContractFactory("Certification");
        const certification = await Certification.deploy();
        await certification.deployed();

        const tx = await certification.certifyPiece(1, 1672531200); // Timestamp arbitraire
        await tx.wait();

        const certificate = await certification.getCertificate(1);
        expect(certificate.certificationDate).to.equal(1672531200);
    });
});

