#!/bin/bash

# Install dependencies
sudo apt install python3-dev python3-venv build-essential gcc libsasl2-dev libldap2-dev libssl-dev libpq-dev

# Clone the odoo source code
git clone https://github.com/odoo/odoo.git

# Create a virtual environment
python3 -m venv odoo_venv
source odoo_venv/bin/activate
pip install -r odoo/requirements.txt