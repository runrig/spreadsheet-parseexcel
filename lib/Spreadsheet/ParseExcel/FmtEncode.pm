package Spreadsheet::ParseExcel::FmtEncode;
use strict;
use warnings;
use Encode qw( decode );

use base 'Spreadsheet::ParseExcel::FmtDefault';

sub TextFmt {
    my $self     = shift;
    my $data     = shift;
    my $encoding = shift // 'iso-8859-1';

    return decode( $encoding, $data, Encode::FB_CROAK );
}

1;
