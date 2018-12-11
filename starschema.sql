drop table if exists d_evento;
drop table if exists d_meio;
drop table if exists d_tempo;
drop table if exists f_eventoemergencia;

create table d_evento 
	(id_evento int not null AUTO_INCREMENT,
	 num_telefone numeric(15,0) not null,
	 instante_chamada timestamp not null,
	 constraint pk_d_evento primary key(id_evento));

create table d_meio 
	(id_meio int not null AUTO_INCREMENT,
	 num_meio int not null,
	 nome_meio varchar(255) not null,
	 nome_entidade varchar(255) not null,
	 tipo varchar(255) not null,
	 constraint pk_d_meio primary key(id_meio));

create table d_tempo
	(id_tempo int not null,
	 dia int not null,
	 mes int not null,
	 ano int not null,
	 constraint pk_d_tempo primary key(id_tempo));

create table f_eventoemergencia
	(evento_id int not null,
	 meio_id int not null,
	 tempo_id int not null,
	 constraint pk_f_eventoemergencia primary key (evento_id, meio_id, tempo_id),
	 constraint fk_d_evento foreign key(evento_id) references d_evento(id_evento)
	 constraint fk_d_meio foreign key(meio_id) references d_meio(id_meio)
	 constraint fk_d_tempo foreign key(tempo_id) references d_tempo(id_tempo));

INSERT INTO table2 (column1, column2, column3, ...)
SELECT column1, column2, column3, ...
FROM table1
WHERE condition; 

insert into d_evento (num_telefone, instante_chamada)
	select num_telefone, instante_chamada
	from eventoemergencia;

insert into d_meio (num_meio, nome_meio, nome_entidade)
	select num_meio, nome_meio, nome_entidade
	from meio;

insert into d_tempo (dia, mes, ano)
	select 
		DAYOFMONTH(data) as dia,
	    MONTH(data) as mes,
	    YEAR(data) as ano
	from (
		select date(instante_chamada) 
		from eventoemergencia;
    ) As data;

insert into f_eventoemergencia
	select 




#vvvvvvvvvvvvvvvv CODIGO DO ANO PASSADO vvvvvvvvvvvvvvv

SELECT DATEPART(year, '2017/08/25') AS DatePartInt
#PREENCHER AS TABELAS
INSERT INTO user_dimension (nif, nome, telefone)
    SELECT *
    FROM user;
   
INSERT INTO localizacao_dimension (edificio, espaco, posto)
    SELECT DISTINCT edificio, espaco, posto
    FROM (SELECT morada as edificio, codigo as espaco, NULL as posto
          FROM oferta
          NATURAL JOIN espaco
           
          UNION ALL
           
          SELECT morada as edificio, codigo_espaco as espaco, codigo as posto
          FROM oferta
          NATURAL JOIN posto) result;
           
DROP TABLE IF EXISTS numbers_small;
DROP TABLE IF EXISTS numbers;
 
CREATE TABLE numbers_small (
    number INT);
INSERT INTO numbers_small VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
 
CREATE TABLE numbers (
    number INT);
INSERT INTO numbers
    SELECT thousands.number * 1000 + hundreds.number * 100 + tens.number * 10 + ones.number
    FROM numbers_small thousands, numbers_small hundreds, numbers_small tens, numbers_small ones;
 
INSERT INTO data_dimension (dia, semana, mes, semestre, ano)
SELECT
    DAYOFMONTH(date) as dia,
    WEEKOFYEAR(date) as semana,
    MONTH(date) as mes,
    IF(QUARTER(date)<3, 1, 2) as semestre,
    YEAR(date) as ano
FROM (
    SELECT
        number,
        DATE_ADD( '2016-01-01', INTERVAL number DAY ) AS date
    FROM numbers
    WHERE DATE_ADD( '2016-01-01', INTERVAL number DAY ) BETWEEN '2016-01-01' AND '2017-12-31'
) AS result
ORDER BY number;
 
INSERT INTO tempo_dimension (hora, minuto)
SELECT
    HOUR(data) as hora,
    MINUTE(data) as minuto
FROM (
    SELECT
        number,
        DATE_ADD( '2016-01-01 00:00:00', INTERVAL number MINUTE ) AS data
    FROM numbers
    WHERE DATE_ADD( '2016-01-01 00:00:00', INTERVAL number MINUTE ) BETWEEN '2016-01-01 00:00:00' AND '2016-01-01 23:59:00'
) AS result
ORDER BY number;
 
DROP TABLE numbers_small;
DROP TABLE numbers;
 
