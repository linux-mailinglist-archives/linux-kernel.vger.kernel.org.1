Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ABC285E1E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgJGL3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgJGL3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:29:11 -0400
Received: from mail.kernel.org (ip5f5ad5a2.dynamic.kabel-deutschland.de [95.90.213.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B68D206F7;
        Wed,  7 Oct 2020 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602070150;
        bh=gPlsvrp/d3pXddehvFSomJ9Zv0RFOBI90aXQGDdqrN4=;
        h=From:To:Cc:Subject:Date:From;
        b=xtccH8OGQUnyxfaFJdzwVl48pbviyQi8O1fH8+aZvPtRvenegTBfwzHIoJJ6sOZAx
         qgLfn8cBS70u8uJHDPBOQnwtMT+U5QvitkYB4yOiB9HtypnX/9Vp7ZJMLfeOTi1fvV
         iuOD2rfbpWfLAukKeSVrjABhunQTBgVYMLgDKV64=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kQ7d4-001eOj-CK; Wed, 07 Oct 2020 13:29:06 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] script: add a script for checking doc problems with external functions
Date:   Wed,  7 Oct 2020 13:29:04 +0200
Message-Id: <aac55ad312d17bb12f905b544a4e485ad507735d.1602070137.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While not all EXPORT_SYMBOL*() symbols should be documented,
it seems useful to have a tool which would help to check what
symbols aren't documented.

This is a first step on this direction. The tool has some
limitations. Yet, it could be useful for maintainers to check
about missing documents on their subsystems.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/check_docs_external_symbols | 267 ++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)
 create mode 100755 scripts/check_docs_external_symbols

