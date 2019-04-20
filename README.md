From time to time, I would like to know the list of IP addresses that try to do various things to my web server. Previously, I would build a quite long Bash one-liner to derive that list. Until it became tedious and cumbersome.

This Perl script builds a list of unique IP addresses that accessed our Nginx (or Apache) server. In addition to IP addresses, it also displays the number of occurences and the 2-letter country code by referencing the free MaxMind GeoIP database provided by perl module Geo-IP. If run without argument, it parses the default access log at /var/log/nginx/access.log.

Dependencies:
- perl-Geo-IP
