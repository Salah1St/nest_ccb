import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/prisma/prisma.service";
// import { plainToInstance } from "class-transformer";
import { ErrorException } from "src/error/error.exception";
import { Prisma } from "@prisma/client";
import { UtilsService } from "src/utils/utils.service";
import { code } from "src/error/error.model";
import { adminErrorAlreadyExists, adminErrorDatabase } from "src/error/error.response";
import { Admin } from "./entities/admin.entity";

@Injectable()
export class AdminService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly utils: UtilsService,
  ) {}

  async registerAdmin(admin: Prisma.AdminCreateInput) {
    try {
      // HASHED PASSWORD
      const hashedPassword = await this.utils.bcrypt.hashed(admin.password);
      const data = { ...admin, password: hashedPassword };
      // CREATE user to database
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      const { password, ...user } = await this.prisma.admin.create({ data });
      // SIGN token from user data
      const token = this.utils.jwt.sign(user);
      return { token, user };
    } catch (error) {
      // VALIDATION unique
      if (error.code === code.PRISMA_ALREADY_EXISTS) {
        throw adminErrorAlreadyExists();
      }
      throw adminErrorDatabase(error);
    }
  }

  async findOneById(where: Prisma.AdminWhereUniqueInput) {
    try {
      const select = {
        ...this.utils.select.createObject(new Admin()),
        password: false,
      };
      const admin = await this.prisma.admin.findUniqueOrThrow({ where, select });
      return admin;
    } catch (error) {
      throw new ErrorException("not found");
    }
  }

  exclude<Admin, Key extends keyof Admin>(admin: Admin, keys: Key[]): Omit<Admin, Key> {
    for (const key of keys) {
      delete admin[key];
    }
    return admin;
  }
}
