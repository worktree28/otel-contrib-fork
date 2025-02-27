module github.com/open-telemetry/opentelemetry-collector-contrib/exporter/elasticsearchexporter

go 1.21.0

require (
	github.com/cenkalti/backoff/v4 v4.3.0
	github.com/elastic/go-docappender/v2 v2.2.0
	github.com/elastic/go-elasticsearch/v7 v7.17.10
	github.com/elastic/go-structform v0.0.10
	github.com/lestrrat-go/strftime v1.0.6
	github.com/open-telemetry/opentelemetry-collector-contrib/internal/common v0.105.0
	github.com/open-telemetry/opentelemetry-collector-contrib/internal/coreinternal v0.105.0
	github.com/stretchr/testify v1.9.0
	github.com/tidwall/gjson v1.17.1
	go.opentelemetry.io/collector/component v0.105.1-0.20240729082905-fb5b1e6aa550
	go.opentelemetry.io/collector/config/configauth v0.105.1-0.20240729082905-fb5b1e6aa550
	go.opentelemetry.io/collector/config/configcompression v1.12.1-0.20240729082905-fb5b1e6aa550
	go.opentelemetry.io/collector/config/confighttp v0.105.1-0.20240729082905-fb5b1e6aa550
	go.opentelemetry.io/collector/config/configopaque v1.12.1-0.20240729082905-fb5b1e6aa550
	go.opentelemetry.io/collector/confmap v0.105.1-0.20240729082905-fb5b1e6aa550
	go.opentelemetry.io/collector/consumer v0.105.1-0.20240729082905-fb5b1e6aa550
	go.opentelemetry.io/collector/exporter v0.105.1-0.20240729082905-fb5b1e6aa550
	go.opentelemetry.io/collector/extension/auth v0.105.1-0.20240729082905-fb5b1e6aa550
	go.opentelemetry.io/collector/pdata v1.12.1-0.20240729082905-fb5b1e6aa550
	go.opentelemetry.io/collector/semconv v0.105.1-0.20240729082905-fb5b1e6aa550
	go.opentelemetry.io/otel/metric v1.28.0
	go.opentelemetry.io/otel/trace v1.28.0
	go.uber.org/goleak v1.3.0
	go.uber.org/zap v1.27.0
)

require (
	github.com/armon/go-radix v1.0.0 // indirect
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/cespare/xxhash/v2 v2.3.0 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/elastic/elastic-transport-go/v8 v8.6.0 // indirect
	github.com/elastic/go-elasticsearch/v8 v8.14.0 // indirect
	github.com/elastic/go-sysinfo v1.7.1 // indirect
	github.com/elastic/go-windows v1.0.1 // indirect
	github.com/felixge/httpsnoop v1.0.4 // indirect
	github.com/fsnotify/fsnotify v1.7.0 // indirect
	github.com/go-logr/logr v1.4.2 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/go-viper/mapstructure/v2 v2.0.0 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/snappy v0.0.4 // indirect
	github.com/google/uuid v1.6.0 // indirect
	github.com/hashicorp/go-version v1.7.0 // indirect
	github.com/joeshaw/multierror v0.0.0-20140124173710-69b34d4ec901 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/klauspost/compress v1.17.9 // indirect
	github.com/knadh/koanf/maps v0.1.1 // indirect
	github.com/knadh/koanf/providers/confmap v0.1.0 // indirect
	github.com/knadh/koanf/v2 v2.1.1 // indirect
	github.com/mitchellh/copystructure v1.2.0 // indirect
	github.com/mitchellh/reflectwalk v1.0.2 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/prometheus/client_golang v1.19.1 // indirect
	github.com/prometheus/client_model v0.6.1 // indirect
	github.com/prometheus/common v0.55.0 // indirect
	github.com/prometheus/procfs v0.15.1 // indirect
	github.com/rs/cors v1.11.0 // indirect
	github.com/tidwall/match v1.1.1 // indirect
	github.com/tidwall/pretty v1.2.0 // indirect
	go.elastic.co/apm/module/apmzap/v2 v2.6.0 // indirect
	go.elastic.co/apm/v2 v2.6.0 // indirect
	go.elastic.co/fastjson v1.3.0 // indirect
	go.opentelemetry.io/collector v0.105.1-0.20240729082905-fb5b1e6aa550 // indirect
	go.opentelemetry.io/collector/client v0.0.0-20240726220702-a6287aca1a43 // indirect
	go.opentelemetry.io/collector/config/configretry v1.12.1-0.20240729082905-fb5b1e6aa550 // indirect
	go.opentelemetry.io/collector/config/configtelemetry v0.105.1-0.20240729082905-fb5b1e6aa550 // indirect
	go.opentelemetry.io/collector/config/configtls v1.12.1-0.20240729082905-fb5b1e6aa550 // indirect
	go.opentelemetry.io/collector/config/internal v0.105.1-0.20240729082905-fb5b1e6aa550 // indirect
	go.opentelemetry.io/collector/consumer/consumerprofiles v0.105.0 // indirect
	go.opentelemetry.io/collector/consumer/consumertest v0.0.0-20240726175034-c3a11297650a // indirect
	go.opentelemetry.io/collector/extension v0.105.1-0.20240729082905-fb5b1e6aa550 // indirect
	go.opentelemetry.io/collector/featuregate v1.12.1-0.20240729082905-fb5b1e6aa550 // indirect
	go.opentelemetry.io/collector/internal/globalgates v0.105.1-0.20240726220702-a6287aca1a43 // indirect
	go.opentelemetry.io/collector/pdata/pprofile v0.105.1-0.20240729082905-fb5b1e6aa550 // indirect
	go.opentelemetry.io/collector/receiver v0.105.1-0.20240729082905-fb5b1e6aa550 // indirect
	go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.53.0 // indirect
	go.opentelemetry.io/otel v1.28.0 // indirect
	go.opentelemetry.io/otel/exporters/prometheus v0.50.0 // indirect
	go.opentelemetry.io/otel/sdk v1.28.0 // indirect
	go.opentelemetry.io/otel/sdk/metric v1.28.0 // indirect
	go.uber.org/multierr v1.11.0 // indirect
	golang.org/x/net v0.27.0 // indirect
	golang.org/x/sync v0.7.0 // indirect
	golang.org/x/sys v0.22.0 // indirect
	golang.org/x/text v0.16.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20240701130421-f6361c86f094 // indirect
	google.golang.org/grpc v1.65.0 // indirect
	google.golang.org/protobuf v1.34.2 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
	howett.net/plist v1.0.0 // indirect
)

replace github.com/open-telemetry/opentelemetry-collector-contrib/internal/common => ../../internal/common

replace github.com/open-telemetry/opentelemetry-collector-contrib/internal/coreinternal => ../../internal/coreinternal

retract (
	v0.76.2
	v0.76.1
	v0.65.0
)

replace github.com/open-telemetry/opentelemetry-collector-contrib/pkg/pdatautil => ../../pkg/pdatautil

replace github.com/open-telemetry/opentelemetry-collector-contrib/pkg/pdatatest => ../../pkg/pdatatest

replace github.com/open-telemetry/opentelemetry-collector-contrib/pkg/golden => ../../pkg/golden
