/* eslint-disable prettier/prettier */
export interface Offer {
    user_id?: number;
    img?: string;
    location?: string;
    role?: UserRole;
    paid?: boolean;
    price?: number
}

export enum UserRole {
    ADMIN = 'admin',
    CHIEFEDITOR = 'chiefeditor',    
    EDITOR = 'editor',
    USER = 'user'
}