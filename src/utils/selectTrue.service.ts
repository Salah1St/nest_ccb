import { Injectable } from "@nestjs/common";

@Injectable()
export class SelectTrueService {
  createObject(instanct: Record<string, any>) {
    for (const key in instanct) {
      if (typeof instanct[key] !== "function") {
        this[key] = true;
      }
    }
    return { ...this };
  }
}
