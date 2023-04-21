CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    telefone VARCHAR(11) NOT NULL CHECK (telefone ~ '^[(][0-9]{2}[)]\s[0-9]{4}-[0-9]{4}$')
);

CREATE TABLE cliente_fisico (
    cpf VARCHAR(11) PRIMARY KEY,
    rg VARCHAR (20),
    id_cliente INTEGER NOT NULL REFERENCES cliente(id) ON DELETE CASCADE
);

CREATE TABLE cliente_juridico (
    cnpj VARCHAR(14) PRIMARY KEY,
    nome_fantasia VARCHAR(255) NOT NULL,
    id_cliente INTEGER NOT NULL REFERENCES cliente(id) ON DELETE CASCADE
);

CREATE TABLE endereco (
    id SERIAL PRIMARY KEY,
    rua VARCHAR(255),
    numero VARCHAR(100),
    complemento VARCHAR(255),
    cep VARCHAR(8) CHECK (cep ~ '^[0-9]{5}-[0-9]{3}$'),
    cidade VARCHAR(255) NOT NULL,
    estado VARCHAR(255) NOT NULL,
    id_cliente INTEGER NOT NULL REFERENCES cliente(id) ON DELETE CASCADE
);

CREATE TABLE pedido (
    id SERIAL PRIMARY KEY,
    data_pedido DATE NOT NULL,
    valor NUMERIC(12,2) NOT NULL,
    id_cliente INTEGER NOT NULL REFERENCES cliente(id) ON DELETE CASCADE
);

CREATE TABLE editora (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    nome_contato VARCHAR(255)
);

CREATE TABLE editora_telefone (
    editora_id INTEGER NOT NULL REFERENCES editora(id) ON DELETE CASCADE,
    telefone VARCHAR(11) NOT NULL,
    PRIMARY KEY (editora_id, telefone)
);

CREATE TABLE livro (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    ano_publicacao DATE NOT NULL,
    valor NUMERIC(12,2) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    id_editora INTEGER NOT NULL REFERENCES editora(id) ON DELETE CASCADE,
    CONSTRAINT unique_isbn UNIQUE (isbn)
);

CREATE TABLE pedido_item (
    id SERIAL PRIMARY KEY,
    quantidade INTEGER NOT NULL,
    valor NUMERIC(10,2) NOT NULL,
    id_pedido INTEGER NOT NULL REFERENCES pedido(id) ON DELETE CASCADE,
    id_livro INTEGER NOT NULL REFERENCES livro(id) ON DELETE CASCADE
);

CREATE TABLE estoque (
    id SERIAL PRIMARY KEY,
    quantidade INTEGER NOT NULL,
    id_livro INTEGER NOT NULL REFERENCES livro(id) ON DELETE CASCADE
);
