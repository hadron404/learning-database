# 查看数据库表锁、行锁信息 https://blog.csdn.net/hjtlovelife/article/details/90731610
# Mysql的锁类型、锁模式、加锁方式  https://blog.csdn.net/u014710633/article/details/90486467
# 深入理解MySQL——INNODB_LOCKS表和INNODB_LOCK_WAITS表详解 https://blog.csdn.net/lijuncheng963375877/article/details/123848983
# Mysql innodb 锁分析 https://blog.csdn.net/wmq880204/article/details/52505040
# Mysql 的update语句会加哪些锁 https://www.maoyingdong.com/mysql-update-sql-locking/
# 查看mysql 表是否被锁 https://blog.csdn.net/love666666shen/article/details/122419330
# 记一次spring事物嵌套REQUIRES_NEW造成的死锁问题 https://www.codenong.com/js0debb21c3de5/
# MySql行锁变表锁，性能下降？间隙锁（X,GAP），行锁（X,REC_NOT_GAP），区间锁（X）带你进阶 https://blog.csdn.net/a_teacher_java/article/details/124806667
# 查看正在锁的事务
SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCKS;
# 查看造成死锁的语句
show status like '%lock%';
# 查看数据表被锁状态
show OPEN TABLES where In_use > 0;
# 查看等待锁的事务
SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCK_WAITS;