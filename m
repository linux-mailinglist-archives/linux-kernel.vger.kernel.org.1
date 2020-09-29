Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C013E27BC7D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 07:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgI2FgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 01:36:22 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:44248 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725300AbgI2FgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 01:36:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 90144182CED28;
        Tue, 29 Sep 2020 05:36:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:421:541:800:960:973:979:982:988:989:1260:1311:1314:1345:1437:1515:1535:1605:1730:1747:1777:1792:2194:2197:2198:2199:2200:2201:2393:2559:2562:2693:3138:3139:3140:3141:3142:3653:3743:3865:3866:3867:3868:3870:3871:3872:3874:4050:4118:4321:4383:4605:5007:6119:6120:6261:6299:6691:7522:7903:7974:8957:9040:9121:10004:10848:11026:11233:11473:11658:11914:12043:12114:12219:12291:12297:12438:12555:12679:12895:12986:13161:13184:13229:13255:13894:21080:21221:21324:21450:21451:21627:21990:30054:30055:30062:30070:30074,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: pipe99_1e0cd2127187
X-Filterd-Recvd-Size: 7903
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue, 29 Sep 2020 05:36:19 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] scripts/most_common_subject_prefix.pl: Find the most common commit subject prefix
Date:   Mon, 28 Sep 2020 22:36:19 -0700
Message-Id: <e949cb8f12caec813c22dc3791a92e9f87670a5b.1601356990.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common patch subject prefix for specific files is to use the
lowest level directory or just the basename of the file without the
file extension.  For patches that touch multiple files, it's common to
use the basename directory as the commit prefix.

For example, patches to files in drivers/net/ethernet/intel/igb/ are
most commonly prefixed with "igb: <then some description>".

But many subsystems have specific commit subject line prefixes that are
not simply the containing base directory.  For example, patches to
drivers/staging are most often prefixed with "staging: <basename dir>: "
then "<commit specific description>".

So add a tool that can help find what prefix the subsystem or file most
commonly uses for patch commit subject lines.

This tool uses git log history in various ways to find the most common
prefix used in for a specific file or path.

$ ./scripts/most_common_subject_prefix.pl <file>

This will emit a single line that is the most commonly used commit
subject prefix up to and including the last colon of the commit subject
for commits that _only_ include the specific file and not any other file.

For instance:

$ ./scripts/most_common_subject_prefix.pl arch/arm/net/bpf_jit_32.c
ARM: net: bpf:

An optional flag is --details which by default shows up to the 5 most common
commit subject prefixes and will show commits with just the single file as
well as commits that include other files.

$ ./scripts/most_common_subject_prefix.pl arch/arm/net/bpf_jit_32.c --details
Single file commits:
     24 ARM: net: bpf:
      5 bpf, arm32:
      3 bpf, arm:
      2 arm, bpf:
      1 ARM: net:
Multiple file commits:
      4 ARM: net: bpf:
      2 arm:
      2 bpf:
      1 ARM: net:
      1 arm: bpf:

command-line options are currently:
  --git-since=<date>         (default: 5-years-ago)
    (use commits more recent than this date to find the typical subject prefix)
  --details                  show subject prefix details (default: 0/off)
  --detail_lines=<count>     lines of details to show (default: 5)
  --root=PATH                PATH to the kernel tree root (default: ./)

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/most_common_subject_prefix.pl | 183 ++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)
 create mode 100755 scripts/most_common_subject_prefix.pl

