/*
  Warnings:

  - A unique constraint covering the columns `[officer_id]` on the table `admin` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "admin_officer_id_key" ON "admin"("officer_id");
