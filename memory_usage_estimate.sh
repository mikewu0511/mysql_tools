#!/bin/sh

mysql -uroot -p -B -E --silent <<_SQL_
SELECT CONCAT((
    @@key_buffer_size
  + @@query_cache_size
  + (@@innodb_buffer_pool_size * 1.05 + 20*1024*1024)
  + @@innodb_additional_mem_pool_size
  + @@innodb_log_buffer_size
  + @@max_connections * (
      @@read_buffer_size
    + @@read_rnd_buffer_size
    + @@sort_buffer_size
    + @@join_buffer_size
    + @@binlog_cache_size
    + @@tmp_table_size
    + @@thread_stack)) / 1024/1024/1024,
  ' GB') AS "POTENTIAL MEMORY USAGE";
_SQL_
