-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Partner" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "shortName" TEXT,
    "ogrn" TEXT,
    "ogrnDate" TEXT,
    "inn" TEXT NOT NULL,
    "kpp" TEXT,
    "address1" TEXT,
    "address2" TEXT,
    "email" TEXT,
    "phone" TEXT,
    "bank" TEXT,
    "bossTitle" TEXT,
    "boss" TEXT,
    "comments" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "onDelete" BOOLEAN NOT NULL DEFAULT false
);
INSERT INTO "new_Partner" ("address1", "address2", "bank", "boss", "bossTitle", "comments", "createdAt", "email", "id", "inn", "kpp", "name", "ogrn", "ogrnDate", "onDelete", "phone", "shortName", "status") SELECT "address1", "address2", "bank", "boss", "bossTitle", "comments", "createdAt", "email", "id", "inn", "kpp", "name", "ogrn", "ogrnDate", "onDelete", "phone", "shortName", "status" FROM "Partner";
DROP TABLE "Partner";
ALTER TABLE "new_Partner" RENAME TO "Partner";
CREATE UNIQUE INDEX "Partner_shortName_key" ON "Partner"("shortName");
CREATE UNIQUE INDEX "Partner_ogrn_key" ON "Partner"("ogrn");
CREATE UNIQUE INDEX "Partner_inn_key" ON "Partner"("inn");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
