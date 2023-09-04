import { Body, Controller, Post } from '@nestjs/common';
import { StripeService } from './stripe.service';

@Controller('payment')
export class PaymentController {
  constructor(private stripeService: StripeService) {}

  @Post('create-payment-intent')
  async createPaymentIntent() {
    const clientSecret = await this.stripeService.createPaymentIntent(1000, 'usd');

    return {
      clientSecret,
    };
  }

  @Post('stripe-webhooks')
  handleStripeWebhook(@Body() stripeEvent) {
    this.stripeService.handleStripeWebhook(stripeEvent);
  }
}
