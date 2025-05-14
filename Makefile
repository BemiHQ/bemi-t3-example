sh:
	devbox --env-file .env shell

install:
	rm -rf ./node_modules/@bemi-db && \
	devbox run --env-file ./.env "bun install && bun prisma generate" && \
	cd ../bemi-prisma && pnpm install && pnpm build && cd - && \
	cp -r ../bemi-prisma/dist/* ./node_modules/@bemi-db/prisma/dist && cp ../bemi-prisma/package.json ./node_modules/@bemi-db/prisma/package.json

migrate:
	devbox run --env-file .env "bun run db:generate"

reset:
	devbox run --env-file .env "bunx prisma migrate reset"

up:
	devbox run --env-file .env "bun run dev"

init:
	devbox install && \
	devbox run initdb && \
		sed -i "s/#port = 5432/port = 5434/g" ./.devbox/virtenv/postgresql/data/postgresql.conf && \
		sed -i "s/#log_statement = 'none'/log_statement = 'all'/g" ./.devbox/virtenv/postgresql/data/postgresql.conf && \
		sed -i "s/#logging_collector = off/logging_collector = on/g" ./.devbox/virtenv/postgresql/data/postgresql.conf && \
		sed -i "s/#log_directory = 'log'/log_directory = 'log'/g" ./.devbox/virtenv/postgresql/data/postgresql.conf

create:
	devbox run "createdb -p 5434 bemi_dev_source && \
		createuser -p 5434 --superuser --replication postgres && \
		psql -p 5434 -U postgres -c \"ALTER SYSTEM SET wal_level = logical;\"" && \
		make pg-down pg-up

delete:
	devbox run "dropdb -p 5434 bemi_dev_source && dropuser -p 5434 postgres"

pg-up:
	devbox services start postgresql-source

pg-down:
	devbox services stop

pg-logs:
	tail -f .devbox/virtenv/postgresql/data/log/postgresql-*.log

psql:
	devbox run psql bemi_dev_source -p 5434