INSERT INTO reserva_fact (user_id, localizacao_id, data_id, tempo_id, montante, duracao)
SELECT (SELECT user_id
           FROM user_dimension
           WHERE user_dimension.nif = aluga.nif) user_id,
       (SELECT localizacao_id
        FROM (SELECT localizacao_id, edificio as morada, posto as codigo
              FROM localizacao_dimension
              WHERE posto IS NOT NULL
                  
              UNION ALL
                  
              SELECT localizacao_id, edificio as morada, espaco as codigo
              FROM localizacao_dimension
              WHERE posto IS NULL) result
        WHERE morada = aluga.morada and codigo = aluga.codigo) location_id,
       (SELECT data_id
        FROM data_dimension
        WHERE dia = DAYOFMONTH(data) AND mes = MONTH(data) AND ano = YEAR(data)) data_id,
       (SELECT tempo_id
        FROM tempo_dimension, paga
        WHERE hora = HOUR(data) AND minuto = MINUTE(data) AND paga.numero = aluga.numero) tempo_id,
       tarifa * (data_fim - data_inicio + 1) montante,
       data_fim - data_inicio + 1 duracao
FROM aluga
NATURAL JOIN oferta
LEFT JOIN paga
ON (paga.numero = aluga.numero)
WHERE (YEAR(data_inicio) BETWEEN 2016 AND 2017) AND
      (YEAR(data_fim) BETWEEN 2016 AND 2017);
       
#QUERY OLAP
SELECT *
FROM (SELECT reserva_id, localizacao_id, data_id, edificio, espaco, posto, dia, mes, ano, AVG(montante) as media
      FROM reserva_fact
      NATURAL JOIN localizacao_dimension
      NATURAL JOIN data_dimension
      GROUP BY posto, espaco, dia, mes WITH ROLLUP) result
UNION (SELECT reserva_id, localizacao_id, data_id, edificio, espaco, posto, dia, mes, ano, AVG(montante) as media
       FROM reserva_fact
       NATURAL JOIN localizacao_dimension
       NATURAL JOIN data_dimension
       GROUP BY espaco, dia, mes, posto)
UNION (SELECT reserva_id, localizacao_id, data_id, edificio, espaco, posto, dia, mes, ano, AVG(montante) as media
       FROM reserva_fact
       NATURAL JOIN localizacao_dimension
       NATURAL JOIN data_dimension
       GROUP BY dia, mes, posto, espaco)
UNION (SELECT reserva_id, localizacao_id, data_id, edificio, espaco, posto, dia, mes, ano, AVG(montante) as media
       FROM reserva_fact
       NATURAL JOIN localizacao_dimension
       NATURAL JOIN data_dimension
       GROUP BY mes, posto, espaco, dia)
UNION (SELECT reserva_id, localizacao_id, data_id, edificio, espaco, posto, dia, mes, ano, AVG(montante) as media
       FROM reserva_fact
       NATURAL JOIN localizacao_dimension
       NATURAL JOIN data_dimension
       GROUP BY posto, dia, espaco, mes)
UNION (SELECT reserva_id, localizacao_id, data_id, edificio, espaco, posto, dia, mes, ano, AVG(montante) as media
       FROM reserva_fact
       NATURAL JOIN localizacao_dimension
       NATURAL JOIN data_dimension
       GROUP BY dia, espaco, mes, posto)





















create table camara
	(num_camara smallint not null unique, 
	 constraint pk_camara primary key(num_camara));

create table video
	(data_hora_inicio timestamp not null unique,
	 data_hora_fim timestamp not null,
	 num_camara smallint not null,
     constraint pk_video primary key(num_camara, data_hora_inicio),
	 constraint fk_video_camara foreign key(num_camara) references camara(num_camara));

create table segmentovideo 
	(num_segmento smallint not null unique,
	 duracao time not null,
	 data_hora_inicio timestamp not null,
	 num_camara smallint not null,
	 constraint pk_segmentovideo primary key(num_segmento, data_hora_inicio, num_camara),
	 constraint fk_segmentovideo_camara foreign key(num_camara, data_hora_inicio) references video(num_camara, data_hora_inicio));

create table local 
	(morada_local varchar(255) not null unique,
	 constraint pk_local primary key(morada_local));

create table vigia 
	(morada_local varchar(255) not null,
	 num_camara smallint not null unique,
	 constraint pk_vigia primary key(morada_local, num_camara),
	 constraint fk_vigia_morada foreign key(morada_local) references local(morada_local),
     constraint fk_vigia_camara foreign key(num_camara) references camara(num_camara));

create table processosocorro      
	(num_processo_socorro smallint not null unique,
	 constraint pk_processosocorro primary key(num_processo_socorro));

