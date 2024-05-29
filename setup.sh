#!/bin/bash

# Install Ubuntu dependencies
sudo apt install python3-dev python3-venv build-essential gcc libsasl2-dev libldap2-dev libssl-dev libpq-dev

# Create the addons directory
mkdir addons

# Clone the odoo source code
git clone https://github.com/odoo/odoo.git src/odoo --branch 17.0 --single-branch --depth 1

# Create a python virtual environment
python3 -m venv venv

# Install Odoo dependencies inside the python virtual environment
source venv/bin/activate
pip install -r src/odoo/requirements.txt