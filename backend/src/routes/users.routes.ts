import { Router } from 'express';

import CreateUserService from '../services/CreateUserService';

import ensureAuthenticated from '../middlewares/ensureAuthenticated'

const usersRouter = Router();

usersRouter.post('/', async (request, response) => {
        const {
            name,
            email,
            password,
            rua,
            numero,
            bairro,
            complemento,
            referencia } = request.body;

        const createUser = new CreateUserService();

        const user = await createUser.execute({
            name,
            email,
            password,
            rua,
            numero,
            bairro,
            complemento,
            referencia
        });

        delete user.password;

        return response.json(user);
});

export default usersRouter;
