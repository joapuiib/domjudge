use domjudge; 
DELETE FROM team;
DELETE FROM user WHERE teamid IS NOT NULL;
