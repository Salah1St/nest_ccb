// import { PrismaClient } from "prisma/client";

import { PrismaClient } from "./client";

const prisma = new PrismaClient();

async function main() {
  await prisma.address.createMany({
    data: [
      {
        regionName: "CENTRAL",
        provinceName: "BANGKOK",
        districtName: "BANG_RAK",
        subdistrictName: "SILOM",
        zipCode: "10500",
      },
      {
        regionName: "CENTRAL",
        provinceName: "BANGKOK",
        districtName: "PATHUM_WAN",
        subdistrictName: "WANG_MAI",
        zipCode: "10330",
      },
      {
        regionName: "CENTRAL",
        provinceName: "BANGKOK",
        districtName: "WATTHANA",
        subdistrictName: "KHLONG_TAN_NUEA",
        zipCode: "10110",
      },
      {
        regionName: "CENTRAL",
        provinceName: "BANGKOK",
        districtName: "PHAYA THAI",
        subdistrictName: "SIAM",
        zipCode: "10400",
      },
      {
        regionName: "CENTRAL",
        provinceName: "BANGKOK",
        districtName: "POM PRAP SATTRU PHAI",
        subdistrictName: "WAT THEPSIRIN",
        zipCode: "10100",
      },
    ],
  });
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
