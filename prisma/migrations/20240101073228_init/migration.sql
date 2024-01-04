-- AlterTable
ALTER TABLE "Contract" ADD COLUMN "comments" TEXT;

-- AlterTable
ALTER TABLE "Partner" ADD COLUMN "comments" TEXT;

-- CreateTable
CREATE TABLE "OtherDocs" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "type" TEXT NOT NULL,
    "description" TEXT,
    "original" BOOLEAN,
    "cloudCopy" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "onDelete" BOOLEAN NOT NULL DEFAULT false
);

-- CreateTable
CREATE TABLE "_ContractToOtherDocs" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_ContractToOtherDocs_A_fkey" FOREIGN KEY ("A") REFERENCES "Contract" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_ContractToOtherDocs_B_fkey" FOREIGN KEY ("B") REFERENCES "OtherDocs" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "_ContractToOtherDocs_AB_unique" ON "_ContractToOtherDocs"("A", "B");

-- CreateIndex
CREATE INDEX "_ContractToOtherDocs_B_index" ON "_ContractToOtherDocs"("B");
