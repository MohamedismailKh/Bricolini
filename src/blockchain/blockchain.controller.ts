/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { BlockchainService } from './blockchain.service';

@Controller('blockchain')
export class BlockchainController {
  constructor(private readonly blockchainService: BlockchainService) {}

  @Post('/transactions') 
  async addTransaction(
    @Body() transactionData: {
      date: number;
      wasteType: string;
      quantity: number;
      price: number;
    },
  
  ) {
    return await this.blockchainService.addTransaction(
      transactionData.date,
      transactionData.wasteType,
      transactionData.quantity,
      transactionData.price,
    );
  }
  @Get('/transactions')
  async getTransactions() {
    return await this.blockchainService.getTransactions();
  }
  /*@Get(':address')
  async getBadgeStatus(@Param('address') address: string): Promise<string> {
    return await this.blockchainService.getBadgeStatus();
  }*/

  @Get('/badges')
  async getBadgeStatus(): Promise<string> {
    return await this.blockchainService.getBadgeStatus();
  }
}