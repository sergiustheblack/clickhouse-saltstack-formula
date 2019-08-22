{%- if grains['os_family'] in ['Debian','RedHat'] %}
include:
  - clickhouse.installed
{%- if salt.pillar.get('clickhouse:server:config') %}
  - clickhouse.config.server
{%- endif %}
{%- if salt.pillar.get('clickhouse:server:users') %}
  - clickhouse.config.users
{%- endif %}
{%- else %}
{{ raise("OS family " ~ grains['os_family'] ~ " is not supported.") }}
{%- endif %}
