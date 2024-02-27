import { Injectable } from "@nestjs/common";

@Injectable()
export class TimeService {
  dateTimeFormatter(date: Date): string {
    const milliseconds = date.getTime();
    const seconds = Math.floor(milliseconds / 1000);
    const minutes = Math.floor(seconds / 60);
    const hours = Math.floor(minutes / 60);
    const days = Math.floor(hours / 24);

    const formattedString = `${days} days, ${hours % 24} hours`;

    return formattedString;
  }
}
