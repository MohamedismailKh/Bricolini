import { Prop } from "@nestjs/mongoose";
import { categ } from "src/auth/schemas/user.schema";

 export class addDto {
    @Prop()
    username: string;
    @Prop()
    description: string;
    @Prop()
    img: string;
    @Prop()
    user_category: categ
}