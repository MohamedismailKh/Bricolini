import { Module } from '@nestjs/common';
import { AddsService } from './adds.service';
import { AddsController } from './adds.controller';
import { Add, AddSchema } from './schemas/addds.schema';
import { MongooseModule } from '@nestjs/mongoose';

@Module({
  imports: [MongooseModule.forFeature([{ name: Add.name, schema: AddSchema }])],
  providers: [AddsService],
  controllers: [AddsController],
  exports:[AddsService]
})
export class AddsModule {}
