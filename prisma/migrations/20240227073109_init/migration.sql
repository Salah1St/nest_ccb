-- CreateEnum
CREATE TYPE "HouseType" AS ENUM ('SINGLE_HOUSE', 'TOWNHOUSE', 'CONDO', 'APARTMENT');

-- CreateEnum
CREATE TYPE "SourceType" AS ENUM ('PRIVATE_VEHICLE', 'PUBLIC_VEHICLE', 'ELECTRICITY', 'WATER_SUPPLY', 'COOKING', 'HEATING', 'COOLING', 'COMBUSTION');

-- CreateEnum
CREATE TYPE "ModelType" AS ENUM ('MODEL_1500_CC', 'MODEL_1600_CC', 'MODEL_1800_CC', 'MODEL_2000_CC', 'NGV', 'LPG');

-- CreateEnum
CREATE TYPE "EnergyUsageType" AS ENUM ('HEATING', 'COOKING', 'COOLING', 'COMBUSTION');

-- CreateEnum
CREATE TYPE "MaximumLevel" AS ENUM ('PROVINCE', 'DISTRICT', 'SUBDISTRICT');

-- CreateEnum
CREATE TYPE "TeamStatus" AS ENUM ('PENDING', 'CREATED', 'REJECTED');

-- CreateEnum
CREATE TYPE "Role" AS ENUM ('STAFF', 'SUPER_ADMIN');

