#!/usr/bin/perl

(@ARGV != 2) and die "usage: $0 merged_nodups.txt min_MQ\n";

$min_mq = $ARGV[1];

open(IN, $ARGV[0]);
while (chomp($l = <IN>)) {
	@f = split(/ /, $l);

	next if ($f[8] < $min_mq or $f[11] < $min_mq);

	$aln_len1 = length($f[10]);
	if ($f[9] =~ /^(\d+)S/) {
		$aln_len1 -= $1;
	}
	if ($f[9] =~ /(\d+)S$/) {
		$aln_len1 -= $1;
	}

	$aln_len2 = length($f[13]);
	if ($f[12] =~ /^(\d+)S/) {
		$aln_len2 -= $1;
	}
	if ($f[12] =~ /(\d+)S$/) {
		$aln_len2 -= $1;
	}

	$strand1 = $f[0] eq '0' ? '+' : '-';
	$strand2 = $f[4] eq '0' ? '+' : '-';

	print(join("\t", ($f[1], $f[2] - 1, $f[2] + $aln_len1 - 1, $f[14] . '/1', $f[8], $strand1)), "\n");
	print(join("\t", ($f[5], $f[6] - 1, $f[6] + $aln_len2 - 1, $f[15] . '/2', $f[11], $strand2)), "\n");
}
close(IN);
