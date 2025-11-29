-- Esse arquivo contém todas as 5 consultas de média e alta complexidade exigidas pelo trabalho.


-----------------------------------------------------------------------------------------------

-- CONSULTA 1: RETORNA O ID, TIPO DE ATENDIMENTO E TOTAL DE PRONTUÁRIOS ACESSADOS DOS HOSPITAIS CUJO VOLUME DE ACESSO A PRONTUÁRIOS
-- É MAIOR QUE A MÉDIA. (A ID DO HOSPITAL ESTÁ EM CONSONÂNCIA COM A LGPD)

-----------------------------------------------------------------------------------------------

SELECT 
    T.id_hospital,
    T.tipo_atendimento, 
    T.total_prontuarios
FROM 
    (SELECT i.empresa AS id_hospital, i.tipo_atendimento AS tipo_atendimento, COUNT(r.prontuario) AS total_prontuarios
     FROM rel_prontuario_hospital r
     JOIN hospital i ON r.hospital = i.empresa
     GROUP BY i.empresa, i.tipo_atendimento) AS T
JOIN 
    (SELECT AVG(contagem_interna) AS media_global
     FROM (
         SELECT COUNT(*) AS contagem_interna
         FROM rel_prontuario_hospital
         GROUP BY hospital
     ) AS base_calculo
    ) AS M
    ON T.total_prontuarios > M.media_global
    ORDER BY T.total_prontuarios DESC; -- Ordena pelo volume de acessos ao prontuário, do maior para o menor.

-----------------------------------------------------------------------------------------------

-- CONSULTA 2: ESSA CONSULTA ENVOLVE CONCEITOS DA DIVISÃO RELACIONAL.
-- RETORNAR A ID, A IDADE, A DATA/HORA DA CONSULTA DOS PACIENTES QUE FORAM ATENDIDOS
-- POR MÉDICOS QUE ATENDERAM EM TODOS HOSPITAIS PÚBLICOS. RETORNAR A ID DO MÉDICO TAMBÉM.
-- (A ID_PACIENTE E ID_MEDICO ESTÃO EM CONSONÂNCIA COM A LGPD).

-----------------------------------------------------------------------------------------------

SELECT 
    dados_paciente.idcidadao AS id_paciente,
    c.medico AS id_medico,
    ROUND((CURRENT_DATE - dados_paciente.nascimento)/365) As idade_paciente, -- Calcula a idade do paciente com base na data atual
    c.data_hora
FROM consulta c
JOIN cidadao dados_paciente ON dados_paciente.idcidadao = c.cidadao
WHERE c.medico IN (
    SELECT m.cidadao
    FROM medico m
    WHERE NOT EXISTS (
        SELECT h.empresa
        FROM hospital h
        WHERE h.tipo_atendimento = 'Público'

        EXCEPT

        SELECT cons.hospital
        FROM consulta cons
        WHERE cons.medico = m.cidadao

    )
)
ORDER BY id_paciente;

-----------------------------------------------------------------------------------------------

-- CONSULTA 3: CONSULTAR, POR ESTADO, O TOTAL DE CIDADÃOS COM CNHs ATIVAS E O TOTAL DE CIDADÃOS COM
-- CNHs ATIVAS MAS QUE TAMBÉM POSSUEM TODOS OS EXAMES EXIGIDOS PARA A CNH. E A PARTIR DESSAS INFORMAÇÕES
-- TAMBÉM CONSULTAR A PORCENTAGEM DE CNHs ATIVAS COM TODOS OS EXAMES EM RELAÇÃO AO TOTAL DE CNHs ATIVAS,
-- POR ESTADO. 

-- OBS: COALESCE É USADO PARA CONVERTER NULL EM 0, PARA MOSTRAR ESTADOS COM TOTAL_CNH_COM_EXAMES = 0% 
-----------------------------------------------------------------------------------------------

SELECT 
    T.estado,
    COALESCE(R.total_CNH_com_exames, 0) AS total_CNH_com_exames,
    T.total_CNH,
    ROUND((COALESCE(R.total_CNH_com_exames, 0)::DECIMAL / T.total_CNH) * 100, 2) AS porcentagem_com_exames
FROM 
    (SELECT d.estado AS estado, COUNT(c.cidadao) AS total_CNH
     FROM detran d JOIN cnh c ON d.empresa = c.detran
     GROUP BY d.estado) AS T -- Obtém a relação com a contagem do total de cidadãos com CNH ativas por estado
