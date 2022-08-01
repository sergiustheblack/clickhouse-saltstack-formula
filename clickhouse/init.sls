{%- if grains['os_family'] in ['Debian','RedHat'] %}
include:
  - clickhouse.installed
{%- if salt.pillar.get('clickhouse:server:config') %}
  - clickhouse.config.server
{%- endif %}
{%- if salt.pillar.get('clickhouse:server:users') %}
  - clickhouse.config.users
{%- endif %}
{%- if salt.pillar.get('clickhouse:server:quotas') %}
  - clickhouse.config.quotas
{%- endif %}
{%- if salt.pillar.get('clickhouse:server:profiles') %}
  - clickhouse.config.profiles
{%- endif %}
  - clickhouse.config.client
{%- else %}
{{ raise("OS family " ~ grains['os_family'] ~ " is not supported.") }}
{%- endif %}
