--> ULID <--
--  https://stackoverflow.com/questions/75628114/append-a-column-with-an-ulid-to-an-existing-mysql-table

DELIMITER //
DROP FUNCTION IF EXISTS ulid //
CREATE FUNCTION ULID () RETURNS CHAR(26) DETERMINISTIC
BEGIN
DECLARE s_hex CHAR(32);
SET s_hex = LPAD(HEX(CONCAT(UNHEX(CONV(ROUND(UNIX_TIMESTAMP(CURTIME(4))*1000), 10, 16)), RANDOM_BYTES(10))), 32, '0');
RETURN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CONCAT(LPAD(CONV(SUBSTRING(s_hex, 1, 2), 16, 32), 2, '0'), LPAD(CONV(SUBSTRING(s_hex, 3, 15), 16, 32), 12, '0'), LPAD(CONV(SUBSTRING(s_hex, 18, 15), 16, 32), 12, '0')), 'V', 'Z'), 'U', 'Y'), 'T', 'X'), 'S', 'W'), 'R', 'V'), 'Q', 'T'), 'P', 'S'), 'O', 'R'), 'N', 'Q'), 'M', 'P'), 'L', 'N'), 'K', 'M'), 'J', 'K'), 'I', 'J');
END //
DELIMITER //

-- # ULID # --