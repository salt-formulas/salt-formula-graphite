
carbon_packages:
  pkg.latest:
  - names:
    - graphite-carbon

/etc/carbon/carbon.conf:
  file.managed:
  - source: salt://graphite/files/carbon.conf
  - template: jinja
  - user: root
  - group: root
  - require:
    - pkg: carbon_packages

/usr/conf:
  file.directory

/usr/conf/carbon.conf:
  file.symlink:
  - target: /etc/carbon/carbon.conf
  - require:
    - pkg: carbon_packages
