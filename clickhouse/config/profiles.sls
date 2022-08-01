{% from "clickhouse/maps/map.jinja" import clickhouse_server with context %}

config_dirs_profiles:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - names:
      - {{ clickhouse_server.config_dir }}/users.d

{{ clickhouse_server.config_dir }}/users.d/profiles_salt_managed.yaml:
  file.serialize:
    - serializer: yaml
    - makedirs: True
    - dataset:
        profiles: {{ clickhouse_server.profiles }}
    - user: root
    - group: root
    - mode: '0644'
