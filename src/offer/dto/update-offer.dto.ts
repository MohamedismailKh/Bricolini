/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/mapped-types';
import { CreateOfferDto } from './create-offer.dto';

export class UpdateOfferDto extends PartialType(CreateOfferDto) {
    _id: string
    readonly id_offerProvider:string
    readonly img?:string
    readonly location?:string
    readonly paid?:boolean
    readonly price?: number
    readonly id_recyclingCenter: string
    readonly id_transporter: string
    readonly selected : boolean
    readonly confirmedByTransporter :boolean
}
