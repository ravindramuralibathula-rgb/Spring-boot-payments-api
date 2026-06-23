# Roadmap

## Milestone 1 - Backend Foundation

- Spring Boot application bootstrap
- Docker Compose PostgreSQL
- Flyway initial schema
- Health/info endpoint
- CI workflow

## Milestone 2 - Payment Domain

- Payee aggregate
- Payment order aggregate
- Payment status lifecycle
- REST API
- Validation
- Consistent error responses

## Milestone 3 - Reliability Patterns

- Idempotency key support
- Outbox event persistence
- Worker for pending events
- Retry count and failure reason

## Milestone 4 - Provider Integrations

- Provider adapter abstraction
- Mock provider
- Stripe sandbox provider
- Timeout and retry policies

## Milestone 5 - API Evolution

- OpenAPI documentation
- GraphQL BFF layer
- Feature flag based provider switching

## Milestone 6 - Operations

- Structured logs
- Correlation ID
- Metrics
- Testcontainers
- Terraform / LocalStack exploration
