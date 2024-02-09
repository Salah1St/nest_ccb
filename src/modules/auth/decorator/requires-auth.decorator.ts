import { applyDecorators, SetMetadata, UseGuards } from "@nestjs/common";
import { Role } from "../enums/role.enum";
import { JwtAuthGuard } from "../guards/jwt.guard";
import { OldUserRoleGuard } from "../guards/role.guard";

export const ROLE_KEY = "role";
export const RequiresAuth = (...role: Role[]) =>
  applyDecorators(
    UseGuards(JwtAuthGuard, OldUserRoleGuard),
    SetMetadata(ROLE_KEY, role),
  );
