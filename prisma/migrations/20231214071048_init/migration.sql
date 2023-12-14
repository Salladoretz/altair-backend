-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Partner" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "ogrn" INTEGER,
    "inn" INTEGER
);
INSERT INTO "new_Partner" ("id", "inn", "name", "ogrn") SELECT "id", "inn", "name", "ogrn" FROM "Partner";
DROP TABLE "Partner";
ALTER TABLE "new_Partner" RENAME TO "Partner";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
