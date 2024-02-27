import { ApiProperty } from "@nestjs/swagger";

export class ExpiredJWTDto {
  @ApiProperty()
  token: string;
}
