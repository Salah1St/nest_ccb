import { PickType } from "@nestjs/swagger";
import { Admin } from "../entities/admin.entity";

export class RegisterAdminDto extends PickType(Admin, [
  "firstname",
  "lastname",
  "citizenId",
  "officerId",
  "officerCardImg",
  "email",
  "password",
]) {}
