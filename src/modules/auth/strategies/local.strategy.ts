import { Strategy } from "passport-local";
import { PassportStrategy } from "@nestjs/passport";
import { Injectable, UnauthorizedException } from "@nestjs/common";
import { AuthService } from "../auth.service";

interface requestDto extends Request {
  body: Body;
}
interface Body extends ReadableStream<Uint8Array> {
  email: string;
  password: string;
}
@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy) {
  constructor(private authService: AuthService) {
    super({
      usernameField: "email",
      passReqToCallback: true,
    });
  }

  async validate(req: requestDto, email: string, password: string): Promise<any> {
    const user = await this.authService.validateLoginAdmin(email, password);
    if (!user) {
      throw new UnauthorizedException();
    }
    return user;
  }
}
