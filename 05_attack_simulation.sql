SET ROLE usr_auditor_op;

UPDATE workflow.movimentacoes SET observacoes = 'Apagando erro medico' WHERE id_movimentacao = 1;

DELETE FROM workflow.movimentacoes WHERE id_movimentacao = 2;

SELECT id_usuario, senha_hash FROM workflow.usuarios;

INSERT INTO workflow.movimentacoes (id_conta, setor_origem, setor_destino, usuario_executor, observacoes) 
VALUES (3, 1, 2, 1, 'Transferencia validada pela auditoria interna');

INSERT INTO workflow.comentarios (id_conta, usuario_autor, descricao) 
VALUES (3, 1, 'Fatura liberada para central de guias');

RESET ROLE;