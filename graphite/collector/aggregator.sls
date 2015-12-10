{%- from "graphite/map.jinja" import aggregator with context %}
{%- if aggregator.enabled %}

include:
- graphite.collector._common

/etc/carbon/rewrite-rules.conf:
  file.managed:
  - source: salt://graphite/files/rewrite-rules.conf
  - template: jinja
  - user: root
  - group: root
  - require:
    - pkg: carbon_packages

/etc/carbon/storage-aggregation.conf:
  file.managed:
  - source: salt://graphite/files/storage-aggregation.conf
  - template: jinja
  - user: root
  - group: root
  - require:
    - pkg: carbon_packages

carbon-aggregator:
  service.running:
  - enable: true
  - require:
    - file: /etc/init.d/carbon-aggregator
  - watch:
    - file: /etc/carbon/storage-aggregation.conf
    - file: /etc/carbon/rewrite-rules.conf

{%- endif %}