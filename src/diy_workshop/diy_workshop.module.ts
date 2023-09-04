import { Module } from '@nestjs/common';
import { DiyWorkshopController } from './diy_workshop.controller';
import { DiyWorkshopService } from './diy_workshop.service';
import { MongooseModule } from '@nestjs/mongoose';

import { AuthModule } from 'src/auth/auth.module';
import { AddsModule } from 'src/adds/adds.module';

@Module({
  imports: [
   AddsModule,
    AuthModule
  ],
  controllers: [DiyWorkshopController],
  providers: [DiyWorkshopService]
})
export class DiyWorkshopModule {}