LEFT JOIN
    (SELECT D.estado AS estado, COUNT(DISTINCT C.cidadao) AS total_CNH_com_exames
     FROM detran D JOIN cnh C ON D.empresa = C.detran
     JOIN 
        consulta ON C.cidadao = consulta.cidadao
     JOIN 
        exame_psicotecnico ON consulta.id = exame_psicotecnico.consulta
     JOIN 
        exame_toxicologico ON consulta.id = exame_toxicologico.consulta
     JOIN 
        exame_medico_cnh ON consulta.id = exame_medico_cnh.consulta
     GROUP BY D.estado) AS R -- Obtém a relação com a contagem do total de cidadãos com CNH ativas, por estado, que fizeram todos os exames exigidos pela CNH
ON T.estado = R.estado
ORDER BY porcentagem_com_exames DESC; -- Ordena com relação ao valor da porcentagem, do maior para o menor.
 
 -----------------------------------------------------------------------------------------------

-- CONSULTA 4: OBTÉM O NÚMERO DE ATENDIMENTO POR DIA DA SEMANA (SEGUNDA À DOMINGO) EM UM DETERMINADO 
-- ANO PARA CADA HOSPITAL, BEM COMO A RESPECTIVA ID DO HOSPITAL. A CONSULTA TAMBÉM LEVA EM CONSIDERAÇÃO 
-- HOSPITAIS QUE AINDA NÃO HAVIAM FEITO NENHUM ATENDIMENTO EM ALGUM ANO ESPECÍFICO.

-----------------------------------------------------------------------------------------------

SELECT 
    h.empresa AS id_hospital, EXTRACT(YEAR FROM con.data_hora) AS ano,
    SUM(CASE WHEN EXTRACT(DOW FROM con.data_hora) = 0 THEN 1 ELSE 0 END) AS domingo,
    SUM(CASE WHEN EXTRACT(DOW FROM con.data_hora) = 1 THEN 1 ELSE 0 END) AS segunda,
    SUM(CASE WHEN EXTRACT(DOW FROM con.data_hora) = 2 THEN 1 ELSE 0 END) AS terca,
    SUM(CASE WHEN EXTRACT(DOW FROM con.data_hora) = 3 THEN 1 ELSE 0 END) AS quarta,
    SUM(CASE WHEN EXTRACT(DOW FROM con.data_hora) = 4 THEN 1 ELSE 0 END) AS quinta,
    SUM(CASE WHEN EXTRACT(DOW FROM con.data_hora) = 5 THEN 1 ELSE 0 END) AS sexta,
    SUM(CASE WHEN EXTRACT(DOW FROM con.data_hora) = 6 THEN 1 ELSE 0 END) AS sabado
FROM hospital h 
LEFT JOIN consulta con ON con.hospital = h.empresa -- Considera hospitais que não houveram nenhuma consulta em um determinado ano
GROUP BY h.empresa, EXTRACT(YEAR FROM con.data_hora)
ORDER BY id_hospital, EXTRACT(YEAR FROM con.data_hora) DESC; -- Ordena por ano e por id do hospital



-----------------------------------------------------------------------------------------------
-- CONSULTA 5: OBTÉM, PARA OS CIDADÃOS DESEMPREGADOS, A PORCENTAGEM DE CADA FAIXA ETÁRIA PARA QUE POSSUI CNH
-----------------------------------------------------------------------------------------------

SELECT 
    CASE 
       WHEN EXTRACT(YEAR FROM AGE(c.nascimento)) BETWEEN 18 AND 25 THEN '1. Jovem (18-25)'
       WHEN EXTRACT(YEAR FROM AGE(c.nascimento)) BETWEEN 26 AND 35 THEN '2. Adulto Jovem (26-35)'
       WHEN EXTRACT(YEAR FROM AGE(c.nascimento)) BETWEEN 36 AND 50 THEN '3. Adulto (36-50)'
       WHEN EXTRACT(YEAR FROM AGE(c.nascimento)) BETWEEN 51 AND 65 THEN '4. Adulto Maduro (51-65)'
       WHEN EXTRACT(YEAR FROM AGE(c.nascimento)) > 65 THEN '5. Idoso (65+)'
    END AS faixa_etaria,

    COUNT(*) AS numero_ocorrencias, -- conta as ocorrencias pra cada faixa etaria

    ROUND(
        (COUNT(*) * 100.0) / (  
            SELECT COUNT(*)
            FROM cnh carteira_total
            JOIN cidadao c_total ON c_total.idcidadao = carteira_total.cidadao
            WHERE NOT EXISTS (
                SELECT *
                FROM contrato ct_total
                WHERE ct_total.carteira_trabalho = c_total.idcidadao
                AND ct_total.demissao IS NULL
            )
        ), 
    2) AS porcentagem_total

FROM cnh carteira
JOIN cidadao c ON c.idcidadao = carteira.cidadao
WHERE NOT EXISTS (
    SELECT *
    FROM contrato ct
    WHERE ct.carteira_trabalho = c.idcidadao 
    AND ct.demissao IS NULL 
) 
GROUP BY faixa_etaria
ORDER BY faixa_etaria;