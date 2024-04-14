SET @row_number = 0;
UPDATE aircrafts
SET id = (@row_number:=@row_number+1)
WHERE id IS NOT NULL
ORDER BY id;
SET @row_number = 0;
UPDATE dcs_events
SET id = (@row_number:=@row_number+1)
WHERE id IS NOT NULL
ORDER BY id;
SET @row_number = 0;
UPDATE dcs_parser_log
SET id = (@row_number:=@row_number+1)
WHERE id IS NOT NULL
ORDER BY id;
SET @row_number = 0;
UPDATE flights
SET id = (@row_number:=@row_number+1)
WHERE id IS NOT NULL
ORDER BY id;
SET @row_number = 0;
UPDATE hitsshotskills
SET id = (@row_number:=@row_number+1)
WHERE id IS NOT NULL
ORDER BY id;
SET @row_number = 0;
UPDATE pilots
SET id = (@row_number:=@row_number+1)
WHERE id IS NOT NULL
ORDER BY id;
SET @row_number = 0;
UPDATE pilot_aircrafts
SET id = (@row_number:=@row_number+1)
WHERE id IS NOT NULL
ORDER BY id;
SET @row_number = 0;
UPDATE position_data
SET id = (@row_number:=@row_number+1)
WHERE id IS NOT NULL
ORDER BY id;
SET @row_number = 0;
UPDATE weapons
SET id = (@row_number:=@row_number+1)
WHERE id IS NOT NULL
ORDER BY id;