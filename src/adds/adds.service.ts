import { Injectable } from '@nestjs/common';
import { Add } from './schemas/addds.schema';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { addDto } from './dto/create_add.dto';

@Injectable()
export class AddsService {
    constructor(
    @InjectModel(Add.name)
    private readonly addModel: Model<Add>,
    ) { }
    
    async createAdd(add: addDto): Promise<Add>{
        const newadd = new this.addModel(add)
        return newadd.save()
    }
    //Admin can get all adds in the data base
    async getAllAdds(): Promise<Add[]>{
        return this.addModel.find();
    }
    //users can get only adds verified by the Admin
    async getVerifiedAdds(): Promise<Add[]>{
        return this.addModel.find({status: 1})
    }
    
     async getAllNotVerifiedAdds(): Promise<Add[]>{
        return this.addModel.find({status: 0})
    }
    async findAddByUser(username: string): Promise<Add[]>{
        return this.addModel.find({username: username})
    }
    async findAddById(addId: string): Promise<Add>{
        return this.addModel.findById(addId)
    }
    async deleteAdd(id: string) {
        await this.addModel.findByIdAndDelete(id)
    }

   
    async updateAdd(id: string, addDto: addDto):Promise<Add> {
        return this.addModel.findByIdAndUpdate(id, addDto,{new: true}).exec()
    }
}
