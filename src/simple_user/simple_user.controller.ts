/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request,UseInterceptors, UploadedFile, } from '@nestjs/common';
import { SimpleUserService } from './simple_user.service';
import { FileInterceptor } from '@nestjs/platform-express';
import {diskStorage} from 'multer';
import { Observable, of } from 'rxjs';
import { v4 as uuidv4 } from 'uuid';
import path = require('path');
import { join } from 'path';
import { JwtAuthGuard } from 'src/auth/guards/jwt-guard';
import { User } from 'src/auth/schemas/user.schema';


import { CreateOfferDto } from 'src/offer/dto/create-offer.dto';
import { UpdateOfferDto } from 'src/offer/dto/update-offer.dto';
import { Add } from 'src/adds/schemas/addds.schema';

@Controller('simple-user')
export class SimpleUserController {
  constructor(private readonly simpleUserService: SimpleUserService) {}

  @Post("/offers")
  async CreatOffer(
    @Body()
    offerdto: CreateOfferDto
  ) {
    return this.simpleUserService.createOffer(offerdto)
  }
  @Get("/Adds")
  async getAllAdds(): Promise<Add[]>{
    return this.simpleUserService.getallAdds()
  }
  @Patch("offers/:id")
  updateOffer(
    @Param('id')
    id: string,
    @Body()
    updateofferdto:UpdateOfferDto
  ) {
    return this.simpleUserService.updateOffer(id, updateofferdto)
    }
  
  @Delete("offers/:id")
  RemoveOffer(
    @Param('id')
    id: string
  ) {
    return this.simpleUserService.removeOffer(id)
  }
}
