/* eslint-disable prettier/prettier */
import { Injectable, NotFoundException } from '@nestjs/common';
import { Offer } from 'src/offer/schemas/offer.schema';
import { OfferService } from 'src/offer/offer.service';
import { AuthService } from 'src/auth/auth.service';
import { categ, User } from 'src/auth/schemas/user.schema';
import { UpdateOfferDto } from 'src/offer/dto/update-offer.dto';
import { plainToClass } from 'class-transformer';
import { AddsService } from 'src/adds/adds.service';
import { Add } from 'src/adds/schemas/addds.schema';
import { addDto } from 'src/adds/dto/create_add.dto';

@Injectable()
export class RecyclingCentreService {
    constructor(
        private offerservice: OfferService,
        private authservice: AuthService,
        private addservice: AddsService
    ) { }

    
    async getallOffers(): Promise<Offer[]>{
        return this.offerservice.findAllOffers()
    }
    
    async getallAdds(): Promise<Add[]>{
        return this.addservice.getVerifiedAdds()
    }
    async createAdd(addDto: addDto): Promise<Add>{
        return this.addservice.createAdd(addDto)
    }

    async selectOffer(offer_id: string, id_RC:string) {
        
        const update_offer = await this.offerservice.findOne(offer_id);
        update_offer.id_recyclingCenter = id_RC;
       
        this.offerservice.update(offer_id, update_offer)
      
    }
    async selectTransporter(offer_id: string, id_Transp: string) {
        const updateoffer = await this.offerservice.findOne(offer_id)
        updateoffer.id_transporter = id_Transp;
        this.offerservice.update(offer_id, updateoffer)
      
    }   
    
    async getPendingOffers(id_RecyclingCenter:string): Promise<Offer[]>{
        return this.offerservice.findPendingOffers(id_RecyclingCenter)
    }
     
}
