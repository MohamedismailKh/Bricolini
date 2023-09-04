/* eslint-disable prettier/prettier */
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose'
export class Admin {
     @Prop()
    email:string
    @Prop()
    password:string
}
export const AdminSchema = SchemaFactory.createForClass(Admin);
