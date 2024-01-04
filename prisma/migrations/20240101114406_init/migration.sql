-- CreateTable
CREATE TABLE "Roles" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_RolesToUser" (
    "A" INTEGER NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_RolesToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Roles" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_RolesToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "_RolesToUser_AB_unique" ON "_RolesToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_RolesToUser_B_index" ON "_RolesToUser"("B");
