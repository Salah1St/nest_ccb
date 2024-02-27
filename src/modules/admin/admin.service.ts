import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/prisma/prisma.service";
// import { plainToInstance } from "class-transformer";
import { ErrorException } from "src/error/error.exception";
import { Prisma } from "@prisma/client";
import { UtilsService } from "src/utils/utils.service";
import { code } from "src/error/error.model";
import { adminErrorAlreadyExists, adminErrorDatabase } from "src/error/error.response";

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
      const user = await this.prisma.admin.create({ data, select: { id: true } });
      // SIGN token from user data
      const token = this.utils.jwt.sign(user);
      return { token };
    } catch (error) {
      // VALIDATION unique
      if (error.code === code.PRISMA_ALREADY_EXISTS) {
        throw adminErrorAlreadyExists();
      }
      throw adminErrorDatabase(error);
    }
  }

  // async findAll(params?: {
  //   skip?: number;
  //   take?: number;
  //   cursor?: Prisma.OldUserWhereUniqueInput;
  //   where?: Prisma.OldUserWhereInput;
  //   orderBy?: Prisma.OldUserOrderByWithRelationInput;
  // }) {
  //   return await this.prisma.oldUser.findMany({
  //     ...params,
  //   });
  // }

  async findOneById(where: Prisma.AdminWhereUniqueInput) {
    try {
      const admin = await this.prisma.admin.findUniqueOrThrow({
        where,
        include: {
          permissions: {
            include: {
              team: true,
            },
          },
        },
      });
      return this.exclude(admin, ["password"]);
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

  // async update(
  //   where: Prisma.OldUserWhereUniqueInput,
  //   data: Prisma.OldUserUpdateInput,
  // ) {
  //   if (data.password) {
  //     const hashedPassword = await bcrypt.hash(data.password.toString(), 10);
  //     data.password = hashedPassword;
  //   }
  //   return await this.prisma.oldUser.update({
  //     where,
  //     data,
  //   });
  // }
  // async remove(where: Prisma.OldUserWhereUniqueInput) {
  //   return await this.prisma.oldUser.delete({ where });
  // }
}
