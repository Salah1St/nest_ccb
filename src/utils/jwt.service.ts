import { Injectable } from "@nestjs/common";
import { JwtVerifyOptions, JwtService as jwtService } from "@nestjs/jwt";

@Injectable()
export class JwtService {
  constructor(private readonly jwt: jwtService) {}
  sign(payload: Record<string, any>) {
    return this.jwt.sign(payload);
  }
  async signAsync(payload: Record<string, any>) {
    return await this.jwt.signAsync(payload);
  }
  verify<T extends object>(token: string) {
    return this.jwt.verify<T>(token);
  }
  async verifyAsync<T extends object>(token: string, options?: JwtVerifyOptions) {
    return await this.jwt.verifyAsync<T>(token, options);
  }
}
