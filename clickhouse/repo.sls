{%- from "clickhouse/maps/map.jinja" import clickhouse_repo with context %}

clickhouse_repo:
  pkgrepo.managed:
    {%- for key,value in clickhouse_repo.items() %}
    - {{ key }}: {{ value }}
    {%- endfor %}

