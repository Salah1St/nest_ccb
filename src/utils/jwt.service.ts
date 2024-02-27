import { Injectable } from "@nestjs/common";
import { JwtService as jwtService } from "@nestjs/jwt";

@Injectable()
export class JwtService {
  constructor(private readonly jwt: jwtService) {}
  sign(payload: Record<string, any>) {
    return this.jwt.sign(payload);
  }
  verify<T extends object>(token: string) {
    return this.jwt.verify<T>(token);
  }
}
