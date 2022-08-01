{% from "clickhouse/maps/map.jinja" import clickhouse_server, clickhouse_users with context %}

config_dirs_users:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - names:
      - {{ clickhouse_server.config_dir }}/users.d

{%- for user_name, user in clickhouse_users.items() %}

{{ clickhouse_server.config_dir }}/users.d/{{ user_name }}.yaml:
  file.serialize:
    - serializer: yaml
    - makedirs: True
    - dataset:
        users:
          {{ user_name }}: {{ user }}
    - user: root
    - group: root
    - mode: '0644'
    {%- if clickhouse_server.restart_on_config_change %}
    - listen_in:
      - service: clickhouse_service
    {%- endif %}
{%- endfor %}
