CREATE TABLE audit.logged_actions (
    id_log SERIAL PRIMARY KEY,
    esquema VARCHAR(50),
    tabela_alvo VARCHAR(50),
    usuario_sessao VARCHAR(50),
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    operacao CHAR(1),
    dados_antigos JSONB,
    dados_novos JSONB
);

CREATE OR REPLACE FUNCTION audit.fn_audit_trigger()
RETURNS TRIGGER SECURITY DEFINER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO audit.logged_actions (esquema, tabela_alvo, usuario_sessao, operacao, dados_antigos)
        VALUES (TG_TABLE_SCHEMA, TG_TABLE_NAME, session_user, 'D', row_to_json(OLD)::jsonb);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO audit.logged_actions (esquema, tabela_alvo, usuario_sessao, operacao, dados_antigos, dados_novos)
        VALUES (TG_TABLE_SCHEMA, TG_TABLE_NAME, session_user, 'U', row_to_json(OLD)::jsonb, row_to_json(NEW)::jsonb);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO audit.logged_actions (esquema, tabela_alvo, usuario_sessao, operacao, dados_novos)
        VALUES (TG_TABLE_SCHEMA, TG_TABLE_NAME, session_user, 'I', row_to_json(NEW)::jsonb);
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_audit_movimentacoes
AFTER INSERT OR UPDATE OR DELETE ON workflow.movimentacoes
FOR EACH ROW EXECUTE FUNCTION audit.fn_audit_trigger();

CREATE TRIGGER trg_audit_contas
AFTER INSERT OR UPDATE OR DELETE ON workflow.contas_workflow
FOR EACH ROW EXECUTE FUNCTION audit.fn_audit_trigger();