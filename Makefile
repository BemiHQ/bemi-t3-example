install:
  devbox run "bun install"

migrate:
	devbox run --env-file ./.env "bun run db:push"

up:
	devbox run --env-file ./.env "bun run dev"