diff --git a/scripts/check_docs_external_symbols b/scripts/check_docs_external_symbols
new file mode 100755
index 000000000000..cfa49015ded3
--- /dev/null
+++ b/scripts/check_docs_external_symbols
@@ -0,0 +1,267 @@
+#!/usr/bin/perl
+# SPDX-License-Identifier: GPL-2.0
+
+#
+# Copyright (c) 2020, Huawei Tech. Co., Ltd.
+# Author: Mauro Carvalho Chehab <mchehab+huawei@kernel.org
+#
+# This script helps to check if exported functions are documented at either
+# a file, on at the included headers.
+#
+# The script uses some heuristics, being greedy when checking for includes
+# that aren't found at the normal place. This makes the script slower,
+# but increases the chance of finding a documentation for the symbol.
+#
+# Please always check the results of the script.
+#
+# Usage:
+#	scripts/check_external docs
+# or:
+#	scripts/check_external docs <files and/or directories>
+
+use warnings;
+use strict;
+use File::Find;
+use Cwd 'abs_path';
+
+use Data::Dumper;
+
+sub check_kerneldoc_symbols($$$$) {
+	my $file = shift;
+	my $docfile = shift;
+	my $exp = shift;
+	my $h = shift;
+	my @exports = @{$exp};
+	my %hash = %{$h};
+	my $is_kerneldoc = 0;
+	my $kerneldoc;
+	my $type;
+	my ($indent, $tag_indent);
+	my (@yes_symbols, @no_symbols);
+
+	$file = abs_path($file);
+
+	open IN, $docfile or return 0;
+	while (<IN>) {
+		while (s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {};
+		if (/^(\s*)\.\.\s+kernel-doc\:\:\s*(\S+)/) {
+			$indent = $1;
+			$kerneldoc = abs_path($2);
+			$is_kerneldoc = 1;
+			@yes_symbols = @exports;
+			@no_symbols = ();
+			$tag_indent = "";
+			next;
+		}
+
+		next if (!$is_kerneldoc);
+
+		if ($tag_indent ne "" && /^($tag_indent)\s+(.*)/) {
+			my @sym = split /\s+/, $2;
+			if ($type eq "identifiers") {
+				push @yes_symbols, @sym;
+			} else {
+				push @no_symbols, @sym;
+			}
+
+			next;
+		}
+
+		if (/^($indent)\S/) {
+			$is_kerneldoc = 0;
+
+			if ($kerneldoc eq $file) {
+				$hash{$_}++ for (@yes_symbols);
+				$hash{$_}-- for (@no_symbols);
+			}
+
+			next;
+		}
+
+		next if ($kerneldoc ne $file);
+
+		# Check for kernel-doc variants
+
+		if (m/:internal:/) {
+			@yes_symbols = ();
+			next;
+		}
+		if (m/:export:/) {
+			# Nothing to do here, as exports are covered
+			next;
+		}
+
+		# Those are more painful to handle
+		if (m/^(\s+):identifiers:\s*(.*)/ || m/^(\s+):functions:\s*(.*)/) {
+			$tag_indent = $1;
+			$type = "identifiers";
+			@yes_symbols = split /\s+/, $2;
+
+			next;
+		}
+		if (m/^(\s+):no-identifiers:\s*(.*)/) {
+			$type = "no-identifiers";
+			$tag_indent = $1;
+			@no_symbols = split /\s+/, $2;
+
+			next;
+		}
+	}
+
+	if ($is_kerneldoc) {
+		if ($kerneldoc eq $file) {
+			$hash{$_}++ for (@yes_symbols);
+			$hash{$_}-- for (@no_symbols);
+		}
+	}
+
+
+	close IN;
+
+	return %hash;
+}
+
+sub check_file($) {
+	my $file = shift;
+	my (@files, @exports, @doc, @doc_refs, %file_exports, %hash);
+	my $content = "\n";
+
+	$file =~ s/\s+$//;
+
+	return 0 if (!($file =~ /\.[ch]$/));
+
+	my $dir = $file;
+	$dir =~ s,[^\/]+$,,;
+
+	open IN, $file or return 0;
+	while (<IN>) {
+		push @exports, $1 if (m/^EXPORT_SYMBOL.*\(\s*(\S+)\s*\)/);
+
+		if (m/^\s*#\s*include\s+[\<](\S+)[\>]/) {
+			if (-e "include/uapi/$1") {
+				push @files, "include/uapi/$1";
+			} elsif (-e "include/$1") {
+				push @files, "include/$1";
+			} else {
+				my @inc = split /\s+/,qx(git ls-files|grep $1);
+				push @files, @inc;
+			}
+		}
+		if (m/^\s*#\s*include\s+[\"](\S+)[\"]/) {
+			if (-e "$dir/$1") {
+				push @files, "$dir/$1";
+			} else {
+				my @inc = split /\s+/,qx(git ls-files|grep $1);
+				push @files, @inc;
+			}
+		}
+		$content .= $_;
+	}
+	close IN;
+
+	return 0 if ($content eq "\n");
+
+	push @files, $file;
+	my $has_docs = 0;
+	for (my $i = 0; $i < scalar(@files); $i++) {
+		$doc_refs[$i] = 0;
+		$file_exports{$files[$i]} = ();
+		$doc[$i] = qx(./scripts/kernel-doc --sphinx-version 3.2.1 $files[$i] 2>/dev/null);
+		$has_docs =1 if ($doc[$i] ne "");
+	}
+
+	#
+	# Shortcut: if neither the file nor any headers has kernel-doc
+	# markups, there's no need to do anything else.
+	#
+	if (!$has_docs) {
+		print "warning: $file: has exports but no documentation\n";
+		return 1;
+	}
+
+	my @missing_exports;
+	my $found = -1;
+	my $num_not_functions = 0;
+	foreach my $e (@exports) {
+		# Check if the symbol is a function
+		if (!($content =~ (m/\n\s*(?:\w+\s+){0,}\*?\s*\b\Q$e\E\b\s*\(/))) {
+			$num_not_functions++;
+			next;
+		}
+		for (my $i = 0; $i < scalar(@files); $i++) {
+			if ($doc[$i] =~ m/\b\Q$e\E\b/) {
+				$found = $i;
+				$doc_refs[$i]++;
+				last;
+			}
+			push @{$file_exports{$files[$i]}}, $e;
+		}
+
+		push @missing_exports, $e if ($found < 0);
+	}
+
+	if (scalar(@exports) == scalar(@missing_exports) + $num_not_functions) {
+		print "warning: $file: has exports but no documentation\n";
+		return 1;
+	}
+
+	if (@missing_exports) {
+		print "warning: $file: missing documentation for @missing_exports\n";
+	}
+
+	for (my $i = 0; $i < scalar(@files); $i++) {
+		next if (!$doc_refs[$i]);
+		$hash{$_} = 0 for (@{$file_exports{$files[$i]}});
+		my @includes = split /\s+/, qx(git grep -l "kernel-doc::\\s*$files[$i]" Documentation/);
+
+		if (!@includes) {
+			printf "warning: %s: file not included at Documentation/\n",
+			       $files[$i];
+			return 1;
+		}
+
+		# Parse the $includes files, in order to check for
+		# excluded symbols
+
+		foreach my $inc (@includes) {
+			%hash = check_kerneldoc_symbols($files[$i], $inc,
+						        \@{$file_exports{$files[$i]}}, \%hash);
+		}
+		foreach my $s (keys %hash) {
+			if ($hash{$s} < 1) {
+				print "$files[$i]: export symbol $s not documented at: @includes\n";
+			} elsif ($hash{$s} > 1) {
+				print "$files[$i]: export symbol $s was documented %d times\n",
+				    $hash{$s};
+			}
+		}
+	}
+
+	return 1;
+}
+
+sub parse_dir {
+	check_file $File::Find::name;
+}
+
+#
+# main
+#
+
+if (@ARGV) {
+	while (@ARGV) {
+		my $file = shift;
+
+		if (-d $file) {
+			find({wanted => \&parse_dir, no_chdir => 1}, $file);
+		} else {
+			check_file $file;
+		}
+	}
+	exit;
+} else {
+	my @files = qx(git grep -l EXPORT_SYMBOL);
+	foreach my $file (@files) {
+		check_file $file;
+	}
+}
-- 
2.26.2

