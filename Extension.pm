package Bugzilla::Extension::SparkFun;

# The contents of this file are subject to the Mozilla Public
# License Version 1.1 (the "License"); you may not use this file
# except in compliance with the License. You may obtain a copy of
# the License at http://www.mozilla.org/MPL/
#
# Software distributed under the License is distributed on an "AS
# IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
# implied. See the License for the specific language governing
# rights and limitations under the License.
#
# The Original Code is the InlineImages Bugzilla Extension.
#
# The Initial Developer of the Original Code is Guy Pyrzak
# Portions created by the Initial Developer are Copyright (C) 2010 the
# Initial Developer. All Rights Reserved.
#
# Contributor(s):
#   Guy Pyrzak <guy.pyrzak@gmail.com>
#   Brennen Bearnes <brennen@sparkfun.com>

use strict;
use base qw(Bugzilla::Extension);
use Bugzilla::Template;
use Bugzilla::Util qw(diff_arrays html_quote);

#use constant NAME => 'SparkFun';

our $VERSION = '0.1';

sub bug_format_comment {
    my ($self, $args) = @_;
    my $regexes = $args->{'regexes'};
    
    push(@$regexes, {    
        match   => qr/(order [#]?([0-9]+))/i,
        replace => \&_orderlink
    });

    push(@$regexes, {    
        match   => qr/(customer [#]?([0-9]+))/i,
        replace => \&_customerlink
    });

    push(@$regexes, {    
        match   => qr/(purchase [#]?([0-9]+))/i,
        replace => \&_purchaselink
    });
}

sub _orderlink {
  my $args = shift;
  my $text = $args->{matches}->[0];
  my $order = $args->{matches}->[1];
  return '<a href="https://sparkle.internal.sparkfun.com/sparkle/orders/' . $order . '">' . html_quote($text) . '</a>';
}

sub _customerlink {
  my $args = shift;
  my $text = $args->{matches}->[0];
  my $customer = $args->{matches}->[1];
  return '<a href="https://sparkle.internal.sparkfun.com/sparkle/customers/' . $customer . '">' . html_quote($text) . '</a>';
}

sub _purchaselink {
  my $args = shift;
  my $text = $args->{matches}->[0];
  my $purchase = $args->{matches}->[1];
  return '<a href="https://sparkle.internal.sparkfun.com/sparkle/purchases/' . $purchase . '">' . html_quote($text) . '</a>';
}

__PACKAGE__->NAME;
