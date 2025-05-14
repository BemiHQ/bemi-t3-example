# Bemi T3 Stack Example

You can find a demo and detailed documentation here https://docs.bemi.io.

## System Dependencies

* Devbox
  * PostgreSQL
  * Bun

## Installation

```
make init
make pg-up
make create
cp .env.example .env
```

## Development

```
make install
make migrate
make up
```
