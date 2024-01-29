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

-- CreateTable
CREATE TABLE "Address" (
    "id" SERIAL NOT NULL,
    "region_name" TEXT NOT NULL,
    "province_name" TEXT NOT NULL,
    "district_name" TEXT NOT NULL,
    "subdistrict_name" TEXT NOT NULL,
    "zipcode" TEXT NOT NULL,

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Household" (
    "id" SERIAL NOT NULL,
    "address_id" INTEGER NOT NULL,
    "address_detail" TEXT NOT NULL,
    "house_type" "HouseType" NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Household_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CarbonFootprint" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "household_electricity_id" INTEGER NOT NULL,
    "household_water_supply_id" INTEGER NOT NULL,
    "household_other_energy_id" INTEGER NOT NULL,
    "transportaion_id" INTEGER NOT NULL,
    "total_carbon_footprint" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CarbonFootprint_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmissionFactor" (
    "id" INTEGER NOT NULL,
    "source_type" "SourceType" NOT NULL,
    "name" TEXT NOT NULL,
    "carbon_coefficient" DECIMAL(65,30) NOT NULL,
    "unit" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "EmissionFactor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VehicleProperty" (
    "id" SERIAL NOT NULL,
    "model_type" "ModelType" NOT NULL,
    "consumption_rate" DECIMAL(65,30) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VehicleProperty_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PrivateVehicle" (
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
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PrivateVehicle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Transportation" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "total_carbon_footprint" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Transportation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HouseholdElectricity" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "total_carbon_footprint" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "HouseholdElectricity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ElectricityBill" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "emission_factor_id" INTEGER NOT NULL,
    "amount_consumption" DECIMAL(65,30) NOT NULL,
    "electricity_meter" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ElectricityBill_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HouseholdWaterSupply" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "total_carbon_footprint" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "HouseholdWaterSupply_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WaterBill" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "emission_factor_id" INTEGER NOT NULL,
    "amount_consumption" DECIMAL(65,30) NOT NULL,
    "water_meter" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "WaterBill_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HouseholdOtherEnergy" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "total_carbon_footprint" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "HouseholdOtherEnergy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OtherEnergyConsumption" (
    "id" SERIAL NOT NULL,
    "household_id" INTEGER NOT NULL,
    "emission_factor_id" INTEGER NOT NULL,
    "energy_usage_type" "EnergyUsageType" NOT NULL,
    "amount_consumption" DECIMAL(65,30) NOT NULL,
    "recorded_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OtherEnergyConsumption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Profile" (
    "id" SERIAL NOT NULL,
    "firstname" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "profile_img" TEXT NOT NULL,
    "is_staff" BOOLEAN NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProfilePermission" (
    "id" SERIAL NOT NULL,
    "profile_id" INTEGER NOT NULL,
    "team_id" INTEGER NOT NULL,
    "can_edit_subdistrict" BOOLEAN NOT NULL,
    "can_grant" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProfilePermission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Team" (
    "id" SERIAL NOT NULL,
    "address_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "maximum_level" "MaximumLevel" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Team_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CarbonFootprint_household_id_key" ON "CarbonFootprint"("household_id");

-- CreateIndex
CREATE UNIQUE INDEX "CarbonFootprint_household_electricity_id_key" ON "CarbonFootprint"("household_electricity_id");

-- CreateIndex
CREATE UNIQUE INDEX "CarbonFootprint_household_water_supply_id_key" ON "CarbonFootprint"("household_water_supply_id");

-- CreateIndex
CREATE UNIQUE INDEX "CarbonFootprint_household_other_energy_id_key" ON "CarbonFootprint"("household_other_energy_id");

-- CreateIndex
CREATE UNIQUE INDEX "CarbonFootprint_transportaion_id_key" ON "CarbonFootprint"("transportaion_id");

-- CreateIndex
CREATE UNIQUE INDEX "CarbonFootprint_household_id_recorded_date_key" ON "CarbonFootprint"("household_id", "recorded_date");

-- CreateIndex
CREATE UNIQUE INDEX "Transportation_household_id_recorded_date_key" ON "Transportation"("household_id", "recorded_date");

-- CreateIndex
CREATE UNIQUE INDEX "HouseholdElectricity_household_id_recorded_date_key" ON "HouseholdElectricity"("household_id", "recorded_date");

-- CreateIndex
CREATE UNIQUE INDEX "HouseholdWaterSupply_household_id_recorded_date_key" ON "HouseholdWaterSupply"("household_id", "recorded_date");

-- CreateIndex
CREATE UNIQUE INDEX "HouseholdOtherEnergy_household_id_recorded_date_key" ON "HouseholdOtherEnergy"("household_id", "recorded_date");

-- AddForeignKey
ALTER TABLE "Household" ADD CONSTRAINT "Household_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarbonFootprint" ADD CONSTRAINT "CarbonFootprint_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "Household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarbonFootprint" ADD CONSTRAINT "CarbonFootprint_household_electricity_id_fkey" FOREIGN KEY ("household_electricity_id") REFERENCES "HouseholdElectricity"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarbonFootprint" ADD CONSTRAINT "CarbonFootprint_household_water_supply_id_fkey" FOREIGN KEY ("household_water_supply_id") REFERENCES "HouseholdWaterSupply"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarbonFootprint" ADD CONSTRAINT "CarbonFootprint_household_other_energy_id_fkey" FOREIGN KEY ("household_other_energy_id") REFERENCES "HouseholdOtherEnergy"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarbonFootprint" ADD CONSTRAINT "CarbonFootprint_transportaion_id_fkey" FOREIGN KEY ("transportaion_id") REFERENCES "Transportation"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PrivateVehicle" ADD CONSTRAINT "PrivateVehicle_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "Household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PrivateVehicle" ADD CONSTRAINT "PrivateVehicle_emission_factor_id_fkey" FOREIGN KEY ("emission_factor_id") REFERENCES "EmissionFactor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PrivateVehicle" ADD CONSTRAINT "PrivateVehicle_vehicle_property_id_fkey" FOREIGN KEY ("vehicle_property_id") REFERENCES "VehicleProperty"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transportation" ADD CONSTRAINT "Transportation_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "Household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HouseholdElectricity" ADD CONSTRAINT "HouseholdElectricity_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "Household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ElectricityBill" ADD CONSTRAINT "ElectricityBill_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "Household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ElectricityBill" ADD CONSTRAINT "ElectricityBill_emission_factor_id_fkey" FOREIGN KEY ("emission_factor_id") REFERENCES "EmissionFactor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HouseholdWaterSupply" ADD CONSTRAINT "HouseholdWaterSupply_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "Household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WaterBill" ADD CONSTRAINT "WaterBill_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "Household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WaterBill" ADD CONSTRAINT "WaterBill_emission_factor_id_fkey" FOREIGN KEY ("emission_factor_id") REFERENCES "EmissionFactor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HouseholdOtherEnergy" ADD CONSTRAINT "HouseholdOtherEnergy_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "Household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OtherEnergyConsumption" ADD CONSTRAINT "OtherEnergyConsumption_household_id_fkey" FOREIGN KEY ("household_id") REFERENCES "Household"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OtherEnergyConsumption" ADD CONSTRAINT "OtherEnergyConsumption_emission_factor_id_fkey" FOREIGN KEY ("emission_factor_id") REFERENCES "EmissionFactor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProfilePermission" ADD CONSTRAINT "ProfilePermission_profile_id_fkey" FOREIGN KEY ("profile_id") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProfilePermission" ADD CONSTRAINT "ProfilePermission_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "Team"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Team" ADD CONSTRAINT "Team_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
