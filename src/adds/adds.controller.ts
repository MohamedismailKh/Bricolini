import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { AddsService } from './adds.service';
import { addDto } from './dto/create_add.dto';
import { Add } from './schemas/addds.schema';
import { param } from 'jquery';

@Controller('adds')
export class AddsController {
    constructor(private readonly addservice: AddsService) { }
    
    @Post('/create')
    async CreateAdd(
        @Body()
        add : addDto
    ): Promise<Add>{
        return this.addservice.createAdd(add)
    }

    @Get()
    findAll() {
        return this.addservice.getAllAdds()
    }
    @Get("/accepted")
    findposts() {
        return this.addservice.getVerifiedAdds()
    }
    @Get(':username')
    findByUser(
        @Param('username')
        username: string) {
        return this.addservice.findAddByUser(username)
    }
    
    @Delete(':id')
    deleteAdd(
        @Param('id')
        id: string
    ) {
        return this.addservice.deleteAdd(id)
    }

    @Patch(':id')
    updateAdd(
        @Param('id')
        id: string,
        @Body()
        adddto: addDto
    ) {
        return this.addservice.updateAdd(id, adddto)
    }

}
