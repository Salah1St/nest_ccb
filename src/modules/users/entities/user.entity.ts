import { ApiProperty } from "@nestjs/swagger";
import { Role } from "@prisma/client";
import { Expose } from "class-transformer";

export class OldUser {
  @Expose({ name: "id" })
  @ApiProperty()
  id: string;

  @Expose({ name: "email" })
  @ApiProperty()
  email: string;

  @Expose({ name: "password" })
  @ApiProperty()
  password: string;

  @Expose({ name: "role" })
  @ApiProperty()
  role: Role;

  @Expose({ name: "created_at" })
  @ApiProperty()
  createdAt: Date;

  @Expose({ name: "updated_at" })
  @ApiProperty()
  updatedAt: Date;
}
