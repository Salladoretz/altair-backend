/*
  Warnings:

  - You are about to drop the `Roles` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_RolesToUser` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Roles";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_RolesToUser";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "UserRoles" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_UserToUserRoles" (
    "A" TEXT NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_UserToUserRoles_A_fkey" FOREIGN KEY ("A") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_UserToUserRoles_B_fkey" FOREIGN KEY ("B") REFERENCES "UserRoles" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "_UserToUserRoles_AB_unique" ON "_UserToUserRoles"("A", "B");

-- CreateIndex
CREATE INDEX "_UserToUserRoles_B_index" ON "_UserToUserRoles"("B");
