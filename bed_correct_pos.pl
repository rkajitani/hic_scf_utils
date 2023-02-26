#!/usr/bin/perl

(@ARGV != 3) and die "usage: $0 pair.bed ref_len.tsv min_aln_len\n";

$min_aln_len = $ARGV[2];

open(IN, $ARGV[1]);
while (chomp($l = <IN>)) {
	@f = split(/\t/, $l);
	$ref_len{$f[0]} = $f[1];
}
close(IN);

open(IN, $ARGV[0]);
while (chomp($l1 = <IN>)) {
	chomp($l2 = <IN>);

	@f1 = split(/\t/, $l1);
	@f2 = split(/\t/, $l2);

	$f1[1] = 0 if ($f1[1] < 0);
	$f1[2] = $ref_len{$f1[0]} if ($f1[2] > $ref_len{$f1[0]});

	$f2[1] = 0 if ($f2[1] < 0);
	$f2[2] = $ref_len{$f2[0]} if ($f2[2] > $ref_len{$f2[0]});

	if ($f1[2] - $f1[1] >= $min_aln_len and $f2[2] - $f2[1] >= $min_aln_len) {
		print(join("\t", @f1), "\n");
		print(join("\t", @f2), "\n");
	}
}
close(IN);
