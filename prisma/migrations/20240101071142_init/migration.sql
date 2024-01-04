-- CreateTable
CREATE TABLE "TypesContract" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Contract" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "contractNumber" TEXT,
    "contractDate" DATETIME,
    "placeId" INTEGER NOT NULL DEFAULT 1,
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    "partnerId" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "onDelete" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "Contract_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "ConstractionPlace" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Contract_partnerId_fkey" FOREIGN KEY ("partnerId") REFERENCES "Partner" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Contract" ("cloudCopy", "contractDate", "contractNumber", "id", "original", "partnerId", "placeId") SELECT "cloudCopy", "contractDate", "contractNumber", "id", "original", "partnerId", "placeId" FROM "Contract";
DROP TABLE "Contract";
ALTER TABLE "new_Contract" RENAME TO "Contract";
CREATE TABLE "new_Partner" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "shortName" TEXT,
    "ogrn" TEXT,
    "ogrnDate" DATETIME,
    "inn" TEXT NOT NULL,
    "address1" TEXT,
    "address2" TEXT,
    "email" TEXT,
    "phone" TEXT,
    "bank" TEXT,
    "boss" TEXT,
    "bossGenitive" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "onDelete" BOOLEAN NOT NULL DEFAULT false
);
INSERT INTO "new_Partner" ("address1", "address2", "bank", "boss", "bossGenitive", "email", "id", "inn", "name", "ogrn", "ogrnDate", "phone", "shortName") SELECT "address1", "address2", "bank", "boss", "bossGenitive", "email", "id", "inn", "name", "ogrn", "ogrnDate", "phone", "shortName" FROM "Partner";
DROP TABLE "Partner";
ALTER TABLE "new_Partner" RENAME TO "Partner";
CREATE UNIQUE INDEX "Partner_shortName_key" ON "Partner"("shortName");
CREATE UNIQUE INDEX "Partner_ogrn_key" ON "Partner"("ogrn");
CREATE UNIQUE INDEX "Partner_inn_key" ON "Partner"("inn");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
