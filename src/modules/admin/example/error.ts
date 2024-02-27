import { ErrorException } from "src/error/error.exception";

export const internalServerError = {
  status: 500,
  description: "Internal Server Error",
  type: ErrorException,
};
