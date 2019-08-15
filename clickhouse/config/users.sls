{% from "clickhouse/maps/map.jinja" import clickhouse_server, clickhouse_users with context %}

config_dirs_users:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - names:
      - {{ clickhouse_server.config_dir }}/users.d

{%- for user_name, user in clickhouse_users.iteritems() %}

{{ clickhouse_server.config_dir }}/users.d/{{ user_name }}.xml:
  file.managed:
    - source: salt://clickhouse/templates/username.xml.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
      clickhouse_user: {{ user }}
      user_name: {{ user_name }}
{%- endfor %}
