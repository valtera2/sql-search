--set serveroutput on size 100000

declare
  match_count integer;
  v_sql varchar(255);
begin
for t in (select ac.owner, ac.table_name, ac.column_name
  from all_tab_columns ac
join all_tables t on ac.table_name = t.table_name and
ac.owner = t.owner
where ac.table_name like '%' and ac.owner = user and ac.data_type like
'%CHAR%'
  ) loop
  
  v_sql := 'select count(*) from ' || t.owner || '.' || t.table_name ||
  ' where '||'"' || t.column_name || '"' ||' = :1';
  
  execute immediate v_sql
  into match_count
  using 'search_string';
  if match_count > 0 then
    dbms_output.put_line( t.table_name || ' ' ||t.column_name|| ' ' || match_count );
  end if;
  end loop;
end;