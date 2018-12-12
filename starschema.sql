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
	(id_data int not null,
	 dia int not null,
	 mes int not null,
	 ano int not null,
	 constraint pk_d_tempo primary key(id_data));

create table f_eventoemergencia
	(evento_id int not null,
	 meio_id int not null,
	 data_id int not null,
	 constraint pk_f_eventoemergencia primary key (evento_id, meio_id, tempo_id),
	 constraint fk_d_evento foreign key(evento_id) references d_evento(id_evento)
	 constraint fk_d_meio foreign key(meio_id) references d_meio(id_meio)
	 constraint fk_d_tempo foreign key(tempo_id) references d_tempo(id_tempo));

insert into d_evento (num_telefone, instante_chamada)
	select num_telefone, instante_chamada
	from eventoemergencia;

insert into d_meio (num_meio, nome_meio, nome_entidade, tipo)
	select num_meio, nome_meio, nome_entidade, 'Socorro'
	from meiosocorro;

insert into d_meio (num_meio, nome_meio, nome_entidade, tipo)
	select num_meio, nome_meio, nome_entidade, 'Apoio'
	from meioapoio;

insert into d_meio (num_meio, nome_meio, nome_entidade, tipo)
	select num_meio, nome_meio, nome_entidade, 'Combate'
	from meiocombate;

insert into d_tempo (dia, mes, ano)
select 
	EXTRACT(day from data) as dia,
	EXTRACT(month from data) as mes,
	EXTRACT(year from data) as ano
from (
	SELECT * FROM generate_series('2008-03-01'::date, '2008-03-04', '1 day')) as data;

insert into f_eventoemergencia (evento_id, meio_id, data_id)
Select (select evento_id 
		from d_evento, acciona, eventoemergencia
		where d_evento.instante_chamada == eventoemergencia.instante_chamada 
		AND d_evento.num_telefone == eventoemergencia.num_telefone
		AND eventoemergencia.processosocorro == acciona.processosocorro) as evento_id,
	   (select meio_id
		from d_meio, acciona
		where d_meio.num_meio == acciona.num_meio 
		AND d_meio.nome_entidade == acciona.nome_entidade) as meio_id,
	   (select data_id
	   	from d_tempo, eventoemergencia
	   	where EXTRACT(year FROM eventoemergencia.instante_chamada) == ano
	   	AND EXTRACT(month FROM eventoemergencia.instante_chamada) == mes
	   	AND EXTRACT(day FROM eventoemergencia.instante_chamada) == dia) as data_id;
