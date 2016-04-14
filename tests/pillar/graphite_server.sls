graphite:
  server:
    enabled: true
    debug: true
    timezone: 'UTC'
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

