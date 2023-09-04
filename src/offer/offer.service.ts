/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreateOfferDto } from './dto/create-offer.dto';
import { UpdateOfferDto } from './dto/update-offer.dto';
import { spawn } from 'child_process';
import { json } from 'express';
import { Offer } from './schemas/offer.schema';
@Injectable()
export class OfferService {
  constructor(
    @InjectModel(Offer.name)
    private readonly offerrModel: Model<Offer>,
  ) {}

  async createNewOffer(offerdto: CreateOfferDto): Promise<Offer> {
    const createdoffer= new this.offerrModel(offerdto);
    createdoffer.status=0;
    return createdoffer.save();
  }
  async findAllOffers(): Promise<Offer[]> {
    return this.offerrModel.find(//{id_recyclingCenter:null, status:1}
    ).exec();
  }
  async findPendingOffers(id_RecyclingCenter:string): Promise<Offer[]>{
    return this.offerrModel.find({id_recyclingCenter:id_RecyclingCenter}).exec()
  }
  async findAllVerifiedOffers(): Promise<Offer[]> {
    return this.offerrModel.find({status:1}).exec();
  }
  async findAllNotVerifiedOffers(): Promise<Offer[]> {
    return this.offerrModel.find({status:0}).exec();
  }
  
  async findoffer_transporter(id: string): Promise<Offer[]>{
    return this.offerrModel.find({id_transporter:id})
  }
  async findOne(id: string): Promise<Offer> {
    return this.offerrModel.findById(id).exec();
  }

  async findOfferByImgUrl(url: string) {
    return this.offerrModel.findById({img:url}).exec();
  }
  
  async update(id: string, offerDto): Promise<Offer> {
    return this.offerrModel.findByIdAndUpdate(id, offerDto, { new: true }).exec();
  }

  async remove(id: string): Promise<void> {
    await this.offerrModel.findByIdAndRemove(id).exec();
  }

  async verifyFile(imageUrl : string){
    const pythonProcess = spawn('python3', ['IA_MODEL/main.py', imageUrl]);
    pythonProcess.stdout.on('data', async (data) => {
      const probaDistribution = JSON.parse(data)["probability distribution"];
      const garageType = JSON.parse(data)["Garbage type"];

      if (Math.max(probaDistribution) >= 0.6) {
        const offer = await this.findOfferByImgUrl(imageUrl);
        offer.status=1;
        await offer.save();

      } else {
        const offer =await this.findOfferByImgUrl(imageUrl);
        offer.status=0;
        await offer.save();
      }
    });

    pythonProcess.stderr.on('data', (data) => {
      console.error(data.toString());
      return { error: 'Verification process failed' };
    });
    return { processing: true };
}



}
