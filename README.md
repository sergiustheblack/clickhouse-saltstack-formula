# clickhouse-saltstack-formula
saltstack formula for installation and configuration of Yandex Clickhouse

## 'clickhouse:config:files' usage
You will have to configure filetree on salt-master for use with files directive in pillar.

## rpm repo notes
Official Yandex rpm repo currently (on 20.08.2019) contains only one signed version of Clickhouse - 19.13.2.19-2.
If you need to install older version, you can set up non-official [altinity](https://github.com/Altinity/clickhouse-rpm-install) repo. Example can be found in [pillar.example](pillar.example)

## Usage
Add required formulas to your pillar
```
formulas:
  - clickhouse			# install and configure
  - clickhouse.installed	# install only
  - clickhouse.config.server
  - clickhouse.config.users
  - clickhouse.removed		# remove packages
  - clickhouse.purged		# remove packages and config files
```
<details>
  <summary>Real world example</summary>

```
formulas:
  - clickhouse
clickhouse:
  server:
    config:
      logger: 
        level: information
      http_port:
        xmlattributes:
          remove: remove
      tcp_port:
        xmlattributes:
          remove: remove
      interserver_http_port:
        xmlattributes:
          remove: remove
      tcp_port_secure:
        xmlattributes:
          replace: replace
        value:  9440
      https_port:
        xmlattributes:
          replace: replace
        value: 8443
      interserver_https_port: 9019
      openSSL:
        server:
          certificateFile: '/etc/pki/example.com/wild.example.com.cer'
          privateKeyFile: '/etc/pki/example.com/wild.example.com.key'
          dhParamsFile: '/etc/clickhouse-server/dhparams.pem'
          verificationMode: relaxed
          caConfig: '/etc/pki/tls/cert.pem'
          loadDefaultCAFile: true
          cacheSessions: true
          disableProtocols: 'sslv2,sslv3'
          preferServerCiphers: true
        client:
          preferServerCiphers: true
          invalidCertificateHandler:
            name: RejectCertificateHandler
          caConfig: '/etc/pki/tls/cert.pem'
      listen_host: 0.0.0.0
      compression:
        xmlattributes:
          remove: remove 
      remote_servers:
        xmlattributes:
          incl: clickhouse_remote_servers
          optional: true
        clickhouse_cluster01:
          shard:
            - internal_replication: true
              replica:
                - host: ch-replica01.example.com
                  port: 9440
                  secure: true
                - host: ch-replica02.example.com
                  port: 9440
                  secure: true
                - host: ch-replica03.example.com
                  port: 9440
                  secure: true
            - internal_replication: true
              replica:
                - host: ch-replica04.example.com
                  port: 9440
                  secure: true
                - host: ch-replica05.example.com
                  port: 9440
                  secure: true
      distributed_ddl:
        path: '/clickhouse/task_queue/ddl'
      format_schema_path: '/var/lib/clickhouse/format_schemas/'
      zookeeper:
        node:
          - xmlattributes:
              index: 1
            host: zookeeper-node10.example.com
            port: 2181
          - xmlattributes:
              index: 2
            host: zookeeper-node02.example.com
            port: 2181
          - xmlattributes:
              index: 3
            host: zookeeper-node03.example.com
          - xmlattributes:
              index: 4
            host: zookeeper-node04.example.com
            port: 2181
          - xmlattributes:
              index: 5
            host: zookeeper-node05.example.com
            port: 2181
          - xmlattributes:
              index: 6
            host: zookeeper-node06.example.com
            port: 2181
          - xmlattributes:
              index: 7
            host: zookeeper-node07.example.com
            port: 2181
          - xmlattributes:
              index: 8
            host: zookeeper-node08.example.com
            port: 2181
          - xmlattributes:
              index: 9
            host: zookeeper-node09.example.com
            port: 2181
    users:
      default:
        networks:
          xmlattributes:
            replace: replace
          ip:
            - 127.0.0.1
            - ::1
        profile: default
        quota: default
      rw:
        password: 123
        networks:
          ip: 0.0.0.0/0
        profile: default
        quota: default
      readonly:
        password: 123
        networks:
          ip: 0.0.0.0/0
        profile: readonly
        quota: default
  client:
    config:
      openSSL:
        client:
          caConfig: '/etc/pki/tls/cert.pem'
   ```
   </details>
