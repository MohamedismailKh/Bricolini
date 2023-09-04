/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import * as passport from '@nestjs/passport';

@Injectable()
export class JwtAuthGuard extends passport.AuthGuard('jwt') {}