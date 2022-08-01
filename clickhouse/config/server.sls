{%- from "clickhouse/maps/map.jinja" import clickhouse_server with context %}

config_dirs_server:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - names:
      - {{ clickhouse_server.config_dir }}/config.d

{%- if 'config_files' in clickhouse_server.config %}

{{ clickhouse_server.config_dir }}/config.d/salt_managed.yaml:
  file.absent: []

{%- for file in clickhouse_server.config.config_files %}
/{{ file }}:
  file.managed:
    - makedirs: True
    - contents_pillar: {{ file.split('/')|join(':') }}
    - user: root
    - group: root
    - mode: '0644'
    {%- if clickhouse_server.restart_on_config_change %}
    - listen_in:
      - service: clickhouse_service
    {%- endif %}
{%- endfor %}

{%- else %}
{{ clickhouse_server.config_dir }}/config.d/salt_managed.yaml:
  file.serialize:
    - serializer: yaml
    - makedirs: True
    - dataset: {{ clickhouse_server.config }}
    - user: root
    - group: root
    - mode: '0644'
    {%- if clickhouse_server.restart_on_config_change %}
    - listen_in:
      - service: clickhouse_service
    {%- endif %}
{% endif %}
