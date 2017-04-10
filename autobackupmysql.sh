filename=`date +%Y%m%d` 
/usr/bin/mysqldump --opt -uroot -petranssmysql123456  t6_db_et |gzip >/data/backupSql$filename.sql.gz 
#mail -s '数据库备份' 1091907642@qq.com < /data/backupSql$filename.sql.gz
#mail -s '数据库备份' 280889146@qq.com < /data/backupSql$filename.sql.gz
