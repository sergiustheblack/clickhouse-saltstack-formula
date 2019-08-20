{%- from "clickhouse/maps/map.jinja" import clickhouse_packages, clickhouse_repo with context %}

include:
  - clickhouse.repo

clickhouse_client:
  pkg.installed:
    - name: {{ clickhouse_packages.client }}
    {%- if clickhouse_packages.get('version') %}
    - version: {{ clickhouse_packages.version }}
    {%- endif %}

clickhouse_server:
  pkg.installed:
    - name: {{ clickhouse_packages.server }}
    {%- if clickhouse_packages.get('version') %}
    - version: {{ clickhouse_packages.version }}
    {%- endif %}
    - require_in:
        - service: clickhouse_service

clickhouse_service:
  service.running:
    - enable: True
    - name: clickhouse-server.service
