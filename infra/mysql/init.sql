-- Chay 1 lan khi khoi tao MySQL lan dau (mount vao /docker-entrypoint-initdb.d/)
-- Tao tai khoan rieng cho mysqld-exporter (chi co quyen SELECT, khong dung root)
CREATE USER IF NOT EXISTS 'exporter'@'%' IDENTIFIED BY 'ChangeMe_Exporter_2026';
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';
FLUSH PRIVILEGES;
