#导出dev数据库结构
echo 'download dev sql......'
/usr/bin/mysqldump --opt -d -hlocalhost  -uetranss -petranss938937@7782 dev_db_et > ./dev.sql
#导出api数据库结构
echo 'download api sql......'
/usr/bin/mysqldump --opt -h54.169.13.117 -uetranss -petranss938937@7782 t6_db_et > ./api.sql
echo 'diff sql.......'
diff ./dev.sql ./api.sql
