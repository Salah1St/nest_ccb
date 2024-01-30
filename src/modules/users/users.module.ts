import { Module } from "@nestjs/common";
import { OldUsersService } from "./users.service";
import { OldUsersController } from "./users.controller";
import { PrismaService } from "src/prisma/prisma.service";

import { HttpModule } from "@nestjs/axios";

@Module({
  imports: [HttpModule],
  controllers: [OldUsersController],
  providers: [OldUsersService, PrismaService],
})
export class OldUsersModule {}
