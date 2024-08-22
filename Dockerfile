FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish --no-restore -o /app


FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
EXPOSE 80
WORKDIR /app
COPY --from=build /app .
USER $APP_UID
ENTRYPOINT ["dotnet", "azure-sql-db-sync-ct-api.dll"]
