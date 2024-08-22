ARG MSSQL_VERSION=2022-CU12-ubuntu-22.04

FROM mcr.microsoft.com/mssql/server:$MSSQL_VERSION
ENV PATH="/opt/mssql-tools/bin:${PATH}"
ENV ACCEPT_EULA=Y

COPY --chown=10001 . /

RUN ["chmod", "+x", "/db-init.sh"]
RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["./entrypoint.sh"]
