const { ethers } = require("hardhat");

async function main() {
    // Déploiement de PieceRegistry
    const PieceRegistry = await ethers.getContractFactory("PieceRegistry");
    const pieceRegistry = await PieceRegistry.deploy();
    await pieceRegistry.deployed();
    console.log("PieceRegistry déployé à :", pieceRegistry.address);

    // Déploiement de Certification
    const Certification = await ethers.getContractFactory("Certification");
    const certification = await Certification.deploy();
    await certification.deployed();
    console.log("Certification déployé à :", certification.address);

    // Déploiement du Proxy
    const Proxy = await ethers.getContractFactory("Proxy");
    const proxy = await Proxy.deploy(pieceRegistry.address, certification.address);
    await proxy.deployed();
    console.log("Proxy déployé à :", proxy.address);
}

// Gestion des erreurs
main().catch((error) => {
    console.error("Erreur lors du déploiement :", error);
});
