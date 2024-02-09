/*
  Warnings:

  - You are about to drop the column `officer_card_image` on the `admin` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "admin" DROP COLUMN "officer_card_image",
ADD COLUMN     "officer_card_img" TEXT;
