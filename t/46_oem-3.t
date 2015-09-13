#!perl -w

use strict;
use Test::More;

use Spreadsheet::ParseExcel;
use Spreadsheet::ParseExcel::FmtEncode;

use utf8;

my $xl   = Spreadsheet::ParseExcel->new;
my $fmte = Spreadsheet::ParseExcel::FmtEncode->new;

my $book = $xl->Parse("t/excel_files/TestMoreEncoding.xls", $fmte);
ok $book, "load TestMoreEncoding.xls";

my $sheet = $book->worksheet(0);

my @expected = (
	['This is a test file for various encodings'],
	[qw(ローマ数字	Ⅰ	Ⅱ)],
	[qw(丸数字	①	②)],
	[qw(年号	㍻	㍼)],
	[qw(その他	㈱	～)],
    ['Kendi çevrimiçi işinizi göz açıp kapayıncaya kadar kurun.', 'ÄÖÜäöüß', 'وأزيز التكاليف' ],
);


my($rmin, $rmax) = $sheet->row_range();
my($cmin, $cmax) = $sheet->col_range();

for my $i($rmin .. $rmax){
	for my $j($cmin .. $cmax){
		my $cell = $sheet->get_cell($i, $j);
		next unless $cell && $cell->value;
		is $cell->value, $expected[$i][$j], "[$i, $j]";
	}
}

done_testing;
