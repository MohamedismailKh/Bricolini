import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';


// entry point of Nestjs
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new ValidationPipe());
  app.enableCors();
  await app.listen(3000);
}
process.on('uncaughtException', (err) => {
  console.log(err);
})
bootstrap();