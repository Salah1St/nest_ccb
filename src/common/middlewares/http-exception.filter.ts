import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
} from "@nestjs/common";
import { Request, Response } from "express";

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();
    const status = exception.getStatus();
    const description = exception.getResponse();
    const stack = process.env.NODE_ENV === "dev" ? exception.stack : undefined;

    response.status(status).json({
      status_code: status,
      description: description,
      timestamp: new Date(),
      path: request.url,
      stack: stack,
    });
  }
}
