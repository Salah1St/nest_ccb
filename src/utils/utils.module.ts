import { Module } from "@nestjs/common";
import { BcryptService } from "./bcrypt.service";
import { JwtService } from "./jwt.service";
import { JwtModule } from "@nestjs/jwt";
import { UtilsService } from "./utils.service";

@Module({
  imports: [
    JwtModule.register({
      secret: "process.env.JWT_SECRET",
      signOptions: { expiresIn: "5s" },
    }),
  ],
  providers: [UtilsService, BcryptService, JwtService],
  exports: [UtilsService, BcryptService, JwtService],
})
export class UtilsModule {}
