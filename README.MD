

```bash
cat backup/11-fill_in_northwind.sql | docker exec -i postgresql-postgres-1 psql -U app -d app
```