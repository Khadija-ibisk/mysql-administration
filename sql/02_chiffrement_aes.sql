use techshop_db;
show tables;
Describe clients;

ALTER TABLE clients 
CHANGE phone_encrypted phone_encrypted VARBINARY(255);

SET @SECRET_KEY = '<cle_aes_a_definir>';


DELIMITER $$

CREATE FUNCTION fn_encrypt_phone(p_phone VARCHAR(50))
RETURNS VARBINARY(255)
DETERMINISTIC
BEGIN
    RETURN AES_ENCRYPT(p_phone, '<cle_aes_a_definir>');
END $$

DELIMITER ;


DELIMITER $$

CREATE FUNCTION fn_decrypt_phone(p_encrypted VARBINARY(255))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    RETURN AES_DECRYPT(p_encrypted, '<cle_aes_a_definir>');
END $$

DELIMITER ;


UPDATE clients
SET phone_encrypted = fn_encrypt_phone(phone_encrypted);

select * from clients;

INSERT INTO clients (nom, email, phone_encrypted)
VALUES ('Ali', 'ali@example.com', fn_encrypt_phone('0602030405'));


SELECT fn_encrypt_phone('0602030405');

INSERT INTO clients (nom, prenom, email, phone_encrypted)
VALUES ('Ali', 'khan','ali@example.com', fn_encrypt_phone('0602030405'));
/*chiffrement*/
SELECT id_client, nom, email, phone_encrypted
FROM clients
ORDER BY id_client DESC
LIMIT 5;

/*Dechyfrement*/
SELECT id_client, nom, fn_decrypt_phone(phone_encrypted) AS phone
FROM clients
ORDER BY id_client DESC
LIMIT 5;

SELECT 
    id_client,
    nom,
    email,
    fn_decrypt_phone(phone_encrypted) AS phone
FROM clients;


SELECT phone_encrypted FROM clients LIMIT 5;

SELECT fn_decrypt_phone(phone_encrypted) FROM clients LIMIT 5;
