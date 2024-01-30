import { PickType } from "@nestjs/swagger";
import { OldUser } from "../entities/user.entity";

export class CreateOldUserDto extends PickType(OldUser, [
  "email",
  "password",
]) {}
