import { Permission } from "./permission.entity";
import { ApiProperty } from "@nestjs/swagger";
import { Expose } from "class-transformer";
import { Type } from "class-transformer";
import { Role } from "@prisma/client";

export class Admin {
  @Expose({ name: "id" })
  @ApiProperty()
  id: number;

  @Expose({ name: "firstname" })
  @ApiProperty()
  firstname: string;

  @Expose({ name: "lastname" })
  @ApiProperty()
  lastname: string;

  @Expose({ name: "citizen_id" })
  @ApiProperty()
  citizenId: string;

  @Expose({ name: "officer_id" })
  @ApiProperty()
  officerId: string;

  @Expose({ name: "officer_card_img" })
  @ApiProperty()
  officerCardImg: string;

  @Expose({ name: "email" })
  @ApiProperty()
  email: string;

  @Expose({ name: "password" })
  @ApiProperty()
  password: string;

  @Expose({ name: "phone_number" })
  @ApiProperty()
  phoneNumber?: string;

  @Expose({ name: "profile_img" })
  @ApiProperty()
  profileImg?: string;

  @Expose({ name: "role" })
  @ApiProperty()
  role: Role;

  @Expose({ name: "is_active" })
  @ApiProperty()
  isActive: boolean;

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
