/* eslint-disable prettier/prettier */
/* eslint-disable @typescript-eslint/ban-types */
import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { AuthService } from 'src/auth/auth.service';
import { categ, User } from 'src/auth/schemas/user.schema';
import { OfferService } from 'src/offer/offer.service';
import { Offer } from 'src/offer/schemas/offer.schema';
import { CreateAdminDto } from './dto/create-admin.dto';
import { UpdateAdminDto } from './dto/update-admin.dto';
import { Admin } from './schemas/admin.schema';
import { Add } from 'src/adds/schemas/addds.schema';
import { AddsService } from 'src/adds/adds.service';

@Injectable()
export class AdminService {
  constructor(
    @InjectModel(Admin.name) private readonly adminModel: Model<Admin>,
    @InjectModel(Offer.name) private readonly offerModel: Model<Offer>,
    @InjectModel(Add.name) private readonly AddModel: Model<Add>,
    private readonly userService:AuthService,
    private readonly offerservice: OfferService,
    private addservice: AddsService
   
  ) {}

  async create(createAdminDto: CreateAdminDto): Promise<Admin> {
    const createdAdmin = new this.adminModel(createAdminDto);
    return createdAdmin.save();
  }

  async findAll(): Promise<Admin[]> {
    return this.adminModel.find().exec();
  }

  async findById(id: string): Promise<Admin> {
    return this.adminModel.findById(id).exec();
  }

  async update(id: string, updateAdminDto: UpdateAdminDto): Promise<Admin> {
    return this.adminModel.findByIdAndUpdate(id, updateAdminDto, { new: true }).exec();
  }

  async delete(id: string): Promise<void> {
    await this.adminModel.findByIdAndDelete(id).exec();
  }

  async acceptOffer(offerId: string): Promise<void> {
    const offer = await this.offerModel.findById(offerId).exec();
    if (!offer) {
      throw new NotFoundException('Offer not found');
    }
    offer.status = 1;
    await offer.save();
  }


  async acceptAdd(addId: string) {
    const add = await this.AddModel.findById(addId).exec();
    if (!add) {
      throw new NotFoundException('add not found')
    }
    add.status = 1;
    await add.save();
  }
  async getAllNotAcceptedAdds(): Promise<Add[]>{
    return this.addservice.getAllNotVerifiedAdds();
  }

  async deleteOffer(offerId: string): Promise<void> {
    const offer = await this.offerModel.findById(offerId).exec();
    if (!offer) {
      throw new NotFoundException('Offer not found');
    }
    await this.offerModel.findByIdAndDelete(offerId).exec();
  }
  async getAllUsersByCategory(category: categ): Promise<User[]> {
    return this.userService.findByCategory(category);
  }
  async getAllNotVerifiedOffers():Promise<Offer[]>{
    return this.offerservice.findAllNotVerifiedOffers();
  }
}
