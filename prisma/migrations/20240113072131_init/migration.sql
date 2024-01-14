-- AlterTable
ALTER TABLE "Addendum" ADD COLUMN "addendumAmount" INTEGER;
ALTER TABLE "Addendum" ADD COLUMN "addendumSubject" TEXT;
ALTER TABLE "Addendum" ADD COLUMN "increaseTotalAmmount" BOOLEAN;

-- AlterTable
ALTER TABLE "Contract" ADD COLUMN "contractMaterials" BOOLEAN;
ALTER TABLE "Contract" ADD COLUMN "contractSubject" TEXT;
