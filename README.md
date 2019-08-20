# clickhouse-saltstack-formula
saltstack formula for installation and configuration of Yandex Clickhouse

## 'clickhouse:config:files' usage
You will have to configure filetree on salt-master for use with files directive in pillar.

## rpm repo notes
Official Yandex rpm repo currently (on 20.08.2019) contains only one signed version of Clickhouse - 19.13.2.19-2.
If you need to install older version, you can set up non-official [altinity](https://github.com/Altinity/clickhouse-rpm-install) repo. Example can be found in [pillar.example](pillar.example)
