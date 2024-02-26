import { Module } from "@nestjs/common";
import { AdminController } from "./admin.controller";
import { PrismaService } from "src/prisma/prisma.service";

import { HttpModule } from "@nestjs/axios";
import { AdminService } from "./admin.service";

@Module({
  imports: [HttpModule],
  controllers: [AdminController],
  providers: [AdminService, PrismaService],
})
export class AdminModule {}
