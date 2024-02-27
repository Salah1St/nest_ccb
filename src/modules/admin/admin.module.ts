import { Module } from "@nestjs/common";
import { AdminController } from "./admin.controller";

import { HttpModule } from "@nestjs/axios";
import { AdminService } from "./admin.service";

import { PrismaService } from "src/prisma/prisma.service";
import { UtilsModule } from "src/utils/utils.module";

@Module({
  imports: [HttpModule, UtilsModule],
  controllers: [AdminController],
  providers: [AdminService, PrismaService],
})
export class AdminModule {}
