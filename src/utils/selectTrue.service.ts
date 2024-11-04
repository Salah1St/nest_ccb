import { Injectable } from "@nestjs/common";

interface ClassType<T> {
  new (): T;
}
@Injectable()
export class SelectTrueService {
  createObject(instanct: Record<string, any>) {
    const res = {};
    for (const key in instanct) {
      if (typeof instanct[key] !== "function") {
        res[key] = true;
      }
    }
    return res;
  }
  createTrueInstance<T>(C: ClassType<T>) {
    const keys = Object.entries(new C());
    const res = {};
    for (const [key, value] of keys) {
      if (typeof value !== "function") {
        res[key] = true;
      }
    }
    return res;
  }
}
