{%- from "graphite/map.jinja" import server with context %}
{%- if server.enabled %}

graphite_packages:
  pkg.installed:
  - names:
    - python-memcache
    - python-psycopg2
    - python-imaging
    - python-cairo
    - graphite-web
    - python-txamqp

/etc/graphite/dashboard.conf:
  file.managed:
  - source: salt://graphite/files/dashboard.conf
  - template: jinja
  - user: root
  - group: root
  - require:
    - pkg: graphite_packages

/etc/graphite/graphTemplates.conf:
  file.managed:
  - source: salt://graphite/files/graphTemplates.conf
  - template: jinja
  - user: root
  - group: root
  - require:
    - pkg: graphite_packages

/etc/graphite/local_settings.py:
  file.managed:
  - source: salt://graphite/files/local_settings.py
  - template: jinja
  - user: root
  - group: root
  - require:
    - pkg: graphite_packages

{%- if not grains.get('noservices', False) %}

/usr/bin/graphite-manage migrate auth --noinput:
  cmd.run:
  - require:
    - file: /etc/graphite/local_settings.py

/usr/bin/graphite-manage migrate --noinput:
  cmd.run:
  - require:
    - cmd: /usr/bin/graphite-manage migrate auth --noinput

{%- endif %}

{%- endif %}
