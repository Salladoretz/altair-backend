/*
  Warnings:

  - A unique constraint covering the columns `[ogrn]` on the table `Partner` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[inn]` on the table `Partner` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Partner_ogrn_key" ON "Partner"("ogrn");

-- CreateIndex
CREATE UNIQUE INDEX "Partner_inn_key" ON "Partner"("inn");
