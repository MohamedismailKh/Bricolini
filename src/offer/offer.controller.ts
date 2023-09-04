/* eslint-disable prettier/prettier */
 /* eslint-disable prettier/prettier */
 import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFile, UseGuards, Request } from '@nestjs/common';
 import { OfferService } from './offer.service';
 import { CreateOfferDto } from './dto/create-offer.dto';
 import { UpdateOfferDto } from './dto/update-offer.dto';
 import { FileInterceptor } from '@nestjs/platform-express';
 import {diskStorage} from 'multer';
 import { Observable, of } from 'rxjs';
 import { v4 as uuidv4 } from 'uuid';
 //mport path from 'path';
 import path = require('path');
 import { join } from 'path';
 import { JwtAuthGuard } from 'src/auth/guards/jwt-guard';
 import { Offer } from './schemas/offer.schema';
 import { User } from 'src/auth/schemas/user.schema';
 import { AuthGuard } from '@nestjs/passport';
 
 
 export const storage = {
   storage : diskStorage({
     destination : "./uploads",
     filename : (req , file , cb) => {
       const filename : string = path.parse(file.originalname).name.replace(/\s/g,'') + uuidv4();
       const extension : string = path.parse(file.originalname).ext;
       cb(null , `${file.originalname}${extension}`)
     }
   })
 
 }
 
 
 @Controller('offer')
 export class OfferController {
   constructor(private readonly offerService: OfferService) {}
 
   /*@Post()
   @UseInterceptors(FileInterceptor('file' , {
     storage : diskStorage({
       destination : "./uploads",
       filename : (req , file , cb) => {
         cb(null , `${file.originalname}`)
       }
     })
   }))
   async uploadFile() {
     
     return "success";
   }*/
   @Get()
   findAllV() {
     return this.offerService.findAllVerifiedOffers();
   }
   @Get()
   findAllNV() {
     return this.offerService.findAllNotVerifiedOffers();
   }
   @Get(':id')
   findOne(@Param('id') id: string) {
     return this.offerService.findOne(id);
   }
   @Patch(':id')
   update(@Param('id') id: string, @Body() updateOfferDto: UpdateOfferDto) {
     return this.offerService.update(id, updateOfferDto);
   }
   @Delete(':id')
   remove(@Param('id') id: string) {
     return this.offerService.remove(id);
   }
   @UseGuards(AuthGuard('JWT'))
   @Post()
   @UseInterceptors(FileInterceptor('file', storage))
 
   async uploadFile(@UploadedFile() file, @Request() req): Promise<Observable<object>> {
     const user: User = req.user.user;
     console.log(req.user);
     console.log(file);
     return of({imagePath: file.filename});
 }
 @Post("/verify")
 verifyingImgC(@Body() body: { imageUrl: string }) {
   const { imageUrl } = body;
   return this.offerService.verifyFile(imageUrl);
 }
 
 
   /*@UseGuards(JwtAuthGuard)
   @Post()
   @UseInterceptors(FileInterceptor('file', storage))
   uploadFile(@UploadedFile() file) : Observable<Object>{
     //const user: User =req.user.user;
     //console.log(user)
     console.log(file);
     return of({imagePath : file.filename});
   }*/
 }
