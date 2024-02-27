import { ApiProperty } from "@nestjs/swagger";
import { Expose } from "class-transformer";
import { Type } from "class-transformer";
import { Team } from "./team.entity";
import { Admin } from "./admin.entity";

export class Permission {
  @Expose({ name: "id" })
  @ApiProperty()
  id: number;

  @Expose({ name: "admin_id" })
  @ApiProperty()
  adminId: number;

  @Expose({ name: "team_id" })
  @ApiProperty()
  teamId: number;

  @Expose({ name: "can_edit_subdistrict" })
  @ApiProperty()
  canEditSubdistrict: boolean;
  @Expose({ name: "can_grant" })
  @ApiProperty()
  canGrant: boolean;

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

  @Expose({ name: "admin" })
  @ApiProperty({ type: () => Admin })
  @Type(() => Admin)
  admin: Admin;
  @Expose({ name: "team" })
  @ApiProperty({ type: () => Team })
  @Type(() => Team)
  team: Team;
}
