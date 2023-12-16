/*
  Warnings:

  - A unique constraint covering the columns `[shortName]` on the table `Partner` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Partner" ADD COLUMN "address1" TEXT;
ALTER TABLE "Partner" ADD COLUMN "address2" TEXT;
ALTER TABLE "Partner" ADD COLUMN "bank" TEXT;
ALTER TABLE "Partner" ADD COLUMN "boss" TEXT;
ALTER TABLE "Partner" ADD COLUMN "bossGenitive" TEXT;
ALTER TABLE "Partner" ADD COLUMN "email" TEXT;
ALTER TABLE "Partner" ADD COLUMN "phone" TEXT;
ALTER TABLE "Partner" ADD COLUMN "shortName" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "Partner_shortName_key" ON "Partner"("shortName");
