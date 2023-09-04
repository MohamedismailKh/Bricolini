import { Test, TestingModule } from '@nestjs/testing';
import { DiyWorkshopController } from './diy_workshop.controller';

describe('DiyWorkshopController', () => {
  let controller: DiyWorkshopController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [DiyWorkshopController],
    }).compile();

    controller = module.get<DiyWorkshopController>(DiyWorkshopController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
