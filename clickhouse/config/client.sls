{%- from "clickhouse/maps/map.jinja" import clickhouse_client with context %}

config_dirs_client:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - names:
      - {{ clickhouse_client.config_dir }}/conf.d

{%- if 'files' in clickhouse_client.config %}

{{ clickhouse_client.config_dir }}/conf.d/salt_managed.xml:
  file.absent: []

{%- for file in clickhouse_client.config.files %}
/{{ file }}:
  file.managed:
    - makedirs: True
    - contents_pillar: {{ file.split('/')|join(':')}}
    - user: root
    - group: root
    - mode: 644
{%- endfor %}

{%- else %}
{{ clickhouse_client.config_dir }}/conf.d/salt_managed.xml:
  file.managed:
    - source: salt://clickhouse/templates/client.xml.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        config: {{ clickhouse_client.config }}
{% endif %}
