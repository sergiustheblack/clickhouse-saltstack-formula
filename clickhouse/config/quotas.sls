{% from "clickhouse/maps/map.jinja" import clickhouse_server with context %}

config_dirs_quotas:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - names:
      - {{ clickhouse_server.config_dir }}/users.d

{{ clickhouse_server.config_dir }}/users.d/quotas_salt_managed.yaml:
  file.serialize:
    - serializer: yaml
    - makedirs: True
    - dataset:
        quotas: {{ clickhouse_server.quotas }}
    - user: root
    - group: root
    - mode: '0644'
