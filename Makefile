postgres:
	docker run -p 5432:5432 --name postgres-16 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=secret -d postgres:16-alpine
createdb:
	docker exec -it postgres-16 createdb --username=postgres --owner=postgres simple_bank
dropdb:
	docker exec -it postgres-16 dropdb simple_bank -U postgres
migrateup:
	migrate -path db/migration/ -database "postgresql://postgres:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration/ -database "postgresql://postgres:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
.PHONY: postgres createdb dropdb migrateup migratedown sqlc
