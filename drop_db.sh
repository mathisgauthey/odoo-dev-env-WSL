sudo service postgresql restart
sudo -u postgres psql postgres -c 'DROP DATABASE "odoo-db";'
