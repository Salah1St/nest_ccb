import { Injectable } from "@nestjs/common";
import * as bcrypt from "bcrypt";

import { PrismaService } from "src/prisma/prisma.service";
import { ErrorException } from "src/error/error.exception";
import { plainToInstance } from "class-transformer";
import { OldUser } from "./entities/user.entity";
import { Prisma } from "@prisma/client";

@Injectable()
export class OldUsersService {
  constructor(private readonly prisma: PrismaService) {}
  async create(user: Prisma.OldUserUncheckedCreateInput) {
    try {
      const hashedPassword = await bcrypt.hash(user.password, 10);
      user.password = hashedPassword;
      const newOldUser = await this.prisma.oldUser.create({
        data: user,
      });
      return plainToInstance(OldUser, newOldUser);
    } catch (error) {
      throw new ErrorException("email already exists");
    }
  }
  async findAll(params?: {
    skip?: number;
    take?: number;
    cursor?: Prisma.OldUserWhereUniqueInput;
    where?: Prisma.OldUserWhereInput;
    orderBy?: Prisma.OldUserOrderByWithRelationInput;
  }) {
    return await this.prisma.oldUser.findMany({
      ...params,
    });
  }

  async findOne(where: Prisma.OldUserWhereUniqueInput) {
    const user = await this.prisma.oldUser.findUniqueOrThrow({
      where,
      include: { client: true },
    });
    return this.exclude(user, ["password"]);
  }
  exclude<OldUser, Key extends keyof OldUser>(
    user: OldUser,
    keys: Key[],
  ): Omit<OldUser, Key> {
    for (const key of keys) {
      delete user[key];
    }
    return user;
  }

  async update(
    where: Prisma.OldUserWhereUniqueInput,
    data: Prisma.OldUserUpdateInput,
  ) {
    if (data.password) {
      const hashedPassword = await bcrypt.hash(data.password.toString(), 10);
      data.password = hashedPassword;
    }
    return await this.prisma.oldUser.update({
      where,
      data,
    });
  }
  async remove(where: Prisma.OldUserWhereUniqueInput) {
    return await this.prisma.oldUser.delete({ where });
  }
}