create table eventoemergencia
	(num_telefone numeric(15,0) not null,
	 instante_chamada timestamp not null,
	 nome_pessoa varchar(80) not null, 
	 morada_local varchar(255) not null,
	 num_processo_socorro smallint,
	 constraint pk_eventoemergencia primary key(num_telefone, instante_chamada),
	 constraint fk_eventoemergencia_morada foreign key(morada_local) references local(morada_local),
	 constraint fk_eventoemergencia_processo foreign key(num_processo_socorro) references processosocorro(num_processo_socorro),
	 constraint unique_caller unique(num_telefone, nome_pessoa));

create table entidademeio
	(nome_entidade varchar(80) not null unique,
	 constraint pk_entidademeio primary key(nome_entidade));

create table meio 
	(num_meio smallint not null,
	 nome_meio varchar(80) not null,
	 nome_entidade varchar(80) not null,
	 constraint pk_meio primary key(num_meio, nome_entidade),
	 constraint fk_meio_entidade foreign key(nome_entidade) references entidademeio(nome_entidade));

create table meiocombate 
	(num_meio smallint not null,
	 nome_entidade varchar(80) not null,
	 constraint pk_meiocombate primary key(num_meio, nome_entidade),
	 constraint fk_meiocombate_meio foreign key(num_meio, nome_entidade) references meio(num_meio, nome_entidade));

create table meioapoio 
	(num_meio smallint not null,
	 nome_entidade varchar(80) not null,
	 constraint pk_meioapoio primary key(num_meio, nome_entidade),
	 constraint fk_meioapoio_meio foreign key(num_meio, nome_entidade) references meio(num_meio, nome_entidade));

create table meiosocorro 
	(num_meio smallint not null,
	 nome_entidade varchar(80) not null,
	 constraint pk_meiosocorro primary key(num_meio, nome_entidade),
	 constraint fk_meiosocorro_meio foreign key(num_meio, nome_entidade) references meio(num_meio, nome_entidade));

create table transporta
	(num_meio smallint not null,
	 nome_entidade varchar(80) not null,
	 num_vitimas smallint not null,
	 num_processo_socorro smallint not null,
	 constraint pk_transporta primary key(num_meio, nome_entidade, num_processo_socorro),
	 constraint fk_transporta_meio foreign key(num_meio, nome_entidade) references meiosocorro(num_meio, nome_entidade),
	 constraint fk_transporta_processo foreign key(num_processo_socorro) references processosocorro(num_processo_socorro));

create table alocado
	(num_meio smallint not null,
	 nome_entidade varchar(80) not null,
	 num_horas smallint not null,              
	 num_processo_socorro smallint not null,
	 constraint pk_alocado primary key(num_meio, nome_entidade, num_processo_socorro),
	 constraint fk_alocado_meio foreign key(num_meio, nome_entidade) references meioapoio(num_meio, nome_entidade),
	 constraint fk_alocado_processo foreign key(num_processo_socorro) references processosocorro(num_processo_socorro));

create table acciona
	(num_meio smallint not null,
	 nome_entidade varchar(80) not null,
	 num_processo_socorro smallint not null,
	 constraint pk_acciona primary key(num_meio, nome_entidade, num_processo_socorro),
	 constraint fk_acciona_meio foreign key(num_meio, nome_entidade) references meio(num_meio, nome_entidade),
	 constraint fk_acciona_processo foreign key(num_processo_socorro) references processosocorro(num_processo_socorro));

create table coordenador
	(id_coordenador smallint not null unique,
	 constraint pk_coordenador primary key(id_coordenador));

create table audita
	(id_coordenador smallint not null,
	 num_meio smallint not null,
	 nome_entidade varchar(80) not null,
	 num_processo_socorro smallint not null,
	 data_hora_inicio timestamp not null,
	 data_hora_fim timestamp not null,
	 data_auditoria date not null,
	 texto varchar(1000) not null,
	 constraint pk_audita primary key(id_coordenador, num_meio, nome_entidade, num_processo_socorro),
	 constraint fk_audita_coordenador foreign key(id_coordenador) references coordenador(id_coordenador),
	 constraint fk_audita_acciona foreign key(num_meio, nome_entidade, num_processo_socorro) references acciona(num_meio, nome_entidade, num_processo_socorro),
	 check (data_hora_inicio < data_hora_fim),
	 check (data_auditoria >= current_date));

create table solicita
	(id_coordenador smallint not null,
	 data_hora_inicio_video timestamp not null,
	 num_camara smallint not null,
	 data_hora_inicio timestamp not null,
	 data_hora_fim timestamp not null,
	 constraint pk_solicita primary key(id_coordenador, data_hora_inicio_video, num_camara),
	 constraint fk_solicita_coordenador foreign key(id_coordenador) references coordenador(id_coordenador),
	 constraint fk_solicita_video foreign key(data_hora_inicio_video, num_camara) references video(data_hora_inicio, num_camara));

