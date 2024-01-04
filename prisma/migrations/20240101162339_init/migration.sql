/*
  Warnings:

  - You are about to drop the column `type` on the `OtherAddendumDocs` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `OtherContractDocs` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "OtherDocTypes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_OtherAddendumDocs" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "otherDocTypeId" INTEGER NOT NULL DEFAULT 1,
    "description" TEXT,
    "addendumId" TEXT NOT NULL,
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "onDelete" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "OtherAddendumDocs_otherDocTypeId_fkey" FOREIGN KEY ("otherDocTypeId") REFERENCES "OtherDocTypes" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "OtherAddendumDocs_addendumId_fkey" FOREIGN KEY ("addendumId") REFERENCES "Addendum" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_OtherAddendumDocs" ("addendumId", "cloudCopy", "createdAt", "description", "id", "onDelete", "original") SELECT "addendumId", "cloudCopy", "createdAt", "description", "id", "onDelete", "original" FROM "OtherAddendumDocs";
DROP TABLE "OtherAddendumDocs";
ALTER TABLE "new_OtherAddendumDocs" RENAME TO "OtherAddendumDocs";
CREATE TABLE "new_OtherContractDocs" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "otherDocTypeId" INTEGER NOT NULL DEFAULT 1,
    "description" TEXT,
    "contractId" TEXT NOT NULL,
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "onDelete" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "OtherContractDocs_otherDocTypeId_fkey" FOREIGN KEY ("otherDocTypeId") REFERENCES "OtherDocTypes" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "OtherContractDocs_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "Contract" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_OtherContractDocs" ("cloudCopy", "contractId", "createdAt", "description", "id", "onDelete", "original") SELECT "cloudCopy", "contractId", "createdAt", "description", "id", "onDelete", "original" FROM "OtherContractDocs";
DROP TABLE "OtherContractDocs";
ALTER TABLE "new_OtherContractDocs" RENAME TO "OtherContractDocs";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
