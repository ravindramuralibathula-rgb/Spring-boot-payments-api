# Spring Boot Payments API

Production-oriented Spring Boot payments API showcasing idempotency, provider integrations, async processing, outbox events, resilience and integration testing.

## Overview

`spring-boot-payments-api` is a backend reference implementation for payment order processing. It is designed to demonstrate how to build a clean, extensible and production-oriented Java backend using Spring Boot, PostgreSQL, Flyway, Docker, OpenAPI and automated tests.

The project starts as a modular monolith and evolves through small, well-documented increments. Each feature is intended to model a real backend engineering problem: duplicate payment requests, external provider failures, asynchronous processing, retries, auditability and API contract stability.

## Business Problem

Payment APIs must be reliable under retries, provider failures and partial system outages. A client may submit the same payment request more than once because of a network timeout, a payment provider may fail temporarily, and the application must preserve an auditable record of each state transition.

This project demonstrates a simplified payment order workflow with:

- payment order lifecycle management;
- idempotent payment creation;
- external payment provider abstraction;
- asynchronous processing using an outbox-ready design;
- consistent API errors;
- database migrations;
- automated tests and CI.

## Tech Stack

- Java 21
- Spring Boot 3
- Spring Web
- Spring Data JPA
- PostgreSQL
- Flyway
- Docker Compose
- OpenAPI / Swagger UI
- JUnit 5
- Testcontainers
- GitHub Actions

## Architecture Direction

The first version is a modular monolith organized by business capability instead of technical layers only.

Planned modules:

```text
common
payee
paymentorder
provider
outbox
audit
```

Future extensions may introduce a provider simulator service, GraphQL BFF, queue-backed processing and infrastructure-as-code examples.

## Running Locally

Start PostgreSQL:

```bash
docker compose up -d postgres
```

Run the API:

```bash
SPRING_PROFILES_ACTIVE=local mvn spring-boot:run
```

Check the service:

```bash
curl http://localhost:8080/api/v1/system/info
```

Swagger UI:

```text
http://localhost:8080/swagger-ui.html
```

## Running Tests

```bash
mvn test
```

## Roadmap

1. Bootstrap Spring Boot project
2. Add PostgreSQL and Flyway migrations
3. Implement payment order domain model
4. Expose payment order REST API
5. Add consistent API error handling
6. Add idempotency support
7. Add outbox event model
8. Add mock payment provider
9. Add retry and timeout policies
10. Add Stripe sandbox provider adapter
11. Add integration tests with Testcontainers
12. Add GraphQL BFF as an optional API layer
13. Add architecture decision records

## Design Principles

- Keep the core domain independent from external providers.
- Persist first, process later when reliability matters.
- Use idempotency for retry-safe payment creation.
- Prefer explicit state transitions over implicit status changes.
- Make failures observable, auditable and testable.
- Add architectural complexity only when a concrete problem justifies it.
