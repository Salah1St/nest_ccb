import { Controller, Get, Post, Body, Param } from "@nestjs/common";
import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiBody,
  ApiCreatedResponse,
  ApiExtraModels,
  ApiOkResponse,
  ApiTags,
} from "@nestjs/swagger";
import { AdminService } from "./admin.service";
import { PaginatedDto } from "src/globalDtos/paginated.dto";
import { ErrorException } from "src/error/error.exception";
import { RegisterAdminDto } from "./dto/register-admin.dto";
import { plainToInstance } from "class-transformer";
import { Prisma } from "prisma/client";
import { EnumRole } from "src/enum/role";
import { GetAdminDtoResponse } from "./dto/get-admin.dto";

@Controller("admin")
@ApiTags("Admin")
@ApiExtraModels(PaginatedDto)
@ApiBearerAuth()
export class AdminController {
  constructor(private readonly AdminService: AdminService) {}
  @Post("register")
  @ApiBody({
    description: "create admin with email and password",
    examples: {
      example: {
        summary: "create admin",
        value: {
          firstname: "staffnene",
          lastname: "haha",
          citizen_id: "1234",
          officer_id: "1234",
          officer_card_img: "12321321",
          email: "n@gmail.com",
          password: "password",
        },
      },
    },
  })
  @ApiCreatedResponse({ description: "OK" })
  @ApiBadRequestResponse({
    status: 500,
    description: "Internal Server Error",
    type: ErrorException,
  })
  async registerAdmin(@Body() req: RegisterAdminDto) {
    const registerAdminReq: Prisma.AdminUncheckedCreateInput = {
      firstname: req.firstname,
      lastname: req.lastname,
      citizenId: req.citizenId,
      officerId: req.officerId,
      officerCardImg: req.officerCardImg,
      email: req.email,
      password: req.password,
      createdBy: req.email,
      updatedBy: req.email,
      isActive: false, //default
      role: EnumRole.STAFF, //default
    };
    return await this.AdminService.registerAdmin(registerAdminReq);
  }

  // @Get()
  // @ApiPaginatedResponse(OldUser, { description: "OK" })
  // async findAll(
  //   @Query(ParsePrismaFindManyParamsPipe) params: PrismaFindManyDto,
  // ) {
  //   return await this.usersService
  //     .findAll({ ...params })
  //     .then((results) =>
  //       results.map((entity) => plainToInstance(OldUser, entity)),
  //     );
  // }

  @Get(":id")
  @ApiOkResponse({ type: GetAdminDtoResponse, description: "OK" })
  async findOne(@Param("id") id: number) {
    return await this.AdminService.findOneById({ id }).then((result) =>
      plainToInstance(GetAdminDtoResponse, result),
    );
  }

  // @Patch(":id")
  // @ApiOkResponse({ type: OldUser, description: "OK" })
  // async update(
  //   @Param("id") id: string,
  //   @Body() updateOldUserDto: UpdateOldUserDto,
  // ) {
  //   return await this.usersService
  //     .update({ id }, updateOldUserDto)
  //     .then((result) => plainToInstance(OldUser, result));
  // }

  // @Delete(":id")
  // @ApiOkResponse({ type: OldUser, description: "OK" })
  // async remove(@Param("id") id: string) {
  //   return await this.usersService
  //     .remove({ id })
  //     .then((result) => plainToInstance(OldUser, result));
  // }
}
