do $$
declare
	match_count integer;
	c_row record;
	search_string varchar(255) := 'search_string';


begin
	
	for c_row in select * from information_schema.columns ic
	where ic.table_schema = 'public'
	and ic.data_type like '%char%'
	loop
		execute 'select count(*) from ' || c_row.table_name 
		|| ' where '
		|| c_row.column_name
		|| ' = $1' into match_count
		using search_string;
		if match_count > 0 then
			raise notice '% %', c_row.table_name, match_count;
		end if;
	end loop;
end

$$;
