import { Injectable } from "@nestjs/common";
import { Prisma } from "prisma/client";
import * as bcrypt from "bcrypt";
import { PrismaService } from "src/prisma/prisma.service";
// import { plainToInstance } from "class-transformer";
import { ErrorException } from "src/error/error.exception";

@Injectable()
export class AdminService {
  constructor(private readonly prisma: PrismaService) {}
  async registerAdmin(admin: Prisma.AdminUncheckedCreateInput) {
    try {
      const hashedPassword = await bcrypt.hash(admin.password, 10);
      admin.password = hashedPassword;
      await this.prisma.admin.create({
        data: admin,
      });
    } catch (error) {
      if (error.code === "P2002") {
        //unique validation
        throw new ErrorException("officerId is already exists");
      }
      throw new ErrorException(`error from database: ${error}`);
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

  exclude<Admin, Key extends keyof Admin>(
    admin: Admin,
    keys: Key[],
  ): Omit<Admin, Key> {
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
