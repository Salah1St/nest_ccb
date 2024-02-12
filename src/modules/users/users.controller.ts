import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
} from "@nestjs/common";
import { OldUsersService } from "./users.service";
import { CreateOldUserDto } from "./dto/create-user.dto";
import { UpdateOldUserDto } from "./dto/update-user.dto";
import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiBody,
  ApiCreatedResponse,
  ApiExtraModels,
  ApiOkResponse,
  ApiTags,
} from "@nestjs/swagger";
import { PaginatedDto } from "src/globalDtos/paginated.dto";
import { OldUser } from "./entities/user.entity";
import { ApiPaginatedResponse } from "src/decorators/api-paginated-response.decorator";
import { ParsePrismaFindManyParamsPipe } from "src/pipes/parse-prisma-find-many-params.pipe";
import { PrismaFindManyDto } from "src/globalDtos/prisma-find-many.dto";
import { classToPlain, plainToInstance } from "class-transformer";
import { ErrorException } from "src/error/error.exception";

@Controller("users")
@ApiTags("OldUsers")
@ApiExtraModels(PaginatedDto)
@ApiBearerAuth()
export class OldUsersController {
  constructor(private readonly usersService: OldUsersService) {}

  @Post()
  @ApiBody({
    description: "create user with email and password",
    examples: {
      example: {
        summary: "create user",
        value: {
          email: "ccbdigital@gmail.com",
          password: "1234",
        },
      },
    },
  })
  @ApiCreatedResponse({ type: OldUser, description: "OK" })
  @ApiBadRequestResponse({
    status: 500,
    description: "Internal Server Error",
    type: ErrorException,
  })
  async create(@Body() createOldUserDto: CreateOldUserDto) {
    return await this.usersService
      .create(createOldUserDto)
      .then((result) => classToPlain(result));
  }

  @Get()
  @ApiPaginatedResponse(OldUser, { description: "OK" })
  async findAll(
    @Query(ParsePrismaFindManyParamsPipe) params: PrismaFindManyDto,
  ) {
    return await this.usersService
      .findAll({ ...params })
      .then((results) =>
        results.map((entity) => plainToInstance(OldUser, entity)),
      );
  }

  @Get(":id")
  @ApiOkResponse({ type: OldUser, description: "OK" })
  async findOne(@Param("id") id: string) {
    return await this.usersService
      .findOne({ id })
      .then((result) => plainToInstance(OldUser, result));
  }

  @Patch(":id")
  @ApiOkResponse({ type: OldUser, description: "OK" })
  async update(
    @Param("id") id: string,
    @Body() updateOldUserDto: UpdateOldUserDto,
  ) {
    return await this.usersService
      .update({ id }, updateOldUserDto)
      .then((result) => plainToInstance(OldUser, result));
  }

  @Delete(":id")
  @ApiOkResponse({ type: OldUser, description: "OK" })
  async remove(@Param("id") id: string) {
    return await this.usersService
      .remove({ id })
      .then((result) => plainToInstance(OldUser, result));
  }
}