diff --git a/scripts/most_common_subject_prefix.pl b/scripts/most_common_subject_prefix.pl
new file mode 100755
index 000000000000..c3ceeacbec2f
--- /dev/null
+++ b/scripts/most_common_subject_prefix.pl
@@ -0,0 +1,183 @@
+#!/usr/bin/env perl
+
+# Show possible patch subject prefixes for a file in git
+
+# use only commits that modify the file argument and
+# emit up to the 5 most common commit headers
+
+use warnings;
+use strict;
+
+my $P = $0;
+my $V = '0.1';
+
+my $git_command ='export LANGUAGE=en_US.UTF-8; git';
+my $root;
+my $gitroot = $ENV{'GIT_DIR'};
+$gitroot = ".git" if !defined($gitroot);
+my $git_since = "5-years-ago";
+my $details = 0;
+my $detail_lines = 5;
+my $version = 0;
+my $help = 0;
+
+sub usage {
+    print <<EOT;
+usage: $P [options] <file|path in git>
+version: $V
+
+Options:
+  --git-since=<date>         (default: $git_since)
+    (use commits more recent than this date to find the typical subject prefix)
+  --details                  show subject prefix details (default: $details)
+  --detail_lines=<count>     lines of details to show (default: $detail_lines)
+  --root=PATH                PATH to the kernel tree root (default: ./)
+
+EOT
+}
+
+use Getopt::Long qw(:config no_auto_abbrev);
+
+if (!GetOptions(
+		'git-since=s'	=> \$git_since,
+		'details!'	=> \$details,
+		'detail_lines=i'=> \$detail_lines,
+		'root=s'	=> \$root,
+		'v|version'	=> \$version,
+		'h|help|usage'	=> \$help,
+		)) {
+    die "$P: invalid argument - use --help if necessary\n";
+}
+
+if ($help != 0) {
+    usage();
+    exit 0;
+}
+
+if ($version != 0) {
+    print("${P} ${V}\n");
+    exit 0;
+}
+
+die "$P: Must have a single <file|path> argument\n" if ($#ARGV != 0);
+
+die "$P: git not found\n" if (which("git") eq "");
+die "$P: git directory not found\n" if (!(-e "$gitroot"));
+
+if (defined $root) {
+	if (!top_of_kernel_tree($root)) {
+		die "$P: $root: --root does not point at a valid kernel tree\n";
+	}
+} else {
+	if (top_of_kernel_tree('.')) {
+		$root = '.';
+	} elsif ($0 =~ m@(.*)/scripts/[^/]*$@ &&
+		     top_of_kernel_tree($1)) {
+		$root = $1;
+	}
+}
+
+if (!defined $root) {
+	print "$P: Must be run from the top-level dir of a kernel tree\n";
+	exit(2);
+}
+
+sub prefixes_from_subjects {
+	my ($array_ref) = @_;
+	my %lc;
+	my @subjects = ();
+
+	foreach my $line (@$array_ref) {
+		my $pos = rindex($line, ':');
+		if ($pos > 0) {
+			my $prefix = substr($line, 0, $pos + 1);
+			$lc{$prefix}++;
+		}
+	}
+
+	foreach my $subject (sort { $lc{$b} <=> $lc{$a} or $a cmp $b } keys %lc) {
+		push(@subjects, sprintf("%7u %s\n", $lc{$subject}, $subject));
+	}
+
+	return @subjects;
+}
+
+my @commit_desc = ();
+my $commit_count = 0;
+my @single_file_subjects = ();
+my @multi_file_subjects = ();
+
+my $output = `${git_command} log --no-merges --since=$git_since --format='%h' -- $ARGV[0]`;
+my @commits = split('\n', $output);
+
+foreach my $commit (@commits) {
+	$output = `${git_command} log --format='%s' --name-only -1 $commit`;
+	$commit_desc[$commit_count++] = $output;
+}
+
+for (my $i = 0; $i < $commit_count; $i++) {
+	my @lines = split('\n', $commit_desc[$i]);
+	if ($#lines == 2 && $lines[2] eq $ARGV[0]) {
+		push(@single_file_subjects, $lines[0]);
+	} elsif ($#lines >= 2) {
+		push(@multi_file_subjects, $lines[0]);
+	}
+}
+
+my @best_prefixes;
+
+if ($details) {
+	@best_prefixes = prefixes_from_subjects(\@single_file_subjects);
+	if ($#best_prefixes > 0) {
+		print("Single file commits:\n");
+		print(splice(@best_prefixes, 0, $detail_lines));
+	}
+	@best_prefixes = prefixes_from_subjects(\@multi_file_subjects);
+	if ($#best_prefixes > 0) {
+		print("Multiple file commits:\n");
+		print(splice(@best_prefixes, 0, $detail_lines));
+	}
+} else {
+	@best_prefixes = prefixes_from_subjects(\@single_file_subjects);
+	if ($#best_prefixes > 0) {
+		my $line = splice(@best_prefixes, 0, 1);
+		$line =~ s/^\s*\w+ //;
+		print("$line");
+	} else {
+		@best_prefixes = prefixes_from_subjects(\@multi_file_subjects);
+		if ($#best_prefixes > 0) {
+			my $line = splice(@best_prefixes, 0, 1);
+			$line =~ s/^\s*\w+ //;
+			print("$line");
+		}
+	}
+}
+
+sub which {
+	my ($bin) = @_;
+
+	foreach my $path (split(/:/, $ENV{PATH})) {
+		if (-e "$path/$bin") {
+			return "$path/$bin";
+		}
+	}
+
+	return "";
+}
+
+sub top_of_kernel_tree {
+	my ($root) = @_;
+
+	my @tree_check = (
+		"COPYING", "CREDITS", "Kbuild", "MAINTAINERS", "Makefile",
+		"README", "Documentation", "arch", "include", "drivers",
+		"fs", "init", "ipc", "kernel", "lib", "scripts",
+	);
+
+	foreach my $check (@tree_check) {
+		if (! -e $root . '/' . $check) {
+			return 0;
+		}
+	}
+	return 1;
+}
-- 
2.26.0

