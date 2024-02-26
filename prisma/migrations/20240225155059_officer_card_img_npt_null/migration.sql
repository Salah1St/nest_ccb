/*
  Warnings:

  - Made the column `officer_card_img` on table `admin` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "admin" ALTER COLUMN "officer_card_img" SET NOT NULL;
