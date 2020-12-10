Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4012D5545
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387914AbgLJIXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730907AbgLJIXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:23:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8AEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 00:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=U7IBxiRR4OGdd4exeE6AXXhO3TRX5E0P/jz8fPB8Cq4=; b=ZDZSb9gRyPI42yC71dvOy0MXHl
        DWJI0vmu1HJf8xoU7vwaab5zWmWDAT0fiHvwuhw9a8CrnBa+eep9peXpfALPuLWVCsmHcPm25Cgcq
        6YMFlhTosk5BaNNQenVX/zZChq79T7hlkeoghY1pCUR0s99/aPRBNk2iICvJpb2dQOffbBW4D+CpO
        AP6FBIUAbFLjZxubhIAG5ZYy1UnXpLQY5Qpyj/tcVxJ1GNAAsutHDjZpC6YsrHgYTF81Ny5aBAUAS
        s082H1s1Xjfk645c2vRuMnPSlszWHfVqZLMMW3/ecgropCMXCFtoZULbIIbgNZi2FeIjNd8CSoLsG
        bF9TEqJA==;
Received: from [2001:4bb8:199:f14c:a24a:d231:8d9c:a947] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knHDw-00046Q-Qz; Thu, 10 Dec 2020 08:22:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: make the line length warnings match the coding style document
Date:   Thu, 10 Dec 2020 09:22:51 +0100
Message-Id: <20201210082251.2717564-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new informational message that lines <= 80 chars are still
preffered.  Without this people unfortunately auto format code way over
80 lines without the required benefit for readability.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 scripts/checkpatch.pl | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef79..d937889a5fe3b2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -54,6 +54,7 @@ my @ignore = ();
 my $help = 0;
 my $configuration_file = ".checkpatch.conf";
 my $max_line_length = 100;
+my $preferred_line_length = 80;
 my $ignore_perl_version = 0;
 my $minimum_perl_version = 5.10.0;
 my $min_conf_desc_length = 4;
@@ -2228,6 +2229,16 @@ sub WARN {
 	}
 	return 0;
 }
+sub INFO {
+	my ($type, $msg) = @_;
+
+	if (report("INFO", $type, $msg)) {
+		our $clean = 0;
+		our $cnt_info++;
+		return 1;
+	}
+	return 0;
+}
 sub CHK {
 	my ($type, $msg) = @_;
 
@@ -2396,6 +2407,7 @@ sub process {
 	our $cnt_lines = 0;
 	our $cnt_error = 0;
 	our $cnt_warn = 0;
+	our $cnt_info = 0;
 	our $cnt_chk = 0;
 
 	# Trace the real file/line as we go.
@@ -3343,15 +3355,15 @@ sub process {
 # if LONG_LINE is ignored, the other 2 types are also ignored
 #
 
-		if ($line =~ /^\+/ && $length > $max_line_length) {
+		if ($line =~ /^\+/ && $length > $preferred_line_length) {
 			my $msg_type = "LONG_LINE";
 
 			# Check the allowed long line types first
 
 			# logging functions that end in a string that starts
-			# before $max_line_length
+			# before $preferred_line_length
 			if ($line =~ /^\+\s*$logFunctions\s*\(\s*(?:(?:KERN_\S+\s*|[^"]*))?($String\s*(?:|,|\)\s*;)\s*)$/ &&
-			    length(expand_tabs(substr($line, 1, length($line) - length($1) - 1))) <= $max_line_length) {
+			    length(expand_tabs(substr($line, 1, length($line) - length($1) - 1))) <= $preferred_line_length) {
 				$msg_type = "";
 
 			# lines with only strings (w/ possible termination)
@@ -3371,23 +3383,30 @@ sub process {
 
 			# Otherwise set the alternate message types
 
-			# a comment starts before $max_line_length
+			# a comment starts before $preferred_line_length
 			} elsif ($line =~ /($;[\s$;]*)$/ &&
-				 length(expand_tabs(substr($line, 1, length($line) - length($1) - 1))) <= $max_line_length) {
+				 length(expand_tabs(substr($line, 1, length($line) - length($1) - 1))) <= $preferred_line_length) {
 				$msg_type = "LONG_LINE_COMMENT"
 
-			# a quoted string starts before $max_line_length
+			# a quoted string starts before $preferred_line_length
 			} elsif ($sline =~ /\s*($String(?:\s*(?:\\|,\s*|\)\s*;\s*))?)$/ &&
-				 length(expand_tabs(substr($line, 1, length($line) - length($1) - 1))) <= $max_line_length) {
+				 length(expand_tabs(substr($line, 1, length($line) - length($1) - 1))) <= $preferred_line_length) {
 				$msg_type = "LONG_LINE_STRING"
 			}
 
 			if ($msg_type ne "" &&
 			    (show_type("LONG_LINE") || show_type($msg_type))) {
-				my $msg_level = \&WARN;
-				$msg_level = \&CHK if ($file);
-				&{$msg_level}($msg_type,
+				my $msg_level = \&CHK;
+		
+				if ($line =~ /^\+/ && $length <= $max_line_length) {
+					$msg_level = \&INFO if (!$file);
+					&{$msg_level}($msg_type,
+					      "line length of $length exceeds preferred $preferred_line_length columns\n" . $herecurr);
+				} else {
+					$msg_level = \&WARN if (!$file);
+					&{$msg_level}($msg_type,
 					      "line length of $length exceeds $max_line_length columns\n" . $herecurr);
+				}
 			}
 		}
 
@@ -7015,7 +7034,7 @@ sub process {
 	print report_dump();
 	if ($summary && !($clean == 1 && $quiet == 1)) {
 		print "$filename " if ($summary_file);
-		print "total: $cnt_error errors, $cnt_warn warnings, " .
+		print "total: $cnt_error errors, $cnt_warn warnings, $cnt_info informational, " .
 			(($check)? "$cnt_chk checks, " : "") .
 			"$cnt_lines lines checked\n";
 	}
-- 
2.29.2

