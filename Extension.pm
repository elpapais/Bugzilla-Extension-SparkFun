package Bugzilla::Extension::SparkFun;
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
