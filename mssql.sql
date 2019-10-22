set nocount on

declare @match_count int,
@s_string varchar(20),
@table_schema varchar(50),
@table_name varchar(50),
@column_name varchar(50),
@sql_string varchar(4000)

select @s_string = '%searched_string%'

declare m_cursor cursor for select
table_schema, table_name, column_name
from information_schema.columns
where table_catalog = 'CATAL_NAME' and table_schema = 'dbo'
and data_type like '%char%'
and table_name = 'table_name'

open m_cursor

fetch next from m_cursor
into @table_schema, @table_name, @column_name

while @@FETCH_STATUS = 0
	begin
		print ' .'
		select @sql_string = 'select count(*) from ' +
@table_schema + '.' + @table_name + ' where' + '[' + @column_name + ']' + '
like ' + '''' + @s_string + ''''
		select @match_count = 0
		exec (@sql_string)
		fetch next from m_cursor into @table_schema, @table_name,
@column_name
	end
		