{%- from "clickhouse/maps/map.jinja" import clickhouse_server with context %}

config_dirs_server:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - names:
      - {{ clickhouse_server.config_dir }}/conf.d

{%- if 'files' in clickhouse_server.config %}

{{ clickhouse_server.config_dir }}/conf.d/salt_managed.xml:
  file.absent: []

{%- for file in clickhouse_server.config.files %}
/{{ file }}:
  file.managed:
    - makedirs: True
    - contents_pillar: {{ file.split('/')|join(':')}}
    - user: root
    - group: root
    - mode: 644
{%- if clickhouse_server.restart_on_config_change %}
    - listen_in:
      - service: clickhouse_service
{%- endif %}
{%- endfor %}

{%- else %}
{{ clickhouse_server.config_dir }}/conf.d/salt_managed.xml:
  file.managed:
    - source: salt://clickhouse/templates/config.xml.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        config: {{ clickhouse_server.config }}
{%- if clickhouse_server.restart_on_config_change %}
    - listen_in:
      - service: clickhouse_service
{%- endif %}
{% endif %}
