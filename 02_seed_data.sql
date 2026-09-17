INSERT INTO workflow.setores (nome_setor) VALUES 
('Auditoria'), 
('Central de Guias'), 
('Faturamento'), 
('Recurso de Glosa');

INSERT INTO workflow.usuarios (login_corp, nome_completo, id_setor, senha_hash, perfil_acesso) VALUES 
('usr_auditor_op', 'Operador Auditoria', 1, 'scram-sha-256$v1...', 'Operacional'),
('usr_guias_op', 'Operador Guias', 2, 'scram-sha-256$v1...', 'Operacional'),
('usr_coordenador_gestao', 'Coordenador Faturamento', 3, 'scram-sha-256$v1...', 'Gestao'),
('usr_dba_admin', 'Administrador TI', 4, 'scram-sha-256$v1...', 'Admin');

INSERT INTO workflow.contas_workflow (convenio, valor_aprox, setor_atual) VALUES 
('Unimed', 1500.50, 1),
('Bradesco Saude', 3400.00, 2),
('SulAmerica', 890.00, 1);

INSERT INTO workflow.movimentacoes (id_conta, setor_origem, setor_destino, usuario_executor, observacoes) VALUES 
(1, 1, 2, 1, 'Transferido para analise de guias'),
(2, 1, 2, 1, 'Encaminhado direto ao faturamento');

INSERT INTO workflow.comentarios (id_conta, usuario_autor, descricao) VALUES 
(1, 1, 'Aguardando guia de autorizacao cirurgica'),
(2, 2, 'Falta assinatura do medico titular');