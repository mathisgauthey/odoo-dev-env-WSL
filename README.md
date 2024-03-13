# About This Repository

File structure :

```txt
.
└── odoo-dev/
    ├── .vscode/
    ├── odoo/
    ├── odoo_venv/
    ├── setup.sh
    ├── README.md
    └── LICENSE
```

## How to setup a odoo dev env

### Install WSL

1. Install WSL using `CMD` : `wsl --install` will install the Ubuntu LTS version.
2. `sudo apt update && sudo apt upgrade`.

### Setup a database using PostgreSQL

1. Install PostgreSQL in WSL using `sudo apt install postgresql`.
2. Login to user postgres : `sudo -u postgres psql postgres`.
3. Create a user using the following command : `CREATE USER odoo WITH PASSWORD odoo`
4. Add a line to `pg_hba.conf` file to allow connections for the odoo user :

```conf
TYPE DATABASE USER ADRESS METHOD
local all odoo scram-sha-256
```

![pg_hba.conf](https://github.com/mathisgauthey/odoo-dev-env-WSL/assets/46576952/951ce90e-6306-437c-8a82-7d1168c9225a)

NOTE: You can also use a Docker container using Rancher Desktop installed on Windows for a more production-like environment and less struggle for setting up the database.

### Setup your dev environment

4. Clone this repository.
5. Go inside the repo and use `bash setup.sh` to :
   1. Install the required dependencies.
   2. Clone Odoo source code.
   3. Setup a python virtual environment.
   4. Install Odoo specific dependencies inside the python venv.

You can now start the Odoo server using `./odoo/odoo-bin` and access it using `localhost:8069`.

If you're on VSCODE, simply press `CTRL+F5` to start the server, or `F5` to start the server in debug mode.

If you're using Jetbrains softwares such as PyCharm or Intellij IDEA, inspire yourself from the `.vscode/launch.json` file to setup your launch and debug configuration.
