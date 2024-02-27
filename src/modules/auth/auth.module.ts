import { Module } from "@nestjs/common";
import { PassportModule } from "@nestjs/passport";
import { PrismaService } from "src/prisma/prisma.service";
import { AuthService } from "./auth.service";
import { AuthController } from "./auth.controller";
import { LocalStrategy } from "./strategies/local.strategy";

import { JwtStrategy } from "./strategies/jwt.strategy";
import { HttpModule } from "@nestjs/axios";
import { OldUsersModule } from "../users/users.module";
import { UtilsModule } from "src/utils/utils.module";

@Module({
  imports: [OldUsersModule, PassportModule, UtilsModule, HttpModule],

  providers: [AuthService, PrismaService, LocalStrategy, JwtStrategy],
  exports: [AuthService],
  controllers: [AuthController],
})
export class AuthModule {}
