#!/bin/bash
set -e

clickhouse client -n <<-EOSQL
    CREATE DATABASE IF NOT EXISTS otel;

    -- Default Histogram metrics table DDL

    CREATE TABLE IF NOT EXISTS otel_metrics_histogram (
        ResourceAttributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        ResourceSchemaUrl String CODEC(ZSTD(1)),
        ScopeName String CODEC(ZSTD(1)),
        ScopeVersion String CODEC(ZSTD(1)),
        ScopeAttributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        ScopeDroppedAttrCount UInt32 CODEC(ZSTD(1)),
        ScopeSchemaUrl String CODEC(ZSTD(1)),
        ServiceName LowCardinality(String) CODEC(ZSTD(1)),
        MetricName String CODEC(ZSTD(1)),
        MetricDescription String CODEC(ZSTD(1)),
        MetricUnit String CODEC(ZSTD(1)),
        Attributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        StartTimeUnix DateTime64(9) CODEC(Delta, ZSTD(1)),
        TimeUnix DateTime64(9) CODEC(Delta, ZSTD(1)),
        Count UInt64 CODEC(Delta, ZSTD(1)),
        Sum Float64 CODEC(ZSTD(1)),
        BucketCounts Array(UInt64) CODEC(ZSTD(1)),
        ExplicitBounds Array(Float64) CODEC(ZSTD(1)),
        Exemplars Nested (
            FilteredAttributes Map(LowCardinality(String), String),
            TimeUnix DateTime64(9),
            Value Float64,
            SpanId String,
            TraceId String
        ) CODEC(ZSTD(1)),
        Flags UInt32 CODEC(ZSTD(1)),
        Min Float64 CODEC(ZSTD(1)),
        Max Float64 CODEC(ZSTD(1)),
        AggregationTemporality Int32 CODEC(ZSTD(1)),
        INDEX idx_res_attr_key mapKeys(ResourceAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_res_attr_value mapValues(ResourceAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_scope_attr_key mapKeys(ScopeAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_scope_attr_value mapValues(ScopeAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_attr_key mapKeys(Attributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_attr_value mapValues(Attributes) TYPE bloom_filter(0.01) GRANULARITY 1
    ) ENGINE = MergeTree()
    TTL toDateTime("TimeUnix") + toIntervalDay(180)
    PARTITION BY toDate(TimeUnix)
    ORDER BY (ServiceName, MetricName, Attributes, toUnixTimestamp64Nano(TimeUnix))
    SETTINGS index_granularity=8192, ttl_only_drop_parts = 1;

    -- Default Logs table DDL

    CREATE TABLE IF NOT EXISTS otel_logs (
        Timestamp DateTime64(9) CODEC(Delta(8), ZSTD(1)),
        TimestampDate Date DEFAULT toDate(Timestamp),
        TimestampTime DateTime DEFAULT toDateTime(Timestamp),
        TraceId String CODEC(ZSTD(1)),
        SpanId String CODEC(ZSTD(1)),
        TraceFlags UInt8,
        SeverityText LowCardinality(String) CODEC(ZSTD(1)),
        SeverityNumber UInt8,
        ServiceName LowCardinality(String) CODEC(ZSTD(1)),
        Body String CODEC(ZSTD(1)),
        ResourceSchemaUrl LowCardinality(String) CODEC(ZSTD(1)),
        ResourceAttributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        ScopeSchemaUrl LowCardinality(String) CODEC(ZSTD(1)),
        ScopeName String CODEC(ZSTD(1)),
        ScopeVersion LowCardinality(String) CODEC(ZSTD(1)),
        ScopeAttributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        LogAttributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),

        INDEX idx_trace_id TraceId TYPE bloom_filter(0.001) GRANULARITY 1,
        INDEX idx_res_attr_key mapKeys(ResourceAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_res_attr_value mapValues(ResourceAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_scope_attr_key mapKeys(ScopeAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_scope_attr_value mapValues(ScopeAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_log_attr_key mapKeys(LogAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_log_attr_value mapValues(LogAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_body Body TYPE tokenbf_v1(32768, 3, 0) GRANULARITY 1
    ) ENGINE = MergeTree()
    PARTITION BY toYYYYMM(TimestampDate)
    ORDER BY (ServiceName, TimestampDate, TimestampTime)
    TTL TimestampTime + toIntervalDay(180)
    SETTINGS index_granularity = 8192, ttl_only_drop_parts = 1;

    -- Default Sum metrics table DDL

    CREATE TABLE IF NOT EXISTS otel_metrics_sum (
        ResourceAttributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        ResourceSchemaUrl String CODEC(ZSTD(1)),
        ScopeName String CODEC(ZSTD(1)),
        ScopeVersion String CODEC(ZSTD(1)),
        ScopeAttributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        ScopeDroppedAttrCount UInt32 CODEC(ZSTD(1)),
        ScopeSchemaUrl String CODEC(ZSTD(1)),
        ServiceName LowCardinality(String) CODEC(ZSTD(1)),
        MetricName String CODEC(ZSTD(1)),
        MetricDescription String CODEC(ZSTD(1)),
        MetricUnit String CODEC(ZSTD(1)),
        Attributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        StartTimeUnix DateTime64(9) CODEC(Delta, ZSTD(1)),
        TimeUnix DateTime64(9) CODEC(Delta, ZSTD(1)),
        Value Float64 CODEC(ZSTD(1)),
        Flags UInt32  CODEC(ZSTD(1)),
        Exemplars Nested (
            FilteredAttributes Map(LowCardinality(String), String),
            TimeUnix DateTime64(9),
            Value Float64,
            SpanId String,
            TraceId String
        ) CODEC(ZSTD(1)),
        AggregationTemporality Int32 CODEC(ZSTD(1)),
        IsMonotonic Boolean CODEC(Delta, ZSTD(1)),
        INDEX idx_res_attr_key mapKeys(ResourceAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_res_attr_value mapValues(ResourceAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_scope_attr_key mapKeys(ScopeAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_scope_attr_value mapValues(ScopeAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_attr_key mapKeys(Attributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_attr_value mapValues(Attributes) TYPE bloom_filter(0.01) GRANULARITY 1
    ) ENGINE = MergeTree()
    TTL toDateTime("TimeUnix") + toIntervalDay(180)
    PARTITION BY toDate(TimeUnix)
    ORDER BY (ServiceName, MetricName, Attributes, toUnixTimestamp64Nano(TimeUnix))
    SETTINGS index_granularity=8192, ttl_only_drop_parts = 1;

    -- Default Summary metrics DDL

    CREATE TABLE IF NOT EXISTS otel_metrics_summary (
        ResourceAttributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        ResourceSchemaUrl String CODEC(ZSTD(1)),
        ScopeName String CODEC(ZSTD(1)),
        ScopeVersion String CODEC(ZSTD(1)),
        ScopeAttributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        ScopeDroppedAttrCount UInt32 CODEC(ZSTD(1)),
        ScopeSchemaUrl String CODEC(ZSTD(1)),
        ServiceName LowCardinality(String) CODEC(ZSTD(1)),
        MetricName String CODEC(ZSTD(1)),
        MetricDescription String CODEC(ZSTD(1)),
        MetricUnit String CODEC(ZSTD(1)),
        Attributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        StartTimeUnix DateTime64(9) CODEC(Delta, ZSTD(1)),
        TimeUnix DateTime64(9) CODEC(Delta, ZSTD(1)),
        Count UInt64 CODEC(Delta, ZSTD(1)),
        Sum Float64 CODEC(ZSTD(1)),
        ValueAtQuantiles Nested(
            Quantile Float64,
            Value Float64
        ) CODEC(ZSTD(1)),
        Flags UInt32  CODEC(ZSTD(1)),
        INDEX idx_res_attr_key mapKeys(ResourceAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_res_attr_value mapValues(ResourceAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_scope_attr_key mapKeys(ScopeAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_scope_attr_value mapValues(ScopeAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_attr_key mapKeys(Attributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_attr_value mapValues(Attributes) TYPE bloom_filter(0.01) GRANULARITY 1
    ) ENGINE = MergeTree()
    TTL toDateTime("TimeUnix") + toIntervalDay(180)
    PARTITION BY toDate(TimeUnix)
    ORDER BY (ServiceName, MetricName, Attributes, toUnixTimestamp64Nano(TimeUnix))
    SETTINGS index_granularity=8192, ttl_only_drop_parts = 1;

    -- Default Trace table DDL

    CREATE TABLE IF NOT EXISTS otel_traces (
        Timestamp DateTime64(9) CODEC(Delta, ZSTD(1)),
        TraceId String CODEC(ZSTD(1)),
        SpanId String CODEC(ZSTD(1)),
        ParentSpanId String CODEC(ZSTD(1)),
        TraceState String CODEC(ZSTD(1)),
        SpanName LowCardinality(String) CODEC(ZSTD(1)),
        SpanKind LowCardinality(String) CODEC(ZSTD(1)),
        ServiceName LowCardinality(String) CODEC(ZSTD(1)),
        ResourceAttributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        ScopeName String CODEC(ZSTD(1)),
        ScopeVersion String CODEC(ZSTD(1)),
        SpanAttributes Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        Duration Int64 CODEC(ZSTD(1)),
        StatusCode LowCardinality(String) CODEC(ZSTD(1)),
        StatusMessage String CODEC(ZSTD(1)),
        Events Nested (
            Timestamp DateTime64(9),
            Name LowCardinality(String),
            Attributes Map(LowCardinality(String), String)
        ) CODEC(ZSTD(1)),
        Links Nested (
            TraceId String,
            SpanId String,
            TraceState String,
            Attributes Map(LowCardinality(String), String)
        ) CODEC(ZSTD(1)),
        INDEX idx_trace_id TraceId TYPE bloom_filter(0.001) GRANULARITY 1,
        INDEX idx_res_attr_key mapKeys(ResourceAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_res_attr_value mapValues(ResourceAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_span_attr_key mapKeys(SpanAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_span_attr_value mapValues(SpanAttributes) TYPE bloom_filter(0.01) GRANULARITY 1,
        INDEX idx_duration Duration TYPE minmax GRANULARITY 1
    ) ENGINE = MergeTree()
    TTL toDateTime("Timestamp") + toIntervalDay(180)
    PARTITION BY toDate(Timestamp)
    ORDER BY (ServiceName, SpanName, toUnixTimestamp(Timestamp), TraceId)
    SETTINGS index_granularity=8192, ttl_only_drop_parts = 1;

EOSQL
