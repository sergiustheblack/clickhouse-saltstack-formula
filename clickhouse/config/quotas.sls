{% from "clickhouse/maps/map.jinja" import clickhouse_server with context %}

config_dirs_quotas:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - names:
      - {{ clickhouse_server.config_dir }}/users.d

{{ clickhouse_server.config_dir }}/users.d/quotas_salt_managed.xml:
  file.managed:
    - source: salt://clickhouse/templates/quotas.xml.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        config: {{ clickhouse_server.quotas }}
{%- if clickhouse_server.restart_on_config_change %}
    - listen_in:
      - service: clickhouse_service
{%- endif %}
