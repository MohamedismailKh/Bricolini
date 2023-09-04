import { Module } from '@nestjs/common';
import { RecyclingCentreController } from './recycling_centre.controller';
import { RecyclingCentreService } from './recycling_centre.service';
import { OfferModule } from 'src/offer/offer.module';
import { AuthModule } from 'src/auth/auth.module';
import { AddsModule } from 'src/adds/adds.module';

@Module({
  imports: [
    OfferModule,
    AuthModule,
    AddsModule
  ],
  controllers: [RecyclingCentreController],
  providers: [RecyclingCentreService]
})
export class RecyclingCentreModule {}
