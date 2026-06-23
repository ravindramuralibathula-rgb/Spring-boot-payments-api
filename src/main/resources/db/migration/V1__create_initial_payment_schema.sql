CREATE TABLE payees (
  id UUID PRIMARY KEY,
  external_reference VARCHAR(100) NOT NULL UNIQUE,
  display_name VARCHAR(200) NOT NULL,
  account_number_last4 VARCHAR(4),
  routing_number VARCHAR(20),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE payment_orders (
  id UUID PRIMARY KEY,
  payee_id UUID NOT NULL REFERENCES payees(id),
  amount NUMERIC(19, 2) NOT NULL,
  currency CHAR(3) NOT NULL,
  status VARCHAR(40) NOT NULL,
  description VARCHAR(255),
  provider VARCHAR(80),
  provider_reference VARCHAR(150),
  failure_reason VARCHAR(500),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  submitted_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  CONSTRAINT chk_payment_orders_amount_positive CHECK (amount > 0)
);

CREATE INDEX idx_payment_orders_payee_id ON payment_orders(payee_id);
CREATE INDEX idx_payment_orders_status ON payment_orders(status);
CREATE INDEX idx_payment_orders_created_at ON payment_orders(created_at);

CREATE TABLE payment_order_status_history (
  id UUID PRIMARY KEY,
  payment_order_id UUID NOT NULL REFERENCES payment_orders(id),
  previous_status VARCHAR(40),
  new_status VARCHAR(40) NOT NULL,
  reason VARCHAR(500),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_payment_status_history_payment_order_id
  ON payment_order_status_history(payment_order_id);

CREATE TABLE idempotency_records (
  id UUID PRIMARY KEY,
  idempotency_key VARCHAR(120) NOT NULL UNIQUE,
  request_hash VARCHAR(128) NOT NULL,
  resource_type VARCHAR(80) NOT NULL,
  resource_id UUID,
  response_status INTEGER,
  response_body JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  expires_at TIMESTAMPTZ NOT NULL
);

CREATE INDEX idx_idempotency_records_expires_at ON idempotency_records(expires_at);

CREATE TABLE outbox_events (
  id UUID PRIMARY KEY,
  aggregate_type VARCHAR(120) NOT NULL,
  aggregate_id UUID NOT NULL,
  event_type VARCHAR(120) NOT NULL,
  payload JSONB NOT NULL,
  status VARCHAR(40) NOT NULL,
  retry_count INTEGER NOT NULL DEFAULT 0,
  last_error VARCHAR(1000),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  published_at TIMESTAMPTZ
);

CREATE INDEX idx_outbox_events_status_created_at ON outbox_events(status, created_at);
CREATE INDEX idx_outbox_events_aggregate ON outbox_events(aggregate_type, aggregate_id);
