CREATE OR REPLACE FUNCTION keepcoding.clean_integer(enteros INT) RETURNS INT AS
(IFNULL(enteros, -999999))