{%- from "graphite/map.jinja" import relay with context %}
{%- if relay.enabled %}

include:
- graphite.collector._common

/etc/carbon/relay-rules.conf:
  file.managed:
  - source: salt://graphite/files/relay-rules.conf
  - template: jinja
  - user: root
  - group: root
  - require:
    - pkg: carbon_packages

/usr/conf/relay-rules.conf:
  file.symlink:
  - target: /etc/carbon/relay-rules.conf
  - require:
    - pkg: carbon_packages

{%- if grains.get('init', None) == 'systemd' %}

carbon-relay@1:
  service.running:
  - enable: true
  - watch:
    - file: /etc/carbon/relay-rules.conf

{%- else %}

carbon-relay:
  service.running:
  - enable: true
  - watch:
    - file: /etc/carbon/relay-rules.conf

{%- endif %}

{%- endif %}