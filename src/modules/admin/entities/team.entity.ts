import { Permission } from "./permission.entity";
import { ApiProperty } from "@nestjs/swagger";
import { Expose } from "class-transformer";
import { Type } from "class-transformer";
import { MaximumLevel, TeamStatus } from "prisma/client";

export class Team {
  @Expose({ name: "id" })
  @ApiProperty()
  id: number;

  @Expose({ name: "address_id" })
  @ApiProperty()
  addressId: number;

  @Expose({ name: "title" })
  @ApiProperty()
  title: string;

  @Expose({ name: "logo_img" })
  @ApiProperty()
  logoImg?: string;

  @Expose({ name: "organization_email" })
  @ApiProperty()
  organizationEmail: string;

  @Expose({ name: "status" })
  @ApiProperty()
  status: TeamStatus;

  @Expose({ name: "request_document" })
  @ApiProperty()
  requestDocument: string;

  @Expose({ name: "maximum_level" })
  @ApiProperty()
  maximumLevel: MaximumLevel;

  @Expose({ name: "created_at" })
  @ApiProperty()
  createdAt: Date;

  @Expose({ name: "created_by" })
  @ApiProperty()
  createdBy: string;

  @Expose({ name: "updated_at" })
  @ApiProperty()
  updatedAt: Date;

  @Expose({ name: "updated_by" })
  @ApiProperty()
  updatedBy: string;

  @Expose({ name: "permissions" })
  @ApiProperty({ type: () => Permission, isArray: true })
  @Type(() => Permission)
  permissions?: Permission[];
}
