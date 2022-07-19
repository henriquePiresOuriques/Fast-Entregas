import  { getRepository } from 'typeorm';
import { hash } from 'bcryptjs';

import AppError from '../errors/AppError';

import User from '../models/User';


interface Request {
    name: string;
    email: string;
    password: string;
    rua: string;
    numero: string;
    bairro: string;
    complemento: string;
    referencia: string;
}

class CreateUserService {
    public async execute({ name, email, password, rua,  numero, bairro, complemento, referencia }: Request): Promise<User> {
        const usersRepository = getRepository(User);

        const checkUserExists = await usersRepository.findOne({
            where: { email },

        });

        if(checkUserExists) {
            throw new AppError('Email address already used.');
        }

        const hashedPassword = await hash(password, 8);

        const user = usersRepository.create({
            name,
            email,
            password: hashedPassword,
            rua,
            numero,
            bairro,
            complemento,
            referencia

        });

        await usersRepository.save(user);

        return user;
    }
}

export default CreateUserService;
