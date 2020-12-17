# DOMJudge
Setup tutorial for [DOMjudge](https://www.domjudge.org/) using docker containers installed on a VM, 
using docker images provided by [domjudge/domerver](https://hub.docker.com/r/domjudge/domserver/)

## Basic configuration
On my configuration, I'm using a Ubuntu Server 20.04 for both JudgeServer and JudgeHosts machines.

Requisites:
* Install [Docker](https://docs.docker.com/engine/install/ubuntu/)
* Install [docker-compose](https://github.com/joapuiib/domjudge/blob/master/install_docker-compose.sh): `install_docker-compose.sh`

On our infrastructure, we were using IP addresses in 172.X.X.X range. Since docker uses this addresses for internal use, 
we had to configure docker not to use them. 

That can be done by placing `daemon.json` in `/etc/docker/daemon.json`

## JudgeServer
The file `jutgeserver/docker-compose.yml` contains the database (MariaDB image) and the web server container configurations.

They can be launched by the `docker-compose up` command inside of `jutgeserver` directory, BUT I highly recommend start them separately, since
the WebServer container won't wait for the DB to be ready and that will cause the server to restart indefinitely until the DB is ready.

__TODO__: Create bash script entrypoint for the WebServer that checks if the DB is ready before launching.

For the first time, I recommend:
* Check `jutgeserver.env` file to adapt it to your needs.
* Launch the DB container and check everything creates properly.

`docker-compose up db`

* Stop it with <kbd>Ctrl</kbd> + <kbd>C</kbd> and relaunch it on the background.

`docker start jutgeserver_db_1`

* Launch the WebServer container and check everything creates properly.
  * It should connect properly to the DB and start creating all the tables.

`docker-compose up server`

* Wait for it to finish, stop it with <kbd>Ctrl</kbd> + <kbd>C</kbd> and relaunch it on the background.

`docker start jutgeserver_server_1`

Mind that the last command will print the default passwords for the `admin` and `judgehost` users.  
If you want to use a different password, you can log into the web as `admin` or edit the DB.

I modified them from the DB with the `change_passwd.sh` script (I used [https://argon2.online/](https://argon2.online/) to generate the encrypted passwords)

Now, you should be able to connect to the server at `localhost:80`.

## JudgeHost

## rsync
Copiar la MV a la màquina
```bash
curl -s https://raw.githubusercontent.com/joapuiib/domjudge/master/rsync_mv.sh | bash -s - -h <IP>
```
