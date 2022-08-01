{%- from "clickhouse/maps/map.jinja" import clickhouse_client with context %}

{%- if clickhouse_client.config is defined %}
config_dirs_client:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - names:
      - {{ clickhouse_client.config_dir }}/config.d

{{ clickhouse_client.config_dir }}/client.d/salt_managed.yaml:
  file.serialize:
    - serializer: yaml
    - makedirs: True
    - dataset: {{ clickhouse_client.config }}
    - user: root
    - group: root
    - mode: '0644'
{%- endif %}
