-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Partner" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "ogrn" TEXT,
    "inn" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Partner" ("id", "inn", "name", "ogrn") SELECT "id", "inn", "name", "ogrn" FROM "Partner";
DROP TABLE "Partner";
ALTER TABLE "new_Partner" RENAME TO "Partner";
CREATE UNIQUE INDEX "Partner_ogrn_key" ON "Partner"("ogrn");
CREATE UNIQUE INDEX "Partner_inn_key" ON "Partner"("inn");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
