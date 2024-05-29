# About This Repository

## Introduction

My Odoo dev env that I use in WSL. This repository is licensed under the [MIT license](https://mathisgauthey.mit-license.org/).

It is meant to allow for local dev on WSL.

File structure :

```txt
.
└── odoo-dev/
    ├── .vscode/
    ├── odoo/
    ├── odoo_venv/
    ├── LICENSE
    ├── README.md
    └── setup.sh
```

## How to setup a odoo dev environment on Windows using WSL

### Install WSL

1. Install WSL by opening a `CMD` and using the following command : `wsl --install`. This will install the Ubuntu LTS[^1] version.
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

1. Clone this repository.
2. Go inside the repo using `cd` and use `bash setup.sh` to :
   1. Install the required Ubuntu dependencies.
   2. Clone Odoo source code.
   3. Setup a python virtual environment.
   4. Install Odoo specific dependencies inside the python venv.

You can now start the Odoo server using `./odoo/odoo-bin` and access it using `localhost:8069`.

If you're on VSCODE, simply press `CTRL+F5` to start the server, or `F5` to start the server in debug mode.

If you're using Jetbrains softwares such as PyCharm or Intellij IDEA, inspire yourself from the `.vscode/launch.json` file to setup your launch and debug configuration.

### VS Code Odoo Pytest setup

Follow the WSL setup instructions to get a working Odoo dev environment first.

Then, from your virtual env (remember to use `source venv/bin/activate` to get into your venv), install [pytest 7.4.3](https://pypi.org/project/pytest/7.4.3/) and [pytest-odoo](https://github.com/camptocamp/pytest-odoo) :

```bash
pip install pytest==7.4.3
pip install pytest-odoo
pip install coverage
pip install pytest-cov
pip install pytest-html
```

Then, install Odoo as a pip package :

```bash
cd ./src/odoo
pip install -e .
```

You should now see odoo when doing a `pip list`.

You can now configure PyTest on VS Code, but it should work just fine using the `settings.json` and `config/odoo.conf` files provided in this repository.

Don't forget to create a `.env` file like that :

```env
ODOO_RC=config/odoo.conf
ADDONS_PATH=src/odoo/odoo/addons,src/odoo/addons,COMMA_SEPARATED_ADDONS_PATHS
ADDONS_LIST=COMMA_SEPARATED_ADDONS_NAMES
```

### Use and create Odoo modules

Based on [odoo docs](https://www.odoo.com/documentation/17.0/developer/tutorials/getting_started/01_architecture.html#module-structure), the following directory structure should be applied when developping odoo addons:

```txt
.
└── REPO_NAME/
    ├── .git/
    ├── MODULE_NAME/
    │   ├── data/
    │   ├── models/
    │   ├── controllers/
    │   ├── views/
    │   ├── static/
    │   ├── wizard/
    │   ├── report/
    │   ├── tests/
    │   ├── __init__.py
    │   ├── __manifest__.py
    │   └── ... # Other module files and folders (Detailled below)
    ├── .gitignore
    ├── LICENSE
    ├── README.md
    └── requirements.txt
```

Odoo.sh is handling `requirements.txt` files in [the parent folder of the module](https://www.odoo.com/documentation/17.0/administration/odoo_sh/advanced/containers.html#overview). We're not using Odoo.sh, but we could still use the same structure to keep things consistent.

If you don't use Odoo.sh, you might need to use a bash script that looks for `requirements.txt` files and install the required dependencies.

You can find informations about [coding guidelines in details here](https://www.odoo.com/documentation/17.0/contributing/development/coding_guidelines.html).

> A module is organized in important directories. Those contain the business logic; having a look at them should make you understand the purpose of the module.
>
> - data/ : demo and data xml
> - models/ : models definition
> - controllers/ : contains controllers (HTTP routes)
> - views/ : contains the views and templates
> - static/ : contains the web assets, separated into css/, js/, img/, lib/, …
>
> Other optional directories compose the module:
>
> - wizard/ : regroups the transient models (models.TransientModel) and their views
> - report/ : contains the printable reports and models based on SQL views. Python objects and XML views are included in this directory
> - tests/ : contains the Python tests

I'd recommend to add a `odoo-dev-env-WSL/odoo/dev/` folder to store your modules and use the `--addons_path` argument to add it to the Odoo server. You can inspire yourself from the `launch.json` file to do so.

## Configure Odoo

to configure Odoo, we get to choose if we prefer to use :

- [The `odoo.conf` file](https://www.odoo.com/documentation/17.0/administration/install/deploy.html)
- [The command line arguments](https://www.odoo.com/documentation/17.0/developer/reference/cli.html#cmdoption-odoo-bin-d) by replacing or adding to the default Docker `CMD` with `odoo --ARG_NAME ARG_VALUE` in the `Dockerfile` file.

A good practice is to **use only one** of the two methods to configure Odoo.

Note that some arguments are [named differently](https://www.odoo.com/documentation/17.0/developer/reference/cli.html#configuration-file) depending on the method used :

- `--db-filter` becomes `dbfilter` in `odoo.conf`
- `--database` becomes `db_name` in `odoo.conf`
- `--addons-path` becomes `addons_path` in `odoo.conf`
- `--data-dir` becomes `data_dir` in `odoo.conf`

We're using WSL here and will be using launch arguments in the `launch.json` file.

## How to debug

Press `F5` to start the server and `F5` to start it in debug mode. You can then set breakpoints and use the debug console to interact with the server.

## How to start fresh

1. Stop your server.
2. Use `bash drop_db.sh` to drop the database.
3. Relaunch the server to install and upgrade the plugins automatically.

[^1]: Long Term Support
