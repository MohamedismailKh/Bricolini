import {Body, Controller, Get, Post} from '@nestjs/common';
import { DiyWorkshopService } from './diy_workshop.service';
import { Add } from 'src/adds/schemas/addds.schema';
import { addDto } from 'src/adds/dto/create_add.dto';


@Controller('diy-workshop')
export class DiyWorkshopController {
    constructor(
       private diyworkshopservice: DiyWorkshopService
    ) {}
    
 @Get("/Adds")
  async getAllAdds(): Promise<Add[]>{
    return this.diyworkshopservice.getallAdds()
 }
    @Post("/adds")
  createAdd(
    @Body()
    add: addDto
  ) {
    return this.diyworkshopservice.createAdd(add)
    }
}
