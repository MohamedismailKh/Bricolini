/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { AddsService } from 'src/adds/adds.service';
import { Add } from 'src/adds/schemas/addds.schema';
import { OfferService } from 'src/offer/offer.service';
import { Offer } from 'src/offer/schemas/offer.schema';
@Injectable()
export class TransporterService {
  constructor(
    private offerservice: OfferService,
        private addservice: AddsService
   
  ) {}
    
  async getoffers(id: string): Promise<Offer[]>{
    return this.offerservice.findoffer_transporter(id)
  }

    async getallAdds(): Promise<Add[]>{
        return this.addservice.getVerifiedAdds()
    }
 
}
