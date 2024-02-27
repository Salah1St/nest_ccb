import { Injectable } from "@nestjs/common";
import { BcryptService } from "./bcrypt.service";
import { JwtService } from "./jwt.service";
import { TimeService } from "./time.service";
import { SelectTrueService } from "./selectTrue.service";

@Injectable()
export class UtilsService {
  constructor(
    readonly bcrypt: BcryptService,
    readonly jwt: JwtService,
    readonly time: TimeService,
    readonly select: SelectTrueService,
  ) {}
}
