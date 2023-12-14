/*
  Warnings:

  - Made the column `inn` on table `Partner` required. This step will fail if there are existing NULL values in that column.
  - Made the column `ogrn` on table `Partner` required. This step will fail if there are existing NULL values in that column.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Partner" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "ogrn" INTEGER NOT NULL,
    "inn" INTEGER NOT NULL
);
INSERT INTO "new_Partner" ("id", "inn", "name", "ogrn") SELECT "id", "inn", "name", "ogrn" FROM "Partner";
DROP TABLE "Partner";
ALTER TABLE "new_Partner" RENAME TO "Partner";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
