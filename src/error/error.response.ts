import { ErrorException } from "./error.exception";

export const adminErrorAlreadyExists = () => new ErrorException("officerId is already exists");
export const adminErrorDatabase = (error: Error) => new ErrorException(`error from database: ${error}`);
