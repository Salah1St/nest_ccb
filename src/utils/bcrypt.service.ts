import { Injectable } from "@nestjs/common";
import * as bcrypt from "bcrypt";

@Injectable()
export class BcryptService {
  async hashed(password: string) {
    return await bcrypt.hash(password, +process.env.BCRYPT_SALT ?? 10);
  }

  async compare(input: string, hashed: string) {
    return await bcrypt.compare(input, hashed);
  }
}
