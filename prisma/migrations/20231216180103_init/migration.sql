-- CreateTable
CREATE TABLE "Addendum" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "addendumNumber" TEXT,
    "addendumDate" DATETIME,
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    "contractId" TEXT NOT NULL,
    CONSTRAINT "Addendum_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "Contract" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Contract" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "contractNumber" TEXT,
    "contractDate" DATETIME,
    "partnerId" TEXT NOT NULL,
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    CONSTRAINT "Contract_partnerId_fkey" FOREIGN KEY ("partnerId") REFERENCES "Partner" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Contract" ("cloudCopy", "contractDate", "contractNumber", "id", "original", "partnerId") SELECT "cloudCopy", "contractDate", "contractNumber", "id", "original", "partnerId" FROM "Contract";
DROP TABLE "Contract";
ALTER TABLE "new_Contract" RENAME TO "Contract";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
