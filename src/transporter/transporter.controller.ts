/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Put, Delete, Body, Param } from '@nestjs/common';
import { TransporterService } from './transporter.service';
import { Offer } from 'src/offer/schemas/offer.schema';
import { Add } from 'src/adds/schemas/addds.schema';


@Controller('transporters')
export class TransporterController {
  constructor(private readonly transporterService: TransporterService) { }

  @Get("offers/:id")
  getoffers(@Param("id") id: string): Promise<Offer[]>{
    return this.transporterService.getoffers(id)
  }
  @Get("/Adds")
  async getAllAdds(): Promise<Add[]>{
    return this.transporterService.getallAdds()
  }

}
