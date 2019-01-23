## Custom database example

This example shows how to configure an Ensembl instance to use genomic and sessions databases on your own MySQL server.

The demo instance is configured to show a single species; *Homo sapiens*. By default the demo uses the pulic Ensembl MySQL server as the source for this data.   

To run the demo:
1. Prepare your own *Homo sapiens* database(s) (optional)
2. Create your own sessions database (the schema is here https://github.com/Ensembl/ensembl-webcode/blob/release/94/sql/ensembl_accounts.sql)
3. Configure your databases in the `DEFAULTS.ini` and `MULTI.ini` files under `custom-plugin/conf/`.
4. Run `docker-compose up`
5. Browse http://localhost:8000