drop table camara cascade; --nao sei se e necessario
drop table video cascade;
drop table segmentovideo cascade;
drop table local cascade;
drop table vigia cascade;
drop table eventoemergencia cascade;
drop table processosocorro cascade;
drop table entidademeio cascade;
drop table meio cascade;
drop table meiocombate cascade;
drop table meioapoio cascade;
drop table meiosocorro cascade;
drop table transporta cascade;
drop table alocado cascade;
drop table acciona cascade;
drop table coordenador cascade;
drop table audita cascade;
drop table solicita cascade;


create table camara --inserted
	(num_camara smallint not null unique, --e necessario not null?
	 constraint pk_camara primary key(num_camara));

create table video --inserted
	(data_hora_inicio timestamp not null unique,
	 data_hora_fim timestamp not null,
	 num_camara smallint not null,
     constraint pk_video primary key(num_camara, data_hora_inicio),
	 constraint fk_video_camara foreign key(num_camara) references camara(num_camara));

create table segmentovideo --inserted
	(num_segmento smallint not null unique,
	 duracao time not null,
	 data_hora_inicio timestamp not null,
	 num_camara smallint not null,
	 constraint pk_segmentovideo primary key(num_segmento, data_hora_inicio, num_camara),
	 constraint fk_segmentovideo_camara foreign key(num_camara, data_hora_inicio) references video(num_camara, data_hora_inicio));

create table local --inserted
	(morada_local varchar(255) not null unique,
	 constraint pk_local primary key(morada_local));

create table vigia --inserted
	(morada_local varchar(255) not null,
	 num_camara smallint not null unique,
	 constraint pk_vigia primary key(morada_local, num_camara),
	 constraint fk_vigia_morada foreign key(morada_local) references local(morada_local),
     constraint fk_vigia_camara foreign key(num_camara) references camara(num_camara));

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

create table processosocorro       --(RI) tem de se meter restricao aqui
	(num_processo_socorro smallint not null unique,
	 constraint pk_processosocorro primary key(num_processo_socorro));

create table entidademeio  --inserted
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
	 num_horas smallint not null,               --time ou smallint?
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
	 constraint fk_audita_acciona foreign key(num_meio, nome_entidade, num_processo_socorro) references acciona(num_meio, nome_entidade, num_processo_socorro));

--------CONSTRAINTS das RIs

create table solicita
	(id_coordenador smallint not null,
	 data_hora_inicio_video timestamp not null,
	 num_camara smallint not null,
	 data_hora_inicio timestamp not null,
	 data_hora_fim timestamp not null,
	 constraint pk_solicita primary key(id_coordenador, data_hora_inicio_video, num_camara),
	 constraint fk_solicita_coordenador foreign key(id_coordenador) references coordenador(id_coordenador),
	 constraint fk_solicita_video foreign key(data_hora_inicio_video, num_camara) references video(data_hora_inicio, num_camara));
