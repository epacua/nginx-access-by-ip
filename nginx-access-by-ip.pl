#!/usr/bin/env perl
# Author: Erwin Pacua
# Date: Sat April 22 10:52:12 2019 +1300

use strict;
use warnings;

die "This program accepts 0 (defaults to nginx access logfile) or 1 argument. Exiting... $!" if @ARGV > 1;
my $file = do {
    if (defined $ARGV[0]) { $ARGV[0] }
    elsif (-f "/var/log/nginx/access.log") { "/var/log/nginx/access.log" }
    else { die "\nUnable to read access log or non was supplied.\n\n"; }
};


use Geo::IP;
my $gi = Geo::IP->new(GEOIP_MEMORY_CACHE);
my $ip_address;

my $my_re = qr/^(\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b)/;
my @my_ips;
open(my $FH, "<", $file) or die "Can't open the file $file: $1";
while (<$FH>) {
    if (/$my_re/) {
        push(@my_ips, $1);
    };
}
my %hash_ip = ();
my $count = 0;
foreach my $ip (sort @my_ips) {
    if (exists($hash_ip{$ip})) {
        $hash_ip{$ip}++; 
    } else {
        $hash_ip{$ip} = 1; 
    }
}

foreach my $key (sort { $hash_ip{$b} <=> $hash_ip{$a} } keys %hash_ip) {
	my $country = $gi->country_code_by_addr($key);
    if (defined $country) {
		print "  $hash_ip{$key} $key -- $country\n";
	} else {
		print "  $hash_ip{$key} $key (country code not available)\n";
	}
}
