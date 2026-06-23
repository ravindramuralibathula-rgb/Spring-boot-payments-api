# ADR 0001: Use a Modular Monolith First

## Status

Accepted

## Context

The project is intended to demonstrate production-oriented backend design without adding unnecessary operational complexity at the beginning. Starting with multiple microservices would require service discovery, networking, distributed tracing, deployment coordination and additional infrastructure before the core domain is stable.

## Decision

Start with a modular monolith organized by business capability. Keep module boundaries explicit in package structure and dependencies. Extract services later only when there is a clear reason.

## Consequences

- Local development remains simple.
- Domain boundaries are still visible.
- The project can evolve toward microservices incrementally.
- Cross-module coupling must be monitored through code reviews and package discipline.
