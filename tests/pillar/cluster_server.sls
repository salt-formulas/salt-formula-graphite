graphite:
  server:
    enabled: true
    timezone: 'UTC'
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
