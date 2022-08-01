{% from "clickhouse/maps/map.jinja" import clickhouse_packages with context %}

clickhouse_service_removed:
  service.dead:
    - name: clickhouse-server
    - enable: False

clickhouse_server_removed:
  pkg.purged:
    - pkgs:
      - {{ clickhouse_packages.server }}
      - {{ clickhouse_packages.client }}
      {% for pkg in clickhouse_packages.additional_packages %}
      - {{ pkg }}
      {% endfor %}

