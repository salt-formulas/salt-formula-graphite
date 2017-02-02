
========
Graphite
========

Graphite is an enterprise-scale monitoring tool that runs well on cheap hardware.

Sample pillars
==============

Single Graphite web server

.. code-block:: yaml

    graphite:
      server:
        enabled: true
        debug: true
        timezone: 'Europe/Prague'
        cache:
          engine: 'memcached'
          host: '127.0.0.1'
          prefix: 'GRAPHITE'
        database:
          engine: 'postgresql'
          host: '127.0.0.1'
          name: 'graphite'
          password: 'password'
          user: 'graphite'
        mail:
          host: mail1.domain.com
          password: pwd
          user: username

Graphite web server cluster

.. code-block:: yaml

    graphite:
      server:
        enabled: true
        time_zone: 'Europe/Prague'
        database: ...
        mail: ...
        carbon_links:
        - host: 10.0.0.1
          port: 7002
        - host: 10.0.0.2
          port: 7002
        cache:
          engine: 'memcached'
          members:
          - host: 10.0.0.1
            port: 11211
          - host: 10.0.0.2
            port: 11211

Complete single Carbon collector

.. code-block:: yaml

    carbon:
      relay:
        enabled: true
        method: consistent-hashing
      aggregator:
        enabled: false
      cache:
        storage_schema:
          default:
            pattern: '.*'
            retentions:
            - 60s:1d
            - 600s:90d

Clustered Carbon with AMQP and aggregation

.. code-block:: yaml

    carbon:
      relay:
        enabled: true
        method: rules
        message_queue:
          host: broker1.domain.com
          port: 5672
          user: monitor
          password: pwd
          virtual_host: '/monitor'
          exchange: 'metrics'
        destinations:
        - host: 10.0.0.1
          port: 2024
        - host: 10.0.0.2
          port: 2024
      aggregator:
        enabled: true
        destinations:
        - host: 10.0.0.1
          port: 2004
        - host: 10.0.0.2
          port: 2004
      cache:
        storage_schema:
          default:
            pattern: '.*'
            retentions:
            - 60s:1d
            - 600s:90d

Read more
=========
s
* http://graphite.readthedocs.org/en/latest/
* http://www.canopsis.org/2013/02/collectd-graphite/
* http://graphite.readthedocs.org/en/latest/install.html
* http://stackoverflow.com/questions/19894708/cant-start-carbon-12-04-python-error-importerror-cannot-import-name-daem
* http://www.kinvey.com/blog/108/graphite-on-ubuntu-1204-lts-8211-part-ii-gunicorn-nginx-and-supervisord
* https://github.com/obfuscurity/graphite-scripts/blob/master/init.d/carbon-relay

Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use Github issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-graphite/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

You can also join salt-formulas-users team and subscribe to mailing list:

    https://launchpad.net/~salt-formulas-users

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

    https://github.com/salt-formulas/salt-formula-graphite

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
