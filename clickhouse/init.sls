include:
  - clickhouse.installed
{%- if salt.pillar.get('clickhouse:server:config') %}
  - clickhouse.config.server
{%- endif %}
{%- if salt.pillar.get('clickhouse:server:users') %}
  - clickhouse.config.users
{%- endif %}
