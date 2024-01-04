/*
  Warnings:

  - You are about to drop the `OtherDocs` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_ContractToOtherDocs` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropIndex
DROP INDEX "_ContractToOtherDocs_B_index";

-- DropIndex
DROP INDEX "_ContractToOtherDocs_AB_unique";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "OtherDocs";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_ContractToOtherDocs";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "OtherContractDocs" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "type" TEXT NOT NULL,
    "description" TEXT,
    "contractId" TEXT NOT NULL,
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "onDelete" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "OtherContractDocs_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "Contract" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "OtherAddendumDocs" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "type" TEXT NOT NULL,
    "description" TEXT,
    "addendumId" TEXT NOT NULL,
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "onDelete" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "OtherAddendumDocs_addendumId_fkey" FOREIGN KEY ("addendumId") REFERENCES "Addendum" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Addendum" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "addendumNumber" TEXT,
    "addendumDate" DATETIME,
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    "contractId" TEXT NOT NULL,
    "comments" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "onDelete" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "Addendum_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "Contract" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Addendum" ("addendumDate", "addendumNumber", "cloudCopy", "contractId", "id", "original") SELECT "addendumDate", "addendumNumber", "cloudCopy", "contractId", "id", "original" FROM "Addendum";
DROP TABLE "Addendum";
ALTER TABLE "new_Addendum" RENAME TO "Addendum";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
