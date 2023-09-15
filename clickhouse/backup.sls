{%- from "clickhouse/maps/backup.jinja" import clickhouse_backup as backup with context -%}
clickhouse_backup_pkg:
  pkg.installed:
    - sources:
      - clickhouse-backup: {{ backup.url }}

clikhouse_backup_config:
  file.serialize:
    - name: {{ backup.config_path }}
    - serializer: yaml
    - makedirs: True
    - dataset: {{ backup.config }}
    - user: root
    - group: root
    - mode: '0644'
    - require:
      - pkg: clickhouse_backup_pkg
