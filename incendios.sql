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
	
	 )