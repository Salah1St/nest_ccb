import { PartialType } from "@nestjs/swagger";
import { CreateOldUserDto } from "./create-user.dto";

export class UpdateOldUserDto extends PartialType(CreateOldUserDto) {}
