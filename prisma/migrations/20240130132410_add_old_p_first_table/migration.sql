-- CreateEnum
CREATE TYPE "Role" AS ENUM ('CLIENT', 'OFFICER', 'ADMIN');

-- CreateTable
CREATE TABLE "OldUser" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'OFFICER',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OldUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OldClient" (
    "user_id" TEXT NOT NULL DEFAULT '',
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "profile_image" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OldClient_pkey" PRIMARY KEY ("user_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "OldUser_email_key" ON "OldUser"("email");

-- AddForeignKey
ALTER TABLE "OldClient" ADD CONSTRAINT "OldClient_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "OldUser"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
