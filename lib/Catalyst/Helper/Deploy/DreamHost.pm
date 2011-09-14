package Catalyst::Helper::Deploy::DreamHost;

# ABSTRACT: Create a couple files useful when deploying to DreamHost

use namespace::autoclean;
use common::sense;

use Path::Class;

sub mk_stuff {
    my ($self, $helper, $args) = @_;

    #my $app = lc $helper->{app};

    my $base = $helper->{base};
    my $app  = lc $helper->{app};

    $app =~ s/::/_/g;

    my $dir = dir qw{ deploy dreamhost };
    $helper->mk_dir("$dir");

    #my %files = (
    #    htaccess => file $dir, 'htaccess';
    my $script = file $dir, 'htaccess';
    $helper->render_file($_, file($dir, $_)->stringify)
        for qw{ htaccess dispatch.fcgi };

    return;
}

1;

=head1 SYNOPSIS

./script/myapp_create.pl Deploy::DreamHost

=head1 DESCRIPTION

This is a Catalyst helper module that builds a basic htaccess and
dispatch.fcgi that you can use to assist in deploying your Catalyst app to
DreamHost.

VERY EARLY CODE: things may yet change, but shouldn't impact older versions
(unless you rerun the helper, natch).

=head1 TODO

Git hook?

=cut

__DATA__
__htaccess__

Options +ExecCGI +FollowSymLinks
AddHandler fastcgi-script .fcgi

# ----------------------------------------------------------------------
# UTF-8 encoding
# ----------------------------------------------------------------------

# Use UTF-8 encoding for anything served text/plain or text/html
AddDefaultCharset utf-8

# Force UTF-8 for a number of file formats
AddCharset utf-8 .html .css .js .xml .json .rss .atom

RewriteEngine On
RewriteBase /

#RewriteCond %{REQUEST_URI} ^/static.*$ [NC]
#RewriteRule . - [L]

RewriteCond %{REQUEST_URI} ^/(stats|failed_auth\.html).*$ [NC]
RewriteRule . - [L]
RewriteRule ^(dispatch\.fcgi/.*)$ - [L]
RewriteRule ^(.*)$ dispatch.fcgi/$1 [PT,L]

__dispatch.fcgi__
#!/usr/bin/env perl

use strict;
use warnings;

use lib "$ENV{HOME}/[% app %]/lib";

use Plack::Handler::FCGI;
use Plack::Builder;

my $app = builder {

    do "$ENV{HOME}/[% app %]/[% app | lower %].psgi";
};

Plack::Handler::FCGI->new->run($app);
