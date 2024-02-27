import { Controller, Get, Post, Body, Param } from "@nestjs/common";
import { ApiBadRequestResponse, ApiBearerAuth, ApiBody, ApiCreatedResponse, ApiExtraModels, ApiOkResponse, ApiTags } from "@nestjs/swagger";
import { PaginatedDto } from "src/globalDtos/paginated.dto";
import { RegisterAdminDto } from "./dto/register-admin.dto";
import { plainToInstance } from "class-transformer";
import { GetAdminDtoResponse } from "./dto/get-admin.dto";
import { Prisma } from "@prisma/client";
import { AdminService } from "./admin.service";
import { exampleAdmin } from "./example";
import { Role } from "./enum/role.enum";
import { Auth } from "./entities/auth.entity";

@Controller("admin")
@ApiTags("Admin")
@ApiExtraModels(PaginatedDto)
@ApiBearerAuth()
export class AdminController {
  constructor(private readonly adminService: AdminService) {}
  @Post("register")
  @ApiBody(exampleAdmin.registerAdminRequestBody)
  @ApiCreatedResponse({ type: Auth, description: "OK" })
  @ApiBadRequestResponse(exampleAdmin.internalServerError)
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
      role: Role.STAFF, //default
    };
    return await this.adminService.registerAdmin(registerAdminReq);
  }

  @Get(":id")
  @ApiOkResponse({ type: GetAdminDtoResponse, description: "OK" })
  async findOne(@Param("id") id: number) {
    return await this.adminService.findOneById({ id }).then((result) => plainToInstance(GetAdminDtoResponse, result));
  }
}
