
include:
{%- if pillar.graphite is defined %}
{%- if pillar.graphite.server is defined %}
- graphite.server
{%- endif %}
{%- endif %}
{%- if pillar.carbon is defined %}
- graphite.collector.aggregator
- graphite.collector.cache
- graphite.collector.relay
{%- endif %}
