{%- from "graphite/map.jinja" import cache with context %}
{%- if cache.enabled %}

include:
- graphite.collector._common

/etc/carbon/storage-schemas.conf:
  file.managed:
  - source: salt://graphite/files/storage-schemas.conf
  - template: jinja
  - user: root
  - group: root
  - require:
    - pkg: carbon_packages

/usr/conf/storage-schemas.conf:
  file.symlink:
  - target: /etc/carbon/storage-schemas.conf
  - require:
    - pkg: carbon_packages

carbon-cache:
  service.running:
  - enable: true
  - watch:
    - file: /etc/carbon/storage-schemas.conf

{%- endif %}