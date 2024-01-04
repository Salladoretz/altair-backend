-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Addendum" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "addendumNumber" TEXT,
    "addendumDate" DATETIME,
    "placeId" INTEGER NOT NULL DEFAULT 1,
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    "contractId" TEXT NOT NULL,
    "comments" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "onDelete" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "Addendum_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "ConstractionPlace" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Addendum_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "Contract" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Addendum" ("addendumDate", "addendumNumber", "cloudCopy", "comments", "contractId", "createdAt", "id", "onDelete", "original") SELECT "addendumDate", "addendumNumber", "cloudCopy", "comments", "contractId", "createdAt", "id", "onDelete", "original" FROM "Addendum";
DROP TABLE "Addendum";
ALTER TABLE "new_Addendum" RENAME TO "Addendum";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
