sudo service postgresql restart
echo "List of databases owned by odoo: "
sudo -u postgres psql -t -c "SELECT datname FROM pg_database WHERE datdba = (SELECT oid FROM pg_roles WHERE rolname='odoo');"
echo "Enter database name to drop: "
read DB_NAME
sudo -u postgres psql -c "DROP DATABASE \"$DB_NAME\";"
