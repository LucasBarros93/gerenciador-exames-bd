
-- esse arquivo todo ta meio obscuro, full IA entao refazer ou tentar entender



-- 1) Consulta com joins e agregação:
-- Para cada hospital, número de consultas e média de exames médicos CNH por consulta.
SELECT h.id_hospital, e.nome AS nome_hospital, COUNT(DISTINCT c.id_consulta) AS num_consultas,
       COUNT(emc.id) AS num_exames_cnh,
       ROUND( (COUNT(emc.id)::NUMERIC / NULLIF(COUNT(DISTINCT c.id_consulta),0)), 2) AS media_exames_cnh_por_consulta
FROM Hospital h
JOIN Empresa e ON e.id_empresa = h.id_hospital
LEFT JOIN Consulta c ON c.hospital_fk = h.id_hospital
LEFT JOIN Exame_Medico_CNH emc ON emc.consulta_fk = c.id_consulta
GROUP BY h.id_hospital, e.nome
ORDER BY num_consultas DESC;

-- 2) LEFT JOIN (outer join) para encontrar hospitais licenciados sem médicos associados (por contrato)
-- Aqui consideramos "médico associado a hospital" via consultas; outro mapeamento possível é tabela de contratos médico-hospital.
SELECT e.nome AS hospital, h.licenciado,
       COUNT(DISTINCT c.medico_fk) AS medicos_distintos_em_consultas
FROM Hospital h
JOIN Empresa e ON e.id_empresa = h.id_hospital
LEFT JOIN Consulta c ON c.hospital_fk = h.id_hospital
GROUP BY e.nome, h.licenciado
HAVING COUNT(DISTINCT c.medico_fk) = 0 AND h.licenciado = TRUE;

-- 3) Consulta aninhada correlacionada (exemplo de alta complexidade)
-- Buscar cidadãos cujo último prontuário foi atualizado depois da sua última CNH (caso existam)
SELECT cid.nome, cid.cpf,
       (SELECT p.ultima_atualizacao FROM Prontuario p WHERE p.cidadao_fk = cid.id_cidadao) AS ultima_atualizacao_prontuario,
       (SELECT cnh.data_vencimento FROM CNH cnh WHERE cnh.cidadao_fk = cid.id_cidadao)
FROM Cidadao cid
WHERE EXISTS (SELECT 1 FROM Prontuario p WHERE p.cidadao_fk = cid.id_cidadao)
  AND EXISTS (SELECT 1 FROM CNH cnh WHERE cnh.cidadao_fk = cid.id_cidadao)
  AND (SELECT p.ultima_atualizacao FROM Prontuario p WHERE p.cidadao_fk = cid.id_cidadao) >
      (SELECT cnh.data_vencimento FROM CNH cnh WHERE cnh.cidadao_fk = cid.id_cidadao);

-- 4) Relacional divisão: "Médicos que realizaram todos os tipos principais de exame (Psicotécnico, Toxicológico, Médico CNH)"
-- Implementação por NOT EXISTS (forma clássica de divisão relacional)
SELECT DISTINCT m.id_medico, c.nome AS nome_medico
FROM Medico m
JOIN Cidadao c ON c.id_cidadao = m.cidadao_fk
WHERE NOT EXISTS (
    -- tipos que devem existir
    SELECT tipo_req FROM (VALUES ('MEDICO_CNH'), ('PSICOTECNICO'), ('TOXICOLOGICO')) AS tipos(tipo_req)
    WHERE NOT EXISTS (
        -- existe esse médico realizando um exame daquele tipo?
        SELECT 1 FROM (
            SELECT medico_fk, 'MEDICO_CNH' as tipo FROM Exame_Medico_CNH
            UNION ALL
            SELECT medico_fk, 'PSICOTECNICO' as tipo FROM Exame_Psicotecnico
            UNION ALL
            SELECT medico_fk, 'TOXICOLOGICO' as tipo FROM Exame_Toxicologico
        ) AS todos
        WHERE todos.medico_fk = m.id_medico AND todos.tipo = tipos.tipo_req
    )
);

-- 5) Consulta aninhada não correlacionada: cidadãos sem CNH válida (data_vencimento < hoje)
SELECT cid.nome, cid.cpf, cnh.data_vencimento
FROM Cidadao cid
LEFT JOIN CNH cnh ON cnh.cidadao_fk = cid.id_cidadao
WHERE cnh.numero_cnh IS NULL OR cnh.data_vencimento < CURRENT_DATE;

-- 6) Consulta parametrizada útil para o protótipo:
-- Retornar todos os exames (dos 3 tipos) de um cidadão dado o CPF (usado pelo protótipo).
-- Exemplo de query (será parametrizada no Python):
-- SELECT e.tipo_exame, e.id, e.resultado, e.data_exame FROM (
--    SELECT 'MEDICO_CNH' as tipo_exame, id, resultado, data_exame, consulta_fk FROM Exame_Medico_CNH
--    UNION ALL
--    SELECT 'PSICOTECNICO', id, resultado, data_exame, consulta_fk FROM Exame_Psicotecnico
--    UNION ALL
--    SELECT 'TOXICOLOGICO', id, resultado, data_exame, consulta_fk FROM Exame_Toxicologico
-- ) e
-- JOIN Consulta c ON c.id_consulta = e.consulta_fk
-- JOIN Cidadao cid ON cid.id_cidadao = c.cidadao_fk
-- WHERE cid.cpf = %s
-- ORDER BY e.data_exame DESC;

-- OBS: Justifique cada consulta no relatório: por exemplo, a divisão relacional é importante para
-- descobrir médicos que dominam/realizam todos os passos necessários em um fluxo de emissão.