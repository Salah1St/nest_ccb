import { ApiProperty } from "@nestjs/swagger";
import { IsString } from "class-validator";
import { Admin } from "./admin.entity";

export class Auth {
  @ApiProperty()
  @IsString()
  token: string;

  @ApiProperty()
  user: Admin;
}
