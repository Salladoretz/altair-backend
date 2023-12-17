-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_ConstractionPlace" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "fullAddress" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT true
);
INSERT INTO "new_ConstractionPlace" ("fullAddress", "id", "name") SELECT "fullAddress", "id", "name" FROM "ConstractionPlace";
DROP TABLE "ConstractionPlace";
ALTER TABLE "new_ConstractionPlace" RENAME TO "ConstractionPlace";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
