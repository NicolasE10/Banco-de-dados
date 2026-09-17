# Hospital Universitário - Movimentador de Contas e Rastreabilidade

**Instituição:** AEMS

**Curso:** Tecnologia em Análise e Desenvolvimento de Sistemas (TADS)

**Disciplina:** Administração de Banco de Dados (DBA)

**Equipe:**
- Nicolas Emanuel Gonçalves Fermino

## Nossa Visão da Arquitetura e Decisões de Modelagem
Para resolver os gargalos operacionais e a perda de histórico do Hospital Universitário, adotamos uma abordagem de segurança estruturada desde a concepção do modelo. A arquitetura foi dividida em dois esquemas isolados: o `workflow`, que concentra a operação diária de trânsito das faturas, e o `audit`, que atua de forma silenciosa rastreando cada ação. Essa segregação garante que o sistema satélite funcione com máxima performance sem expor a camada de governança, assegurando que as faturas médicas não interfiram no ERP legado e mantendo o histórico de movimentações completamente imutável.

## Guia de Instalação e Execução
Execute os scripts no SGBD PostgreSQL rigorosamente nesta ordem:
1. `01_setup_database.sql`
2. `02_seed_data.sql`
3. `03_security_rbac.sql`
4. `04_audit_setup.sql`
5. `05_attack_simulation.sql`
6. `06_forensic_queries.sql`

## Relatório de Incidentes e Parecer Forense
Durante a nossa homologação do ambiente, o sistema foi submetido a baterias de testes ofensivos para validar as regras da LGPD e as trilhas de auditoria. Quando simulamos um usuário operacional tentando adulterar o histórico de movimentações para apagar um erro, o SGBD bloqueou imediatamente a transação, provando a eficácia do controle de privilégios. O mesmo bloqueio imediato ocorreu quando tentamos acessar as credenciais criptografadas, respeitando o mascaramento de dados imposto. Por outro lado, as transferências legítimas de contas da Auditoria para a Central de Guias ocorreram normalmente, e nossos gatilhos de segurança gravaram com sucesso o autor, o momento exato e o conteúdo da alteração. O resultado da análise forense confirma que nossa infraestrutura protege a identidade dos pacientes e garante a autenticidade de toda a esteira do hospital.
