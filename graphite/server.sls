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

/usr/share/graphite-web/graphite.wsgi:
  file.managed:
  - source: salt://graphite/files/graphite.wsgi
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

/usr/bin/graphite-manage syncdb --noinput:
  cmd.run: 
  - require:
    - file: /etc/graphite/local_settings.py

{%- endif %}