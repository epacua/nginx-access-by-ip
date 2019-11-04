From time to time, an administrator may wish to know the unique number of IP addresses (sorted in descending order) that access his web server. In my case, I used to build a quite long Bash one-liner in order to derive that list of IP addresses. Until it became tedious and cumbersome.

This Perl script builds a list of unique IP addresses that have accessed Nginx (or Apache) server. In addition to IP addresses, it also displays the number of occurences and the 2-letter country code by referencing the free MaxMind GeoIP database provided by perl module Geo-IP. If run without argument, it parses the default access log at /var/log/nginx/access.log.

Dependencies:
- perl-Geo-IP
