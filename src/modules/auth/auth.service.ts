import { Injectable } from "@nestjs/common";

import { invalidLoginException } from "src/error/error.exception";
import { HttpService } from "@nestjs/axios";
import { UtilsService } from "src/utils/utils.service";
import { PrismaService } from "src/prisma/prisma.service";
import { Admin } from "@prisma/client";

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly utils: UtilsService,
    private readonly httpService: HttpService,
  ) {}
  async validateLoginAdmin(email: string, password: string) {
    try {
      const user = await this.prisma.admin.findUnique({
        where: { email },
      });
      if (!user) throw new invalidLoginException("You have entered an invalid username or password");

      const validated = await this.utils.bcrypt.compare(password, user.password);
      if (!validated) {
        throw new invalidLoginException("You have entered an invalid username or password");
      } else {
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        const { password, ...userWithoutPassword } = user;
        return userWithoutPassword;
      }
    } catch (error) {
      throw error;
    }
  }

  async login(user: Omit<Admin, "password">) {
    return this.utils.jwt.sign(user);
  }

  async refreshToken(token: string) {
    return this.utils.jwt.verifyAsync(token, { ignoreExpiration: true }).then(() => {
      // const exp = new Date(response.exp).getTime();
      // const today = new Date().getTime();
      // const time_passed = today - exp;
      // const week = today + ms("1 week");
      // const payload = {
      //   email: response.email,
      //   sub: response.sub,
      //   user_type: response.user_type,
      // };
      // if (time_passed < week) {
      //   return this.jwtService.sign(payload);
      // } else {
      //   throw new ExpiredTooLongException();
      // }
    });
  }
}
