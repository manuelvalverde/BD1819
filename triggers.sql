#1
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


#2
drop trigger if exists check_if_accionado on alocado;

create or replace function check_accionado() returns trigger as $$
begin
    if new.num_meio not in (Select num_meio from meioapoio natural join acciona) then
        raise exception 'O meio de apoio % da entidade % nao foi accionado.',new.num_meio,new.nome_entidade;
    end if;
    if new.nome_entidade not in (Select nome_entidade from meioapoio natural join acciona) then
        raise exception 'O meio de apoio % da entidade % nao foi accionado.',new.num_meio,new.nome_entidade;
    end if;
    if new.num_processo_socorro not in (Select num_processo_socorro from meioapoio natural join acciona) then
        raise exception 'O meio de apoio % da entidade % nao foi accionado.',new.num_meio,new.nome_entidade;
    end if;
    return new;
    
End;
$$ Language plpgsql;

create trigger check_if_accionado before insert on alocado for each row execute procedure check_accionado();