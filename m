Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D654B27BE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgI2HpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:45:23 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:65224 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgI2HpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:45:23 -0400
X-IronPort-AV: E=Sophos;i="5.77,317,1596492000"; 
   d="scan'208";a="469986358"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 09:45:18 +0200
Date:   Tue, 29 Sep 2020 09:45:17 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] scripts/most_common_subject_prefix.pl: Find the most
 common commit subject prefix
In-Reply-To: <e949cb8f12caec813c22dc3791a92e9f87670a5b.1601356990.git.joe@perches.com>
Message-ID: <alpine.DEB.2.22.394.2009290941260.2808@hadrien>
References: <e949cb8f12caec813c22dc3791a92e9f87670a5b.1601356990.git.joe@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Sep 2020, Joe Perches wrote:

> A common patch subject prefix for specific files is to use the
> lowest level directory or just the basename of the file without the
> file extension.  For patches that touch multiple files, it's common to
> use the basename directory as the commit prefix.
>
> For example, patches to files in drivers/net/ethernet/intel/igb/ are
> most commonly prefixed with "igb: <then some description>".
>
> But many subsystems have specific commit subject line prefixes that are
> not simply the containing base directory.  For example, patches to
> drivers/staging are most often prefixed with "staging: <basename dir>: "
> then "<commit specific description>".
>
> So add a tool that can help find what prefix the subsystem or file most
> commonly uses for patch commit subject lines.
>
> This tool uses git log history in various ways to find the most common
> prefix used in for a specific file or path.
>
> $ ./scripts/most_common_subject_prefix.pl <file>
>
> This will emit a single line that is the most commonly used commit
> subject prefix up to and including the last colon of the commit subject
> for commits that _only_ include the specific file and not any other file.

For the comma->semicolon patches, I noticed the need for a number of
suject lines of the form:

hwrng: xxx - patch description

So maybe other delimiters have to be taken into account.

julia



