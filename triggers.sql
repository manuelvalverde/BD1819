drop trigger if exists verifica_solicitacao_trigger on solicita;

create or replace function verifica_solicitacao() returns trigger as $$
	begin
	if new.num_camara not in (select num_camara from audita natural join eventoemergencia natural join vigia) then
		raise exception 'O coordenador % não pode socilitar este video.' , new.id_coordenador;
	end if;
	if new.id_coordenador not in (select id_coordenador from audita natural join eventoemergencia natural join vigia) then
		raise exception 'O coordenador % não pode socilitar este video.' , new.id_coordenador;
	end if;
	return new;

	End;
$$ Language plpgsql;


create trigger verifica_solicitacao_trigger before insert on solicita for each row execute procedure verifica_solicitacao();