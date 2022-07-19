import{ Entity, Column, PrimaryGeneratedColumn, CreateDateColumn } from 'typeorm';


@Entity('users')
class User {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column()
    name: string;

    @Column()
    email: string;

    @Column()
    password: string;

    @Column()
    rua: string;

    @Column()
    numero: string;

    @Column()
    bairro: string;

    @Column()
    complemento: string;

    @Column()
    referencia: string;

    @CreateDateColumn()
    created_at: Date;
}

export default User;
