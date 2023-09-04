import { Test, TestingModule } from '@nestjs/testing';
import { RecyclingCentreController } from './recycling_centre.controller';

describe('RecyclingCentreController', () => {
  let controller: RecyclingCentreController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [RecyclingCentreController],
    }).compile();

    controller = module.get<RecyclingCentreController>(RecyclingCentreController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
