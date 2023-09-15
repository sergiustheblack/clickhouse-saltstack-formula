{%- from "clickhouse/maps/map.jinja" import clickhouse_repo with context %}

clickhouse_repo:
  pkgrepo.managed:
    {%- for key,value in clickhouse_repo.items() %}
    - {{ key }}: {{ value }}
    {%- endfor %}
{#- Debian 11+ prefers kering -#}
{%- if grains['os_family'] == 'Debian' %}
    - require:
      - clickhouse_gpgkey

{#- TODO: refactor after salt 3005 #}
clickhouse_gpgkey:
  file.managed:
  - name: /usr/share/keyrings/clickhouse-keyring.gpg
    source: salt://{{ tpldir }}/files/clickhouse-keyring.gpg
    replace: False
{%- endif %}
