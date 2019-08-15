include:
  - clickhouse.removed

remove_dirs:
  file.absent:
    - names:
      - /etc/clickhouse-server
      - /etc/clickhouse-client
