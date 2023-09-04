/* eslint-disable prettier/prettier */
/* eslint-disabl  e prettier/prettier */
import { Module } from '@nestjs/common';
import { AdminService } from './admin.service';
import { AdminController } from './admin.controller';
import { AuthService } from 'src/auth/auth.service';
import { MongooseModule } from '@nestjs/mongoose';
import { Admin, AdminSchema } from './schemas/admin.schema';
import { Offer, OfferSchema } from 'src/offer/schemas/offer.schema';
import { User, UserSchema } from 'src/auth/schemas/user.schema';
import { JwtService } from '@nestjs/jwt';
import { OfferService } from 'src/offer/offer.service';
import { AddsModule } from 'src/adds/adds.module';
import { Add, AddSchema } from 'src/adds/schemas/addds.schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Admin.name, schema: AdminSchema },
      { name: Offer.name, schema: OfferSchema },
      { name: User.name, schema: UserSchema },
      { name: Add.name, schema: AddSchema },
    ]),AddsModule
    
  ],
  controllers: [AdminController],
  providers: [AdminService,AuthService,JwtService,OfferService]
})
export class AdminModule {}
