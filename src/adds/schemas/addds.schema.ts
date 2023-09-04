import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { categ } from "src/auth/schemas/user.schema";


@Schema({
    timestamps: true
})
    export class Add {
    @Prop()
    username: string;
    @Prop()
    description: string;
    @Prop()
    img: string;
    @Prop()
    user_category: categ;
    @Prop()
    status: number
}
export const AddSchema = SchemaFactory.createForClass(Add);