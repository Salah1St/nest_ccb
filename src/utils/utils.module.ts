import { Module } from "@nestjs/common";
import { BcryptService } from "./bcrypt.service";
import { JwtService } from "./jwt.service";
import { JwtModule } from "@nestjs/jwt";
import { UtilsService } from "./utils.service";
import { TimeService } from "./time.service";
import { SelectTrueService } from "./selectTrue.service";

@Module({
  imports: [
    JwtModule.register({
      secret: process.env.JWT_SECRET,
      signOptions: { expiresIn: "1d" },
    }),
  ],
  providers: [UtilsService, BcryptService, JwtService, TimeService, SelectTrueService],
  exports: [UtilsService, BcryptService, JwtService, TimeService, SelectTrueService],
})
export class UtilsModule {}
