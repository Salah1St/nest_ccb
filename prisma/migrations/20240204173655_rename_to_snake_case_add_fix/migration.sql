/*
  Warnings:

  - You are about to drop the `Address` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CarbonFootprint` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ElectricityBill` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `EmissionFactor` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Household` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `HouseholdElectricity` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `HouseholdOtherEnergy` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `HouseholdWaterSupply` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `OtherEnergyConsumption` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PrivateVehicle` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Profile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ProfilePermission` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Team` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Transportation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `VehicleProperty` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WaterBill` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "TeamStatus" AS ENUM ('PENDING', 'CREATED', 'REJECTED');

-- DropForeignKey
ALTER TABLE "CarbonFootprint" DROP CONSTRAINT "CarbonFootprint_household_electricity_id_fkey";

-- DropForeignKey
ALTER TABLE "CarbonFootprint" DROP CONSTRAINT "CarbonFootprint_household_id_fkey";

-- DropForeignKey
ALTER TABLE "CarbonFootprint" DROP CONSTRAINT "CarbonFootprint_household_other_energy_id_fkey";

-- DropForeignKey
ALTER TABLE "CarbonFootprint" DROP CONSTRAINT "CarbonFootprint_household_water_supply_id_fkey";

-- DropForeignKey
ALTER TABLE "CarbonFootprint" DROP CONSTRAINT "CarbonFootprint_transportaion_id_fkey";

-- DropForeignKey
ALTER TABLE "ElectricityBill" DROP CONSTRAINT "ElectricityBill_emission_factor_id_fkey";

-- DropForeignKey
ALTER TABLE "ElectricityBill" DROP CONSTRAINT "ElectricityBill_household_id_fkey";

-- DropForeignKey
ALTER TABLE "Household" DROP CONSTRAINT "Household_address_id_fkey";

-- DropForeignKey
ALTER TABLE "HouseholdElectricity" DROP CONSTRAINT "HouseholdElectricity_household_id_fkey";

-- DropForeignKey
ALTER TABLE "HouseholdOtherEnergy" DROP CONSTRAINT "HouseholdOtherEnergy_household_id_fkey";

-- DropForeignKey
ALTER TABLE "HouseholdWaterSupply" DROP CONSTRAINT "HouseholdWaterSupply_household_id_fkey";

-- DropForeignKey
ALTER TABLE "OtherEnergyConsumption" DROP CONSTRAINT "OtherEnergyConsumption_emission_factor_id_fkey";

-- DropForeignKey
ALTER TABLE "OtherEnergyConsumption" DROP CONSTRAINT "OtherEnergyConsumption_household_id_fkey";

-- DropForeignKey
ALTER TABLE "PrivateVehicle" DROP CONSTRAINT "PrivateVehicle_emission_factor_id_fkey";

-- DropForeignKey
ALTER TABLE "PrivateVehicle" DROP CONSTRAINT "PrivateVehicle_household_id_fkey";

-- DropForeignKey
ALTER TABLE "PrivateVehicle" DROP CONSTRAINT "PrivateVehicle_vehicle_property_id_fkey";

-- DropForeignKey
ALTER TABLE "ProfilePermission" DROP CONSTRAINT "ProfilePermission_profile_id_fkey";

-- DropForeignKey
ALTER TABLE "ProfilePermission" DROP CONSTRAINT "ProfilePermission_team_id_fkey";

-- DropForeignKey
ALTER TABLE "Team" DROP CONSTRAINT "Team_address_id_fkey";

-- DropForeignKey
ALTER TABLE "Transportation" DROP CONSTRAINT "Transportation_household_id_fkey";

-- DropForeignKey
ALTER TABLE "WaterBill" DROP CONSTRAINT "WaterBill_emission_factor_id_fkey";

-- DropForeignKey
ALTER TABLE "WaterBill" DROP CONSTRAINT "WaterBill_household_id_fkey";

-- DropTable
DROP TABLE "Address";

-- DropTable
DROP TABLE "CarbonFootprint";

-- DropTable
DROP TABLE "ElectricityBill";

-- DropTable
DROP TABLE "EmissionFactor";

-- DropTable
DROP TABLE "Household";

-- DropTable
DROP TABLE "HouseholdElectricity";

-- DropTable
DROP TABLE "HouseholdOtherEnergy";

-- DropTable
DROP TABLE "HouseholdWaterSupply";

-- DropTable
DROP TABLE "OtherEnergyConsumption";

-- DropTable
DROP TABLE "PrivateVehicle";

-- DropTable
DROP TABLE "Profile";

-- DropTable
DROP TABLE "ProfilePermission";

-- DropTable
DROP TABLE "Team";

-- DropTable
DROP TABLE "Transportation";

-- DropTable
DROP TABLE "VehicleProperty";

-- DropTable
DROP TABLE "WaterBill";

-- CreateTable
CREATE TABLE "address" (
    "id" SERIAL NOT NULL,
    "region_name" TEXT NOT NULL,
    "province_name" TEXT NOT NULL,
    "district_name" TEXT NOT NULL,
    "subdistrict_name" TEXT NOT NULL,
    "zipcode" TEXT NOT NULL,

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
CREATE TABLE "profile" (
    "id" SERIAL NOT NULL,
    "firstname" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "citizen_id" TEXT NOT NULL,
    "officer_id" TEXT,
    "officer_card_image" TEXT,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone_number" TEXT,
    "profile_img" TEXT,
    "is_staff" BOOLEAN NOT NULL DEFAULT false,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "profile_permission" (
    "id" SERIAL NOT NULL,
    "profile_id" INTEGER NOT NULL,
    "team_id" INTEGER NOT NULL,
    "can_edit_subdistrict" BOOLEAN NOT NULL DEFAULT false,
    "can_grant" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "profile_permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "team" (
    "id" SERIAL NOT NULL,
    "address_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "logo_img" TEXT,
    "organization_email" TEXT,
    "team_status" "TeamStatus" NOT NULL,
    "request_document" TEXT NOT NULL,
    "maximum_level" "MaximumLevel" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "team_pkey" PRIMARY KEY ("id")
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
ALTER TABLE "profile_permission" ADD CONSTRAINT "profile_permission_profile_id_fkey" FOREIGN KEY ("profile_id") REFERENCES "profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "profile_permission" ADD CONSTRAINT "profile_permission_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "team"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "team" ADD CONSTRAINT "team_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
