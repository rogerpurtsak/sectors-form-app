# sectors-form-app

A full-stack web application that lets users register their name, select the industry sectors they are involved in, and agree to terms. Submitted data is persisted to a relational database and can be reviewed and updated within the same session.

## Stack

| Layer    | Technology           |
|----------|----------------------|
| Frontend | Angular              |
| Backend  | Java Spring Boot     |
| Database | PostgreSQL           |
| Dev env  | Docker Compose       |

## Technology choices

### Angular (frontend)
Angular is required by the assignment. It provides a structured component model and built-in form handling that map naturally to the form-centric nature of this application.

### Java Spring Boot (backend)
Spring Boot was chosen because it is a technology I have worked with before, which means the REST API, JPA repository layer, and CORS configuration can be set up quickly and reliably without introducing unknown risk. Spring Boot's opinionated defaults also keep the project structure clean and easy to review.

### PostgreSQL (database)
PostgreSQL is a natural pairing with Spring Boot and has been used together with it in previous projects. It handles the hierarchical sector data cleanly with a self-referencing parent column and offers reliable constraints for the mandatory-field requirements. The same Docker Compose setup that works for Spring Boot development works equally well for running a local Postgres instance.

### Docker Compose (development environment)
Docker Compose is included to start the PostgreSQL database with a single command, eliminating manual installation steps for reviewers. It is the same toolchain already familiar from prior Spring Boot + PostgreSQL work.

### Why sectors are stored in the database
Hardcoding sectors in HTML makes the list impossible to query, validate server-side, or extend without touching markup. Storing them in a dedicated `sectors` table lets the backend return the list via a REST endpoint, ensures referential integrity when saving a user's selections, and makes future additions a data change rather than a code change.

### Session-based editing (no authentication)
The assignment requires that a user can edit their own data during the current session. This is implemented by returning the saved record's `id` to the client after the first save and reusing that id for subsequent updates. No login or authentication system is needed because the task scope is limited to a single-session self-edit workflow.

## Folder structure

```
sectors-form-app/
  frontend/   – Angular project
  backend/    – Spring Boot application (Gradle)
  database/   – SQL schema and seed data
  README.md
  .gitignore
```

## Getting started

### Database

```bash
docker compose up -d
```

This starts PostgreSQL on port **5433** (5432 is reserved to avoid conflicts with a local PostgreSQL installation).

To restore the database from the full dump:

```bash
docker compose exec -T postgres psql -U postgres -d sectors_app < database/dump.sql
```

| Setting  | Value          |
|----------|----------------|
| Database | `sectors_app`  |
| User     | `postgres`     |
| Password | `postgres`     |
| Port     | `5433`         |

### Backend

```bash
cd backend
./gradlew bootRun
```

The API will be available at `http://localhost:8080`.

### Frontend

```bash
cd frontend
npm install
ng serve
```

Open `http://localhost:4200` in your browser.

## Ports

| Service  | Port   | URL                        |
|----------|--------|----------------------------|
| Frontend | 4200   | http://localhost:4200      |
| Backend  | 8080   | http://localhost:8080/api  |
| Database | 5433   | localhost:5433             |
