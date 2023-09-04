import { Test, TestingModule } from '@nestjs/testing';
import { SimpleUserController } from './simple_user.controller';
import { SimpleUserService } from './simple_user.service';

describe('SimpleUserController', () => {
  let controller: SimpleUserController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [SimpleUserController],
      providers: [SimpleUserService],
    }).compile();

    controller = module.get<SimpleUserController>(SimpleUserController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
