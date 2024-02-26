import { ApiProperty } from "@nestjs/swagger";
import { Expose, Type } from "class-transformer";
import { Permission } from "../entities/permission.entity";
import { EnumRole } from "src/enum/role";

export class GetAdminDtoResponse {
  @Expose({ name: "id" })
  @ApiProperty()
  id: number;

  @Expose({ name: "firstname" })
  @ApiProperty()
  firstname: string;

  @Expose({ name: "lastname" })
  @ApiProperty()
  lastname: string;

  @Expose({ name: "citizenId" })
  @ApiProperty()
  citizen_id: string;

  @Expose({ name: "officerId" })
  @ApiProperty()
  officer_id: string;

  @Expose({ name: "officerCardImg" })
  @ApiProperty()
  officer_card_img: string;

  @Expose({ name: "email" })
  @ApiProperty()
  email: string;

  @Expose({ name: "password" })
  @ApiProperty()
  password: string;

  @Expose({ name: "phoneNumber" })
  @ApiProperty()
  phone_number?: string;

  @Expose({ name: "profileImg" })
  @ApiProperty()
  profile_img?: string;

  @Expose({ name: "role" })
  @ApiProperty()
  role: EnumRole;

  @Expose({ name: "isActive" })
  @ApiProperty()
  is_active: boolean;

  @Expose({ name: "createdAt" })
  @ApiProperty()
  created_at: Date;

  @Expose({ name: "createdBy" })
  @ApiProperty()
  created_by: string;

  @Expose({ name: "updatedAt" })
  @ApiProperty()
  updated_at: Date;

  @Expose({ name: "updatedBy" })
  @ApiProperty()
  updated_by: string;

  @Expose({ name: "permissions" })
  @ApiProperty({ type: () => Permission, isArray: true })
  @Type(() => Permission)
  permissions?: Permission[];
}
