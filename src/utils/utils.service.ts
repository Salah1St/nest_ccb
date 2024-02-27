import { Injectable } from "@nestjs/common";
import { BcryptService } from "./bcrypt.service";
import { JwtService } from "./jwt.service";

@Injectable()
export class UtilsService {
  constructor(
    readonly bcrypt: BcryptService,
    readonly jwt: JwtService,
  ) {}
}
