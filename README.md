# sectors-form-app

A full-stack web application based on a technical assignment. The goal is to replace a static HTML form with a complete full-stack solution where sector options are loaded from a database and user data can be saved and edited during the same browser session.

---

## Technology choices

| Layer         | Technology        |
|---------------|-------------------|
| Frontend      | Angular           |
| Backend       | Java Spring Boot  |
| Build tool    | Gradle            |
| Database      | PostgreSQL        |
| Dev environment | Docker Compose  |

- **Angular** is used because the assignment requires it for the frontend.
- **Spring Boot** provides a clean structure for REST APIs, input validation and database access with minimal configuration.
- **Gradle** is used as the backend build tool.
- **PostgreSQL** suits the relational data model (hierarchical sectors, user profiles, many-to-many selections) and supports a full database dump as required by the assignment.
- **Docker Compose** makes local database setup a single command, repeatable across machines.

---

## Project structure

```
sectors-form-app/
  backend/          – Spring Boot application (Gradle)
  frontend/         – Angular application
  database/         – SQL schema, seed data and full dump
  docker-compose.yml
  README.md
  .gitignore
```

---

## Prerequisites

- Java 23
- Node.js 20+ and npm
- Docker and Docker Compose

---

## Local setup

Start all three parts in separate terminals in the order below.

### 1. Database

```bash
docker compose up -d
```

PostgreSQL starts on port **5433** (port 5433 is used instead of the default 5432 to avoid conflicts with a locally installed PostgreSQL).

| Setting  | Value         |
|----------|---------------|
| Database | `sectors_app` |
| User     | `postgres`    |
| Password | `postgres`    |
| Port     | `5433`        |

To restore from the full dump instead of running schema and seed separately:

```bash
docker compose exec -T postgres psql -U postgres -d sectors_app < database/dump.sql
```

### 2. Backend

Linux / macOS:
```bash
cd backend
./gradlew bootRun
```

Windows:
```bash
cd backend
gradlew.bat bootRun
```

The API is available at `http://localhost:8080`.

On first run Gradle downloads dependencies — this takes about one minute.

### 3. Frontend

```bash
cd frontend
npm install
npm start
```

The application opens at `http://localhost:4200`.

---

## Ports

| Service  | Port | URL                       |
|----------|------|---------------------------|
| Frontend | 4200 | http://localhost:4200     |
| Backend  | 8080 | http://localhost:8080/api |
| Database | 5433 | localhost:5433            |

---

## API endpoints

### GET /api/sectors

Returns all sectors ordered by sort order.

**Response:**
```json
[
  { "id": 1, "name": "Manufacturing", "parentId": null, "level": 0, "sortOrder": 1 },
  { "id": 19, "name": "Construction materials", "parentId": 1, "level": 1, "sortOrder": 2 }
]
```

---

### POST /api/user-profile

Saves or updates a user profile. If the `sessionId` already exists in the database the profile is updated. If not, a new profile is created.

**Request body:**
```json
{
  "sessionId": "abc-123",
  "name": "Roger",
  "sectorIds": [28, 576, 121],
  "agreeToTerms": true
}
```

**Response:**
```json
{
  "sessionId": "abc-123",
  "name": "Roger",
  "sectorIds": [28, 576, 121],
  "agreeToTerms": true
}
```

**Validation errors (400):**
```json
{
  "message": "Validation failed",
  "errors": {
    "name": "Name is required",
    "sectorIds": "At least one sector must be selected",
    "agreeToTerms": "Terms must be accepted"
  }
}
```

---

### GET /api/user-profile/{sessionId}

Returns the saved profile for the given session ID.

**Response:** same structure as POST response.

Returns **404** if no profile exists for the session ID. The frontend treats 404 as an empty form (not an error).

---

## Database dump

The full database dump is located at:

```
database/dump.sql
```

The dump includes:
- Complete table structure for `sectors`, `user_profiles` and `user_profile_sectors`
- All 79 sectors with hierarchy data
- Primary keys, foreign keys and unique constraints

To import into a fresh PostgreSQL database:

```bash
docker compose exec -T postgres psql -U postgres -d sectors_app < database/dump.sql
```

---

## Session-based editing

The application does not use authentication. Instead:

1. On first visit the Angular frontend generates a UUID using `crypto.randomUUID()` and stores it in `sessionStorage` under the key `sectors-form-session-id`.
2. The same session ID is reused for every save request during the same browser session.
3. The backend uses the session ID to either create a new profile (`INSERT`) or update the existing one (`UPDATE`).
4. On page refresh the frontend reads the existing session ID from `sessionStorage` and loads the saved profile automatically.
5. Closing the browser tab clears `sessionStorage`, starting a new session on next visit.

---

## Known limitations

- No user authentication — any person with the session ID can access the profile.
- Session data is tied to the browser session (`sessionStorage`). Closing the tab ends the session.
- The application is designed for assignment scope and is not production-ready.

---

## Manual testing checklist

- [ ] Database starts successfully with `docker compose up -d`
- [ ] Backend starts successfully with `./gradlew bootRun`
- [ ] Frontend starts successfully with `npm start`
- [ ] Sectors are loaded from the database and displayed in the selectbox
- [ ] Sector hierarchy is visible (child sectors are indented)
- [ ] Name field is required — error shown when empty
- [ ] Whitespace-only name is rejected
- [ ] At least one sector must be selected — error shown otherwise
- [ ] Agree to terms must be checked — error shown otherwise
- [ ] Valid data can be saved — success message appears
- [ ] Saved data is stored in the database
- [ ] Form is refilled with backend response after saving
- [ ] Editing and saving again updates the existing record (no duplicate)
- [ ] Page refresh within the same session reloads previously saved data
- [ ] Database dump exists at `database/dump.sql`
- [ ] Dump can be imported into a fresh database
