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


create table camara 
	(num_camara smallint not null unique, --e necessario not null?
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
	 num_camara smallint not null,
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

create table processosocorro       --(RI) tem de se meter restricao aqui ou no eventoemergencia
	(num_processo_socorro smallint not null unique,
	 constraint pk_processosocorro primary key(num_processo_socorro));

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


insert into camara values (1);
insert into camara values (2);
insert into camara values (3);
insert into camara values (4);
insert into camara values (5);
insert into camara values (6);
insert into camara values (7);
insert into camara values (8);
insert into camara values (9);
insert into camara values (10);
insert into camara values (11);
insert into camara values (12);
insert into camara values (13);
insert into camara values (14);
insert into camara values (15);
insert into camara values (16);
insert into camara values (17);
insert into camara values (18);
insert into camara values (19);
insert into camara values (20);
insert into camara values (21);
insert into camara values (22);
insert into camara values (23);
insert into camara values (24);
insert into camara values (25);
insert into camara values (26);
insert into camara values (27);
insert into camara values (28);
insert into camara values (29);
insert into camara values (30);
insert into camara values (31);
insert into camara values (32);
insert into camara values (33);
insert into camara values (34);
insert into camara values (35);
insert into camara values (36);
insert into camara values (37);
insert into camara values (38);
insert into camara values (39);
insert into camara values (40);
insert into camara values (41);
insert into camara values (42);
insert into camara values (43);
insert into camara values (44);
insert into camara values (45);
insert into camara values (46);
insert into camara values (47);
insert into camara values (48);
insert into camara values (49);
insert into camara values (50);
insert into camara values (51);
insert into camara values (52);
insert into camara values (53);
insert into camara values (54);
insert into camara values (55);
insert into camara values (56);
insert into camara values (57);
insert into camara values (58);
insert into camara values (59);
insert into camara values (60);
insert into camara values (61);
insert into camara values (62);
insert into camara values (63);
insert into camara values (64);
insert into camara values (65);
insert into camara values (66);
insert into camara values (67);
insert into camara values (68);
insert into camara values (69);
insert into camara values (70);
insert into camara values (71);
insert into camara values (72);
insert into camara values (73);
insert into camara values (74);
insert into camara values (75);
insert into camara values (76);
insert into camara values (77);
insert into camara values (78);
insert into camara values (79);
insert into camara values (80);
insert into camara values (81);
insert into camara values (82);
insert into camara values (83);
insert into camara values (84);
insert into camara values (85);
insert into camara values (86);
insert into camara values (87);
insert into camara values (88);
insert into camara values (89);
insert into camara values (90);
insert into camara values (91);
insert into camara values (92);
insert into camara values (93);
insert into camara values (94);
insert into camara values (95);
insert into camara values (96);
insert into camara values (97);
insert into camara values (98);
insert into camara values (99);
insert into camara values (100);
