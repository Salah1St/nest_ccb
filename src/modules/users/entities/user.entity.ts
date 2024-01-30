import { ApiProperty } from "@nestjs/swagger";
import { Expose } from "class-transformer";
import { Type } from "class-transformer";
import { Role } from "@prisma/client";

import { Client } from "src/modules/clients/entities/client.entity";

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

  @Expose({ name: "client" })
  @ApiProperty({ type: () => Client })
  @Type(() => Client)
  client?: Client;
}
