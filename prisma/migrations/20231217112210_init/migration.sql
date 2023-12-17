/*
  Warnings:

  - You are about to alter the column `placeId` on the `Contract` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - The primary key for the `ConstractionPlace` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `ConstractionPlace` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Contract" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "contractNumber" TEXT,
    "contractDate" DATETIME,
    "placeId" INTEGER NOT NULL DEFAULT 0,
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    "partnerId" TEXT NOT NULL,
    CONSTRAINT "Contract_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "ConstractionPlace" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Contract_partnerId_fkey" FOREIGN KEY ("partnerId") REFERENCES "Partner" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Contract" ("cloudCopy", "contractDate", "contractNumber", "id", "original", "partnerId", "placeId") SELECT "cloudCopy", "contractDate", "contractNumber", "id", "original", "partnerId", "placeId" FROM "Contract";
DROP TABLE "Contract";
ALTER TABLE "new_Contract" RENAME TO "Contract";
CREATE TABLE "new_ConstractionPlace" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "fullAddress" TEXT
);
INSERT INTO "new_ConstractionPlace" ("fullAddress", "id", "name") SELECT "fullAddress", "id", "name" FROM "ConstractionPlace";
DROP TABLE "ConstractionPlace";
ALTER TABLE "new_ConstractionPlace" RENAME TO "ConstractionPlace";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
