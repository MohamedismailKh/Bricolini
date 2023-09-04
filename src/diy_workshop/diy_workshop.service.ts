import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';

import * as mongoose from 'mongoose';
import { AddsService } from 'src/adds/adds.service';
import { addDto } from 'src/adds/dto/create_add.dto';
import { Add } from 'src/adds/schemas/addds.schema';
import { AuthService } from 'src/auth/auth.service';

@Injectable()
export class DiyWorkshopService {
    constructor(
        
        private authservice: AuthService,
        private addservice: AddsService
    ) { }

      async getallAdds(): Promise<Add[]>{
        return this.addservice.getVerifiedAdds()
    }
    async createAdd(adddto: addDto): Promise<Add>{
        return this.addservice.createAdd(adddto)
    }
}