-- CreateTable
CREATE TABLE "address" (
    "id" SERIAL NOT NULL,
    "province_code" INTEGER NOT NULL,
    "province_name_en" TEXT NOT NULL,
    "province_name_th" TEXT NOT NULL,
    "region_name" TEXT NOT NULL,
    "district_code" INTEGER NOT NULL,
    "district_name_en" TEXT NOT NULL,
    "district_name_th" TEXT NOT NULL,
    "subdistrict_code" INTEGER NOT NULL,
    "subdistrict_name_en" TEXT NOT NULL,
    "subdistrict_name_th" TEXT NOT NULL,
    "postal_code" TEXT NOT NULL,

    CONSTRAINT "address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "household" (
    "id" SERIAL NOT NULL,
    "address_id" INTEGER NOT NULL,
    "address_detail" TEXT NOT NULL,
    "house_type" "HouseType" NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "household_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "carbon_footprint" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "household_electricity_id" INTEGER,
    "household_water_supply_id" INTEGER,
    "household_other_energy_id" INTEGER,
    "transportaion_id" INTEGER,
    "total_carbon_footprint" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "carbon_footprint_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emission_factor" (
    "id" INTEGER NOT NULL,
    "source_type" "SourceType" NOT NULL,
    "name" TEXT NOT NULL,
    "carbon_coefficient" DECIMAL(65,30) NOT NULL,
    "unit" TEXT NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "emission_factor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vehicle_property" (
    "id" SERIAL NOT NULL,
    "model_type" "ModelType" NOT NULL,
    "consumption_rate" DECIMAL(65,30) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "vehicle_property_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "private_property" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "emission_factor_id" INTEGER NOT NULL,
    "vehicle_property_id" INTEGER NOT NULL,
    "start_month_distance" DECIMAL(65,30) NOT NULL,
    "end_month_distance" DECIMAL(65,30) NOT NULL,
    "fuel_comsumption_per_month" DECIMAL(65,30) NOT NULL,
    "is_regular_maintain" BOOLEAN NOT NULL,
    "carbon_emission_eq" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "private_property_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transportation" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "total_carbon_footprint" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "transportation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "household_electricity" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "total_carbon_footprint" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "household_electricity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "electricity_bill" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "emission_factor_id" INTEGER NOT NULL,
    "amount_consumption" DECIMAL(65,30) NOT NULL,
    "electricity_meter" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "electricity_bill_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "household_water_supply" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "total_carbon_footprint" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "household_water_supply_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "water_bill" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "emission_factor_id" INTEGER NOT NULL,
    "amount_consumption" DECIMAL(65,30) NOT NULL,
    "water_meter" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "water_bill_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "household_other_energy" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "total_carbon_footprint" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "household_other_energy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "other_energy_consumption" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "emission_factor_id" INTEGER NOT NULL,
    "energy_usage_type" "EnergyUsageType" NOT NULL,
    "amount_consumption" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "other_energy_consumption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user" (
    "id" SERIAL NOT NULL,
    "firstname" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "citizen_id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone_number" TEXT,
    "profile_img" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_household" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "household_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "user_household_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admin" (
    "id" SERIAL NOT NULL,
    "firstname" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "citizen_id" TEXT NOT NULL,
    "officer_id" TEXT NOT NULL,
    "officer_card_img" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone_number" TEXT,
    "profile_img" TEXT,
    "role" "Role" NOT NULL DEFAULT 'STAFF',
    "is_active" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permission" (
    "id" SERIAL NOT NULL,
    "admin_id" INTEGER NOT NULL,
    "team_id" INTEGER NOT NULL,
    "can_edit_subdistrict" BOOLEAN NOT NULL DEFAULT false,
    "can_grant" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "team" (
    "id" SERIAL NOT NULL,
    "address_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "logo_img" TEXT,
    "organization_email" TEXT,
    "status" "TeamStatus" NOT NULL,
    "request_document" TEXT NOT NULL,
    "maximum_level" "MaximumLevel" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "team_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OldUser" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'STAFF',
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
CREATE UNIQUE INDEX "carbon_footprint_household_electricity_id_key" ON "carbon_footprint"("household_electricity_id");

-- CreateIndex
CREATE UNIQUE INDEX "carbon_footprint_household_water_supply_id_key" ON "carbon_footprint"("household_water_supply_id");

-- CreateIndex
CREATE UNIQUE INDEX "carbon_footprint_household_other_energy_id_key" ON "carbon_footprint"("household_other_energy_id");

-- CreateIndex
CREATE UNIQUE INDEX "carbon_footprint_transportaion_id_key" ON "carbon_footprint"("transportaion_id");

-- CreateIndex
CREATE UNIQUE INDEX "carbon_footprint_household_id_recorded_date_key" ON "carbon_footprint"("household_id", "recorded_date");

-- CreateIndex
CREATE UNIQUE INDEX "transportation_household_id_recorded_date_key" ON "transportation"("household_id", "recorded_date");

-- CreateIndex
CREATE UNIQUE INDEX "household_electricity_household_id_recorded_date_key" ON "household_electricity"("household_id", "recorded_date");

-- CreateIndex
CREATE UNIQUE INDEX "household_water_supply_household_id_recorded_date_key" ON "household_water_supply"("household_id", "recorded_date");

-- CreateIndex
CREATE UNIQUE INDEX "household_other_energy_household_id_recorded_date_key" ON "household_other_energy"("household_id", "recorded_date");

-- CreateIndex
CREATE UNIQUE INDEX "admin_email_key" ON "admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "OldUser_email_key" ON "OldUser"("email");

-- AddForeignKey
ALTER TABLE "household" ADD CONSTRAINT "household_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "carbon_footprint" ADD CONSTRAINT "carbon_footprint_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "carbon_footprint" ADD CONSTRAINT "carbon_footprint_household_electricity_id_fkey" FOREIGN KEY ("household_electricity_id") REFERENCES "household_electricity"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "carbon_footprint" ADD CONSTRAINT "carbon_footprint_household_water_supply_id_fkey" FOREIGN KEY ("household_water_supply_id") REFERENCES "household_water_supply"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "carbon_footprint" ADD CONSTRAINT "carbon_footprint_household_other_energy_id_fkey" FOREIGN KEY ("household_other_energy_id") REFERENCES "household_other_energy"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "carbon_footprint" ADD CONSTRAINT "carbon_footprint_transportaion_id_fkey" FOREIGN KEY ("transportaion_id") REFERENCES "transportation"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "private_property" ADD CONSTRAINT "private_property_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "private_property" ADD CONSTRAINT "private_property_emission_factor_id_fkey" FOREIGN KEY ("emission_factor_id") REFERENCES "emission_factor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "private_property" ADD CONSTRAINT "private_property_vehicle_property_id_fkey" FOREIGN KEY ("vehicle_property_id") REFERENCES "vehicle_property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transportation" ADD CONSTRAINT "transportation_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "household_electricity" ADD CONSTRAINT "household_electricity_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "electricity_bill" ADD CONSTRAINT "electricity_bill_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "electricity_bill" ADD CONSTRAINT "electricity_bill_emission_factor_id_fkey" FOREIGN KEY ("emission_factor_id") REFERENCES "emission_factor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "household_water_supply" ADD CONSTRAINT "household_water_supply_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "water_bill" ADD CONSTRAINT "water_bill_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "water_bill" ADD CONSTRAINT "water_bill_emission_factor_id_fkey" FOREIGN KEY ("emission_factor_id") REFERENCES "emission_factor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "household_other_energy" ADD CONSTRAINT "household_other_energy_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "other_energy_consumption" ADD CONSTRAINT "other_energy_consumption_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "other_energy_consumption" ADD CONSTRAINT "other_energy_consumption_emission_factor_id_fkey" FOREIGN KEY ("emission_factor_id") REFERENCES "emission_factor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_household" ADD CONSTRAINT "user_household_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_household" ADD CONSTRAINT "user_household_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "permission" ADD CONSTRAINT "permission_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "admin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "permission" ADD CONSTRAINT "permission_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "team"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "team" ADD CONSTRAINT "team_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OldClient" ADD CONSTRAINT "OldClient_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "OldUser"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
