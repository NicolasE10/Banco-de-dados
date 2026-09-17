SELECT 
    id_log, 
    tabela_alvo, 
    usuario_sessao, 
    operacao, 
    data_hora 
FROM audit.logged_actions 
ORDER BY data_hora DESC;

SELECT 
    usuario_sessao, 
    dados_antigos->>'observacoes' AS observacao_original, 
    dados_novos->>'observacoes' AS observacao_alterada
FROM audit.logged_actions 
WHERE tabela_alvo = 'movimentacoes' AND operacao = 'U';

SELECT 
    id_log, 
    operacao, 
    dados_novos 
FROM audit.logged_actions 
WHERE tabela_alvo = 'movimentacoes' AND operacao = 'I';