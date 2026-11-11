USE mysql;

-- 1) Création des rôles (bonnes pratiques MySQL 8+)
CREATE ROLE IF NOT EXISTS role_readonly;
CREATE ROLE IF NOT EXISTS role_readwrite;
CREATE ROLE IF NOT EXISTS role_analyst;
CREATE ROLE IF NOT EXISTS role_backup;
CREATE ROLE IF NOT EXISTS role_replication;
CREATE ROLE IF NOT EXISTS role_admin;

-- 2) Permissions sur la base techshop_db

-- Lecture seule
GRANT SELECT ON techshop_db.* TO role_readonly;

-- Lecture + écriture (pas de DROP, pas d'ALTER)
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE
ON techshop_db.* TO role_readwrite;

-- Analyste (vues, reporting)
GRANT SELECT ON techshop_db.* TO role_analyst;

-- Backup (mysqldump)
GRANT SELECT, SHOW VIEW, TRIGGER, LOCK TABLES
ON techshop_db.* TO role_backup;

-- Réplication
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO role_replication;

-- Admin de la base (limité à techshop_db)
GRANT ALL PRIVILEGES ON techshop_db.* TO role_admin;

-- 3) Création des utilisateurs

CREATE USER IF NOT EXISTS 'app_read'@'10.0.0.%'
IDENTIFIED BY '<mot_de_passe_fort>';

CREATE USER IF NOT EXISTS 'app_write'@'10.0.0.%'
IDENTIFIED BY '<mot_de_passe_fort>';

CREATE USER IF NOT EXISTS 'analyst'@'10.0.1.%'
IDENTIFIED BY '<mot_de_passe_fort>';

CREATE USER IF NOT EXISTS 'backup_user'@'127.0.0.1'
IDENTIFIED BY '<mot_de_passe_fort>';

CREATE USER IF NOT EXISTS 'repl_user'@'%'
IDENTIFIED BY '<mot_de_passe_fort>';

CREATE USER IF NOT EXISTS 'admin_shop'@'10.0.0.10'
IDENTIFIED BY '<mot_de_passe_fort>';

-- 4) Attribution des rôles aux utilisateurs

GRANT role_readonly TO 'app_read'@'10.0.0.%';
GRANT role_readwrite TO 'app_write'@'10.0.0.%';
GRANT role_analyst TO 'analyst'@'10.0.1.%';
GRANT role_backup TO 'backup_user'@'127.0.0.1';
GRANT role_replication TO 'repl_user'@'%';
GRANT role_admin TO 'admin_shop'@'10.0.0.10';

-- 5) Définir le rôle par défaut

SET DEFAULT ROLE role_readonly to 'app_read'@'10.0.0.%';
SET DEFAULT ROLE role_readwrite to 'app_write'@'10.0.0.%';
SET DEFAULT ROLE role_analyst to 'analyst'@'10.0.1.%';
SET DEFAULT ROLE role_backup to 'backup_user'@'127.0.0.1';
SET DEFAULT ROLE role_replication to 'repl_user'@'%';
SET DEFAULT ROLE role_admin to 'admin_shop'@'10.0.0.10';

FLUSH PRIVILEGES;




/*TEEEEEEESSSSSSTTTTT*/


SELECT user, host FROM mysql.user
WHERE user IN ('app_read','app_write','analyst','backup_user','repl_user','admin_shop');



SELECT DISTINCT ROLE_NAME
FROM information_schema.APPLICABLE_ROLES
WHERE ROLE_NAME LIKE 'role_%';


SHOW GRANTS FOR 'app_read'@'10.0.0.%';
SHOW GRANTS FOR 'app_write'@'10.0.0.%';
SHOW GRANTS FOR 'admin_shop'@'10.0.0.10';
