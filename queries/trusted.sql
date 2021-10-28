SELECT
    cpf,
    matricula,
    nome_completo,
    data_de_ingresso 
FROM (
    SELECT
        cpf,
        CAST(matricula as INT64) as matricula,
        CONCAT(nome, " ", sobrenome) as nome_completo,
        email,
        PARSE_DATETIME("%A %b %e %H:%M:%S %Y", data_de_ingresso) as data_de_ingresso,
        ROW_NUMBER() OVER(PARTITION BY matricula ORDER BY CONCAT(nome, " ", sobrenome) ASC) as rank_matricula
    FROM 
        $project_id.$USER.tb_bigquery_raw
) AS t1 
WHERE 
    rank_matricula = 1
