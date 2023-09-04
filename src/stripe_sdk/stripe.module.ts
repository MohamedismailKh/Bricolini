import { Module } from '@nestjs/common';
import { PaymentController } from './stripe.controller';
import { StripeService } from './stripe.service';

@Module({
  controllers: [PaymentController],
  providers: [StripeService],
})
export class StripeModule {}