>
> For instance:
>
> $ ./scripts/most_common_subject_prefix.pl arch/arm/net/bpf_jit_32.c
> ARM: net: bpf:
>
> An optional flag is --details which by default shows up to the 5 most common
> commit subject prefixes and will show commits with just the single file as
> well as commits that include other files.
>
> $ ./scripts/most_common_subject_prefix.pl arch/arm/net/bpf_jit_32.c --details
> Single file commits:
>      24 ARM: net: bpf:
>       5 bpf, arm32:
>       3 bpf, arm:
>       2 arm, bpf:
>       1 ARM: net:
> Multiple file commits:
>       4 ARM: net: bpf:
>       2 arm:
>       2 bpf:
>       1 ARM: net:
>       1 arm: bpf:
>
> command-line options are currently:
>   --git-since=<date>         (default: 5-years-ago)
>     (use commits more recent than this date to find the typical subject prefix)
>   --details                  show subject prefix details (default: 0/off)
>   --detail_lines=<count>     lines of details to show (default: 5)
>   --root=PATH                PATH to the kernel tree root (default: ./)
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  scripts/most_common_subject_prefix.pl | 183 ++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>  create mode 100755 scripts/most_common_subject_prefix.pl
>
> diff --git a/scripts/most_common_subject_prefix.pl b/scripts/most_common_subject_prefix.pl
> new file mode 100755
> index 000000000000..c3ceeacbec2f
> --- /dev/null
> +++ b/scripts/most_common_subject_prefix.pl
> @@ -0,0 +1,183 @@
> +#!/usr/bin/env perl
> +
> +# Show possible patch subject prefixes for a file in git
> +
> +# use only commits that modify the file argument and
> +# emit up to the 5 most common commit headers
> +
> +use warnings;
> +use strict;
> +
> +my $P = $0;
> +my $V = '0.1';
> +
> +my $git_command ='export LANGUAGE=en_US.UTF-8; git';
> +my $root;
> +my $gitroot = $ENV{'GIT_DIR'};
> +$gitroot = ".git" if !defined($gitroot);
> +my $git_since = "5-years-ago";
> +my $details = 0;
> +my $detail_lines = 5;
> +my $version = 0;
> +my $help = 0;
> +
> +sub usage {
> +    print <<EOT;
> +usage: $P [options] <file|path in git>
> +version: $V
> +
> +Options:
> +  --git-since=<date>         (default: $git_since)
> +    (use commits more recent than this date to find the typical subject prefix)
> +  --details                  show subject prefix details (default: $details)
> +  --detail_lines=<count>     lines of details to show (default: $detail_lines)
> +  --root=PATH                PATH to the kernel tree root (default: ./)
> +
> +EOT
> +}
> +
> +use Getopt::Long qw(:config no_auto_abbrev);
> +
> +if (!GetOptions(
> +		'git-since=s'	=> \$git_since,
> +		'details!'	=> \$details,
> +		'detail_lines=i'=> \$detail_lines,
> +		'root=s'	=> \$root,
> +		'v|version'	=> \$version,
> +		'h|help|usage'	=> \$help,
> +		)) {
> +    die "$P: invalid argument - use --help if necessary\n";
> +}
> +
> +if ($help != 0) {
> +    usage();
> +    exit 0;
> +}
> +
> +if ($version != 0) {
> +    print("${P} ${V}\n");
> +    exit 0;
> +}
> +
> +die "$P: Must have a single <file|path> argument\n" if ($#ARGV != 0);
> +
> +die "$P: git not found\n" if (which("git") eq "");
> +die "$P: git directory not found\n" if (!(-e "$gitroot"));
> +
> +if (defined $root) {
> +	if (!top_of_kernel_tree($root)) {
> +		die "$P: $root: --root does not point at a valid kernel tree\n";
> +	}
> +} else {
> +	if (top_of_kernel_tree('.')) {
> +		$root = '.';
> +	} elsif ($0 =~ m@(.*)/scripts/[^/]*$@ &&
> +		     top_of_kernel_tree($1)) {
> +		$root = $1;
> +	}
> +}
> +
> +if (!defined $root) {
> +	print "$P: Must be run from the top-level dir of a kernel tree\n";
> +	exit(2);
> +}
> +
> +sub prefixes_from_subjects {
> +	my ($array_ref) = @_;
> +	my %lc;
> +	my @subjects = ();
> +
> +	foreach my $line (@$array_ref) {
> +		my $pos = rindex($line, ':');
> +		if ($pos > 0) {
> +			my $prefix = substr($line, 0, $pos + 1);
> +			$lc{$prefix}++;
> +		}
> +	}
> +
> +	foreach my $subject (sort { $lc{$b} <=> $lc{$a} or $a cmp $b } keys %lc) {
> +		push(@subjects, sprintf("%7u %s\n", $lc{$subject}, $subject));
> +	}
> +
> +	return @subjects;
> +}
> +
> +my @commit_desc = ();
> +my $commit_count = 0;
> +my @single_file_subjects = ();
> +my @multi_file_subjects = ();
> +
> +my $output = `${git_command} log --no-merges --since=$git_since --format='%h' -- $ARGV[0]`;
> +my @commits = split('\n', $output);
> +
> +foreach my $commit (@commits) {
> +	$output = `${git_command} log --format='%s' --name-only -1 $commit`;
> +	$commit_desc[$commit_count++] = $output;
> +}
> +
> +for (my $i = 0; $i < $commit_count; $i++) {
> +	my @lines = split('\n', $commit_desc[$i]);
> +	if ($#lines == 2 && $lines[2] eq $ARGV[0]) {
> +		push(@single_file_subjects, $lines[0]);
> +	} elsif ($#lines >= 2) {
> +		push(@multi_file_subjects, $lines[0]);
> +	}
> +}
> +
> +my @best_prefixes;
> +
> +if ($details) {
> +	@best_prefixes = prefixes_from_subjects(\@single_file_subjects);
> +	if ($#best_prefixes > 0) {
> +		print("Single file commits:\n");
> +		print(splice(@best_prefixes, 0, $detail_lines));
> +	}
> +	@best_prefixes = prefixes_from_subjects(\@multi_file_subjects);
> +	if ($#best_prefixes > 0) {
> +		print("Multiple file commits:\n");
> +		print(splice(@best_prefixes, 0, $detail_lines));
> +	}
> +} else {
> +	@best_prefixes = prefixes_from_subjects(\@single_file_subjects);
> +	if ($#best_prefixes > 0) {
> +		my $line = splice(@best_prefixes, 0, 1);
> +		$line =~ s/^\s*\w+ //;
> +		print("$line");
> +	} else {
> +		@best_prefixes = prefixes_from_subjects(\@multi_file_subjects);
> +		if ($#best_prefixes > 0) {
> +			my $line = splice(@best_prefixes, 0, 1);
> +			$line =~ s/^\s*\w+ //;
> +			print("$line");
> +		}
> +	}
> +}
> +
> +sub which {
> +	my ($bin) = @_;
> +
> +	foreach my $path (split(/:/, $ENV{PATH})) {
> +		if (-e "$path/$bin") {
> +			return "$path/$bin";
> +		}
> +	}
> +
> +	return "";
> +}
> +
> +sub top_of_kernel_tree {
> +	my ($root) = @_;
> +
> +	my @tree_check = (
> +		"COPYING", "CREDITS", "Kbuild", "MAINTAINERS", "Makefile",
> +		"README", "Documentation", "arch", "include", "drivers",
> +		"fs", "init", "ipc", "kernel", "lib", "scripts",
> +	);
> +
> +	foreach my $check (@tree_check) {
> +		if (! -e $root . '/' . $check) {
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}
> --
> 2.26.0
>
>
