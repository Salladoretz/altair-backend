-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Contract" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "contractNumber" TEXT,
    "contractDate" DATETIME,
    "contractTypeId" INTEGER NOT NULL DEFAULT 1,
    "placeId" INTEGER NOT NULL DEFAULT 1,
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    "partnerId" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "onDelete" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "Contract_contractTypeId_fkey" FOREIGN KEY ("contractTypeId") REFERENCES "ContractTypes" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Contract_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "ConstractionPlace" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Contract_partnerId_fkey" FOREIGN KEY ("partnerId") REFERENCES "Partner" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Contract" ("cloudCopy", "contractDate", "contractNumber", "createdAt", "id", "onDelete", "original", "partnerId", "placeId", "status") SELECT "cloudCopy", "contractDate", "contractNumber", "createdAt", "id", "onDelete", "original", "partnerId", "placeId", "status" FROM "Contract";
DROP TABLE "Contract";
ALTER TABLE "new_Contract" RENAME TO "Contract";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
