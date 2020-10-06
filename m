Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3809D284B25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgJFLxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgJFLxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:53:40 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 864AD2080A;
        Tue,  6 Oct 2020 11:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601985219;
        bh=xj3DKmTx+xt1aiabZV+/vLYvUVuonNKpv+Ct1aH1EHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5yyin2NOr4oSD50jB8ARYD+XBa8anpaThKEZxh48wy4EEVp4KVAutI6fdGCZeM+N
         LCb8S6HQ8plDyG7JYeaYYVkxgIGlN1hu1hiMow2opK9csBI39ul7UR4qX53KH23X+Z
         9/OMvCv2SusraPLjD1pwXSWLIFl9dWS7e0X1I/us=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPlXF-0015t5-2w; Tue, 06 Oct 2020 13:53:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC] script: add a script for checking doc problems with external functions
Date:   Tue,  6 Oct 2020 13:53:34 +0200
Message-Id: <e40a32900dba6b8e7a1f41838ee8caeb1ef1c1b3.1601985151.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005125920.27a7768d@coco.lan>
References: <20201005125920.27a7768d@coco.lan>
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
 scripts/check_docs_external_symbols | 127 ++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100755 scripts/check_docs_external_symbols

diff --git a/scripts/check_docs_external_symbols b/scripts/check_docs_external_symbols
new file mode 100755
index 000000000000..cc12562e6cd6
--- /dev/null
+++ b/scripts/check_docs_external_symbols
@@ -0,0 +1,127 @@
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
+# The script is not perfect and may produce some false negatives, as
+# currently it doesn't handle Makefile "-I" directives that might be inside
+# a Kernel directory.
+#
+# So, use it with caution.
+#
+# Usage:
+#	scripts/check_external docs
+# or:
+#	scripts/check_external docs <files and/or directories>
+
+use warnings;
+use strict;
+use File::Find;
+
+sub check_file($) {
+	my $file = shift;
+	my (@files, @exports, @doc, @doc_refs);
+	my $content = "\n";
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
+			if (-e "include/$1") {
+				push @files, "include/$1";
+			} else {
+				# Currently, can't check if include is elsewhere
+				return 0;
+			}
+		}
+		if (m/^\s*#\s*include\s+[\"](\S+)[\"]/) {
+			if (-e "$dir/$1") {
+				push @files, "$dir/$1";
+			} else {
+				# Currently, can't check if include is elsewhere
+				return 0;
+			}
+		}
+		$content .= $_;
+	}
+	close IN;
+
+	return 0 if ($content eq "\n");
+
+
+	push @files, $file;
+	for (my $i = 0; $i < scalar(@files); $i++) {
+		$doc_refs[$i] = 0;
+		$doc[$i] = qx(./scripts/kernel-doc --sphinx-version 3.2.1 $files[$i] 2>/dev/null);
+	}
+
+	my @missing_exports;
+	my $found = -1;
+	foreach my $e (@exports) {
+		# Check if the symbol is a function
+		if (!($content =~ (m/\n\s*(?:\w+\s+){0,}\*?\s*\b\Q$e\E\b\s*\(/))) {
+			next;
+		}
+		for (my $i = 0; $i < scalar(@files); $i++) {
+			if ($doc[$i] =~ m/\b\Q$e\E\b/) {
+				$found = $i;
+				$doc_refs[$i]++;
+				last;
+			}
+		}
+
+		push @missing_exports, $e if ($found < 0);
+	}
+
+	if (@missing_exports) {
+		print "warning: $file: missing documentation for @missing_exports\n";
+	}
+
+	for (my $i = 0; $i < scalar(@files); $i++) {
+		next if (!$doc_refs[$i]);
+		my $includes = qx(git grep -l "kernel-doc::\\s*$files[$i]" Documentation/);
+
+		printf "warning: %s: file not included at Documentation/\n", $files[$i] if ($includes eq "");
+	}
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
+my $file;
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
+	foreach $file (@files) {
+		$file =~ s/\s+$//;
+		check_file $file;
+	}
+}
-- 
2.26.2

