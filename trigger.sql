drop trigger if exists check_if_accionado on alocado;
create or replace function check_accionado() returns trigger as $$
begin
    if new.num_meio,new.nome_entidade,new.num_processo_socorro not in (Select num_meio,nome_entidade,num_processo_socorro from meioapoio natural join acciona)
        raise exception 'O meio de apoio % da entidade % nao foi accionado',new.num_meio,new.nome_entidade,new.num_processo_socorro;
    enf if;
    return new;
    
End;
$$ Language plpgsql;
