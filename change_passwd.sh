# docker exec -it domjudge_db_1 mysql -uroot -prootpw
docker exec -it domjudge_db_1 mysql -uroot -prootpw -e 'use domjudge; UPDATE user SET password = "$argon2id$v=19$m=65536,t=4,p=1$anV0Z2V1c2VycGFzcw$G6/rkGKFQFLo0yXZtQ0EQA" WHERE username = "admin";'
docker exec -it domjudge_db_1 mysql -uroot -prootpw -e 'use domjudge; UPDATE user SET password = "$argon2id$v=19$m=65536,t=4,p=1$anV0Z2V1c2VycGFzcw$n+vljAlLaS+X5wm+mWwn/Q" WHERE username = "judgehost";'
