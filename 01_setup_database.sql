CREATE DATABASE db_movimentador_contas;

CREATE SCHEMA workflow;
CREATE SCHEMA audit;

CREATE TABLE workflow.setores (
    id_setor SERIAL PRIMARY KEY,
    nome_setor VARCHAR(100) NOT NULL,
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE workflow.usuarios (
    id_usuario SERIAL PRIMARY KEY,
    login_corp VARCHAR(50) UNIQUE NOT NULL,
    nome_completo VARCHAR(150) NOT NULL,
    id_setor INT REFERENCES workflow.setores(id_setor),
    senha_hash VARCHAR(255) NOT NULL,
    perfil_acesso VARCHAR(50) NOT NULL
);

CREATE TABLE workflow.contas_workflow (
    id_conta SERIAL PRIMARY KEY,
    convenio VARCHAR(100) NOT NULL,
    valor_aprox DECIMAL(10,2),
    setor_atual INT REFERENCES workflow.setores(id_setor),
    data_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE workflow.movimentacoes (
    id_movimentacao SERIAL PRIMARY KEY,
    id_conta INT REFERENCES workflow.contas_workflow(id_conta),
    setor_origem INT REFERENCES workflow.setores(id_setor),
    setor_destino INT REFERENCES workflow.setores(id_setor),
    usuario_executor INT REFERENCES workflow.usuarios(id_usuario),
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    observacoes TEXT
);

CREATE TABLE workflow.comentarios (
    id_comentario SERIAL PRIMARY KEY,
    id_conta INT REFERENCES workflow.contas_workflow(id_conta),
    usuario_autor INT REFERENCES workflow.usuarios(id_usuario),
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descricao TEXT NOT NULL
);
