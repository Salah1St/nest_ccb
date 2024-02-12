import { ApiProperty } from "@nestjs/swagger";
import { Expose, Type } from "class-transformer";
import { OldUser } from "src/modules/users/entities/user.entity";

export class Client {
  @Expose({ name: "user" })
  @ApiProperty({ type: () => OldUser })
  @Type(() => OldUser)
  user: OldUser;
  @Expose({ name: "user_id" })
  @ApiProperty()
  userId: string;
  @Expose({ name: "firstname" })
  @ApiProperty()
  firstname: string;
  @Expose({ name: "lastname" })
  @ApiProperty()
  lastname: string;
  @Expose({ name: "phone_number" })
  @ApiProperty()
  phoneNumber: string;
  @Expose({ name: "profile_image" })
  @ApiProperty()
  profileImage: string;
  @Expose({ name: "created_at" })
  @ApiProperty()
  createdAt: Date;
  @Expose({ name: "updated_at" })
  @ApiProperty()
  updatedAt: Date;
}
