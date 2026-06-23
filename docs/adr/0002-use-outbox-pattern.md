# ADR 0002: Use an Outbox-Ready Design for Payment Processing

## Status

Proposed

## Context

Payment processing requires reliability across database updates and external provider calls. Calling an external provider directly inside the same request that creates a payment order can lead to partial failure scenarios that are hard to recover from.

## Decision

Persist the payment order and an outbox event in the same database transaction. A worker will later process pending outbox events and call the selected payment provider.

## Consequences

- Payment order creation becomes durable before external processing starts.
- Provider failures can be retried without losing the original request.
- The model can later evolve toward Kafka, SQS or CDC-based publishing.
