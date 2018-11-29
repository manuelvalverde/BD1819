1-SELECT num_processo_socorro, COUNT(num_processo_socorro) FROM acciona GROUP BY num_processo_socorro HAVING COUNT(num_processo_socorro) = (SELECT MAX(C) FROM (SELECT COUNT(num_processo_socorro) AS C FROM acciona GROUP BY num_processo_socorro) AS Q); 


2-SELECT nome_entidade FROM meio NATURAL JOIN audita WHERE data_hora_inicio>'2018-06-20 23:59:59' and data_hora_fim<'2018-09-24 00:00:00' and num_processo_socorro=(SELECT num_processo_socorro FROM (SELECT num_processo_socorro,COUNT(num_processo_socorro) AS max_count FROM audita GROUP BY num_processo_socorro ORDER BY max_count DESC LIMIT 1) AS max_processo);


3-SELECT num_processo_socorro FROM eventoemergencia NATURAL JOIN acciona WHERE morada_local='Oliveira do Hospital' and instante_chamada BETWEEN '2017-12-31 23:59:59' and '2019-01-01 00:00:00' and num_processo_socorro NOT IN (SELECT num_processo_socorro FROM audita);


4-SELECT COUNT(num_segmento) FROM segmentovideo NATURAL JOIN vigia NATURAL JOIN video WHERE duracao>'00:00:59' and morada_local='Monchique' and data_hora_inicio>'2018-07-31 23:59:59' and data_hora_fim<'2018-09-01 00:00:00';

5-SELECT nome_meio FROM meio NATURAL JOIN acciona NATURAL JOIN meiocombate WHERE num_meio NOT IN (SELECT num_meio FROM meioapoio);

6-SELECT nome_entidade
FROM (SELECT DISTINCT nome_entidade, num_processo_socorro
FROM acciona
WHERE (num_meio, nome_entidade) IN 
	(SELECT num_meio, nome_entidade
	 FROM meiocombate
	 WHERE (num_meio, nome_entidade) NOT IN
	 	(SELECT num_meio, nome_entidade
	 	 FROM alocado)
	 and
	 (num_meio, nome_entidade) NOT IN 
	 	(SELECT num_meio, nome_entidade 
	 	 FROM transporta))) As foo
GROUP BY nome_entidade
HAVING COUNT(num_processo_socorro) >= (SELECT Count(distinct num_processo_socorro) From acciona);
