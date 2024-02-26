/*
  Warnings:

  - You are about to drop the column `team_status` on the `team` table. All the data in the column will be lost.
  - Added the required column `status` to the `team` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "team" DROP COLUMN "team_status",
ADD COLUMN     "status" "TeamStatus" NOT NULL;
