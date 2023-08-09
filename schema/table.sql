-- Exemplo de uso: Sistema de chamado, Ordem de serviço

DROP TABLE IF EXISTS test;
CREATE TABLE test
(   
    ulid char(40) NOT NULL,
    year_autonum varchar(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_year YEAR DEFAULT (CURRENT_TIMESTAMP),
    created_date DATE DEFAULT (CURRENT_TIMESTAMP),
	created_time TIME DEFAULT (CURRENT_TIMESTAMP),
    -- updated_date datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
    PRIMARY KEY (ulid)    
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3; 
CREATE INDEX `year_autonum` ON `test` (`year_autonum`);

DELIMITER //
DROP TRIGGER IF EXISTS custom_autonums_bi//

CREATE TRIGGER custom_autonums_bi BEFORE INSERT ON test
FOR each ROW
BEGIN
	DECLARE year_autonum BIGINT;
		SET @ANO_CORRENTE = YEAR(NOW());
		SET @INDEX_ID = (SELECT count(created_at) FROM test WHERE YEAR(created_at) = @ANO_CORRENTE);
		SET @ID = CONCAT(CONCAT(@ANO_CORRENTE,'-'), RIGHT(CONCAT('00000', CONVERT(@INDEX_ID + 1, CHAR)), 5));
		SET NEW.year_autonum = @ID;
        SET NEW.ulid = CONCAT(CONCAT(@ID,'_'),(SELECT ulid()));
END//

DELIMITER ;
-- # ID DA MENSAGEM PERSONALIZADO # --

