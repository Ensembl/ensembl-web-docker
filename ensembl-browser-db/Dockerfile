FROM mysql:5.6

ENV MYSQL_DATABASE=ensembl_session \
    MYSQL_ROOT_PASSWORD=ensrw_root

COPY ./sql-scripts/ /docker-entrypoint-initdb.d/


