/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Param, Patch, Post, Put } from '@nestjs/common';
import { RecyclingCentreService } from './recycling_centre.service';
import { Offer } from 'src/offer/schemas/offer.schema';

import { User, categ } from 'src/auth/schemas/user.schema';
import { Add } from 'src/adds/schemas/addds.schema';
import { addDto } from 'src/adds/dto/create_add.dto';

@Controller('recycling-centre')
export class RecyclingCentreController {
    constructor(private recyclingCenterservice: RecyclingCentreService) { }
    
   
    @Get("/offers")
    async getAllOffers(): Promise<Offer[]>{
        return this.recyclingCenterservice.getallOffers()
    }
  @Get("/Adds")
  async getAllAdds(): Promise<Add[]>{
    return this.recyclingCenterservice.getallAdds()
  }


  
  @Post("/adds")
  createAdd(
    @Body()
    add: addDto
  ) {
    return this.recyclingCenterservice.createAdd(add)
    }
  
  
    @Get("offers/pending/:id_recyclingCenter")
    async getPendingOffers(
    @Param('id_recyclingCenter')
    id_recyclingCenter: string
    ) :Promise<Offer[]>{
    return this.recyclingCenterservice.getPendingOffers(id_recyclingCenter)
      }
    @Put(':id_RC/offers/:offer_id/select')
  async selectOffer(
    @Param('offer_id') offerId: string,
    @Param('id_RC') recyclingCenterId: string,
  ) {
    await this.recyclingCenterservice.selectOffer(offerId, recyclingCenterId);
    return { message: 'Offer selected successfully' };
    }
    
    @Put('offers/:offer_id/transporter/:id_transp')
     async selectTransporter(
    @Param('offer_id') offerId: string,
    @Param('id_transp') transporyterId: string,
  ) {
    await this.recyclingCenterservice.selectTransporter(offerId, transporyterId);
    return { message: 'Transporter selected successfully' };
  }

}
