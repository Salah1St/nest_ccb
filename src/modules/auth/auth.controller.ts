import { Body, Controller, Post, Request, UseGuards } from "@nestjs/common";
import { ApiCreatedResponse, ApiTags } from "@nestjs/swagger";
import { plainToClass } from "class-transformer";
import { AuthService } from "./auth.service";

import { ExpiredJWTDto } from "./dto/token.dto";
import { Jwt } from "./entities/jwt.entity";
import { LocalAuthGuard } from "./guards/local.guard";
import { AuthGuard } from "@nestjs/passport";

@ApiTags("Auth")
@ApiCreatedResponse({
  type: Jwt,
})
@Controller("auth")
export class AuthController {
  constructor(private authService: AuthService) {}
  @Post("login")
  @UseGuards(LocalAuthGuard)
  async login(@Request() req) {
    return await this.authService.login(req.user).then((token) => plainToClass(Jwt, { token }));
  }

  @Post("fetch")
  @UseGuards(AuthGuard("jwt"))
  async fetch(@Request() req) {
    return await this.authService.login(req.user).then((token) => plainToClass(Jwt, { token }));
  }

  @Post("refresh")
  @ApiCreatedResponse({ type: Jwt })
  async refreshToken(@Body() expiredToken: ExpiredJWTDto) {
    return this.authService.refreshToken(expiredToken.token).then((token) => plainToClass(Jwt, { token }));
  }
}
