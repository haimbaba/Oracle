SELECT file_name, tablespace_name, ROUND(bytes/1024000) MB
FROM dba_data_files
ORDER BY 1;