# Architecture

## Current Style

The initial implementation uses a modular monolith. The goal is to keep deployment simple while still preserving clear boundaries between business capabilities.

## Planned Modules

| Module | Responsibility |
| --- | --- |
| `common` | Shared web, logging, validation and error handling utilities. |
| `payee` | Payee registration and lookup. |
| `paymentorder` | Payment order creation, validation and lifecycle transitions. |
| `provider` | Payment provider abstraction and concrete provider adapters. |
| `outbox` | Durable event persistence for asynchronous processing. |
| `audit` | Audit trail and status transition history. |

## Future Evolution

The project can evolve into a small distributed system by extracting provider simulation, notification or authorization into separate services. That evolution should be driven by documented trade-offs rather than premature microservice decomposition.
