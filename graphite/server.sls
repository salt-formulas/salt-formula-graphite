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

{#
graphite_packages:
  pip.installed:
  - names:
#    - git+git://github.com/graphite-project/whisper.git@0.9.13#egg=whisper
    - whisper
#    - git+git://github.com/graphite-project/ceres.git#egg=ceres
    - graphite-web
    - gunicorn
    - django>=1.4,<1.5
    - python-memcached==1.47
    - txAMQP==0.6.2
    - simplejson==2.1.6
    - django-tagging==0.3.1
    - pytz
    - pyparsing==1.5.7
    - cairocffi
    - MySQL-python
  - require:
    - pkg: graphite_system_packages

graphite_user:
  user.present:
  - name: graphite
  - system: True
  - home: /opt/graphite
  - require:
    - pip: graphite_packages
#}

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