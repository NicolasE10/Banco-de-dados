REVOKE ALL ON SCHEMA workflow FROM PUBLIC;
REVOKE ALL ON SCHEMA audit FROM PUBLIC;

CREATE ROLE role_operacional NOLOGIN;
CREATE ROLE role_gestao NOLOGIN;
CREATE ROLE role_admin_workflow NOLOGIN;

GRANT USAGE ON SCHEMA workflow TO role_operacional;
GRANT SELECT ON workflow.setores, workflow.contas_workflow, workflow.movimentacoes, workflow.comentarios TO role_operacional;
GRANT INSERT ON workflow.movimentacoes, workflow.comentarios TO role_operacional;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA workflow TO role_operacional;

GRANT USAGE ON SCHEMA workflow TO role_gestao;

GRANT ALL PRIVILEGES ON SCHEMA workflow TO role_admin_workflow;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA workflow TO role_admin_workflow;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA workflow TO role_admin_workflow;

CREATE USER usr_auditor_op WITH PASSWORD 'senha_segura';
GRANT role_operacional TO usr_auditor_op;

CREATE USER usr_coordenador_gestao WITH PASSWORD 'senha_gestao';
GRANT role_gestao TO usr_coordenador_gestao;

CREATE USER usr_dba_admin WITH PASSWORD 'senha_admin';
GRANT role_admin_workflow TO usr_dba_admin;

GRANT SELECT (id_usuario, login_corp, nome_completo, id_setor, perfil_acesso) ON workflow.usuarios TO role_operacional;

CREATE VIEW workflow.vw_dashboard_gestao AS
SELECT 
    s.nome_setor,
    COUNT(c.id_conta) AS total_contas_setor,
    SUM(c.valor_aprox) AS valor_estimado
FROM workflow.contas_workflow c
JOIN workflow.setores s ON c.setor_atual = s.id_setor
GROUP BY s.nome_setor;

GRANT SELECT ON workflow.vw_dashboard_gestao TO role_gestao;