-- AlterTable
ALTER TABLE "ConstractionPlace" ADD COLUMN "fullAddress" TEXT;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Contract" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "contractNumber" TEXT,
    "contractDate" DATETIME,
    "placeId" TEXT NOT NULL DEFAULT '',
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    "partnerId" TEXT NOT NULL,
    CONSTRAINT "Contract_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "ConstractionPlace" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Contract_partnerId_fkey" FOREIGN KEY ("partnerId") REFERENCES "Partner" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Contract" ("cloudCopy", "contractDate", "contractNumber", "id", "original", "partnerId") SELECT "cloudCopy", "contractDate", "contractNumber", "id", "original", "partnerId" FROM "Contract";
DROP TABLE "Contract";
ALTER TABLE "new_Contract" RENAME TO "Contract";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
