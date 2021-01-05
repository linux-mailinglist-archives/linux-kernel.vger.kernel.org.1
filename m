Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D223E2EA7B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbhAEJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbhAEJf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:35:59 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F165C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:35:19 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id e2so20940603pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FHnsJ2/xITTt6sic8bwwoBbm+GiOwrvEjflQ9FMtb1o=;
        b=EW4JZxJgPFDnrNPi7lPMc1a5+COO33auZZIJF/qQWFyGvY0oEwqgymUDSnuq0mlBd0
         hdEi7zVUH525KSSid8Jb5L7a3Gu+3oIQirKXGCYTEXMIftfT6WoX+i8uFK/yKCHh2rol
         pgjiWNOlWkjoDSiPOHc96Lp/unl30X5GdvyqJzWZCOSgzixxWbVNnc1gKpHrFJkJ9hai
         gBsZcLu7lvh9oYm+jQEjcWkCDOFUAtv72TRRRYVPCcxdqQtjZ4xoPwh087k7jVB57ZlZ
         1EiHDAg222W/OEvz8LGVN9nKT9PcvLoscFNW9yL9Lrgzw71ecw+6Nb5YrwPwvjM1KT+8
         3Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FHnsJ2/xITTt6sic8bwwoBbm+GiOwrvEjflQ9FMtb1o=;
        b=rr/qnNHsT/BEi6l/SWUM5kUBrRRMNQq5JBLo5RpBzNC9T9wqIz2QskMe54rC/GBaL+
         Q8ilBz3ZUQ8rEcehO2qNqu5hOI8QevzPNFp9GNlRtyqBz1AQHL3/YNui5oXBUuGbsWE6
         ShzTeMxsoSUnCJ5XmlddfM49Wf9ihHhmM8HEn/2xRv4nCXlBIZLT+wW1o4E6RMngKWqV
         ltZK1TQ1C8MLWq+qWauNQnOeoJG06jfdZEsSblV7Oh9nHY0//kgZjuHC/TDW41KShd82
         NWWdH3Oc4sT098S7ErRzFO+DGxwpYWvrQq0aWG/T1UMs8BtyNrknvGO2aq/2B9BIGVc0
         6ZDg==
X-Gm-Message-State: AOAM532ZjyDAJieND4mdCZNkny7jvP+rHlSGxvrUvqVzvU/aJRidtN9u
        fcVYYCxs6yUKjeiLiaoNbig=
X-Google-Smtp-Source: ABdhPJyCFI3V9aXREpRbFkFctRoQnd+xPdrHiBPJ1EBZy6DNAVljDbmNMXgd1+GuQ7hC7tkxNBBUTw==
X-Received: by 2002:a05:6a00:44:b029:19d:e250:1355 with SMTP id i4-20020a056a000044b029019de2501355mr68344811pfk.36.1609839318975;
        Tue, 05 Jan 2021 01:35:18 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6064:97d:44da:5ae4:7c76])
        by smtp.gmail.com with ESMTPSA id s13sm59347761pfd.99.2021.01.05.01.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:35:18 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     dwaipayanray1@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: fix unescaped left braces
Date:   Tue,  5 Jan 2021 15:05:07 +0530
Message-Id: <20210105093507.29297-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perl 5.22 onwards require that "A literal "{" should now be
escaped in a pattern".

checkpatch contains several literal "{". Fix such instances
by preceding them with a backslash.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 00085308ed9d..8e80a158bf5a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1652,7 +1652,7 @@ sub statement_block_size {
 	my ($stmt) = @_;
 
 	$stmt =~ s/(^|\n)./$1/g;
-	$stmt =~ s/^\s*{//;
+	$stmt =~ s/^\s*\{//;
 	$stmt =~ s/}\s*$//;
 	$stmt =~ s/^\s*//;
 	$stmt =~ s/\s*$//;
@@ -2036,7 +2036,7 @@ sub annotate_values {
 			print "ASSIGN($1)\n" if ($dbg_values > 1);
 			$type = 'N';
 
-		} elsif ($cur =~/^(;|{|})/) {
+		} elsif ($cur =~ /^(;|\{|\})/) {
 			print "END($1)\n" if ($dbg_values > 1);
 			$type = 'E';
 			$av_pend_colon = 'O';
@@ -3913,7 +3913,7 @@ sub process {
 			# it there is no point in retrying a statement scan
 			# until we hit end of it.
 			my $frag = $stat; $frag =~ s/;+\s*$//;
-			if ($frag !~ /(?:{|;)/) {
+			if ($frag !~ /(?:\{|;)/) {
 #print "skip<$line_nr_next>\n";
 				$suppress_statement = $line_nr_next;
 			}
@@ -4029,7 +4029,7 @@ sub process {
 			#print "realcnt<$realcnt> ctx_cnt<$ctx_cnt>\n";
 			#print "pre<$pre_ctx>\nline<$line>\nctx<$ctx>\nnext<$lines[$ctx_ln - 1]>\n";
 
-			if ($ctx !~ /{\s*/ && defined($lines[$ctx_ln - 1]) && $lines[$ctx_ln - 1] =~ /^\+\s*{/) {
+			if ($ctx !~ /\{\s*/ && defined($lines[$ctx_ln - 1]) && $lines[$ctx_ln - 1] =~ /^\+\s*\{/) {
 				ERROR("OPEN_BRACE",
 				      "that open brace { should be on the previous line\n" .
 					"$here\n$ctx\n$rawlines[$ctx_ln - 1]\n");
@@ -4080,7 +4080,7 @@ sub process {
 			my $continuation = 0;
 			my $check = 0;
 			$s =~ s/^.*\bdo\b//;
-			$s =~ s/^\s*{//;
+			$s =~ s/^\s*\{//;
 			if ($s =~ s/^\s*\\//) {
 				$continuation = 1;
 			}
@@ -4235,7 +4235,7 @@ sub process {
 		}
 
 # check for initialisation to aggregates open brace on the next line
-		if ($line =~ /^.\s*{/ &&
+		if ($line =~ /^.\s*\{/ &&
 		    $prevline =~ /(?:^|[^=])=\s*$/) {
 			if (ERROR("OPEN_BRACE",
 				  "that open brace { should be on the previous line\n" . $hereprev) &&
@@ -4243,7 +4243,7 @@ sub process {
 				fix_delete_line($fixlinenr - 1, $prevrawline);
 				fix_delete_line($fixlinenr, $rawline);
 				my $fixedline = $prevrawline;
-				$fixedline =~ s/\s*=\s*$/ = {/;
+				$fixedline =~ s/\s*=\s*$/ = \{/;
 				fix_insert_line($fixlinenr, $fixedline);
 				$fixedline = $line;
 				$fixedline =~ s/^(.\s*)\{\s*/$1/;
@@ -4617,7 +4617,7 @@ sub process {
 		}
 
 # open braces for enum, union and struct go on the same line.
-		if ($line =~ /^.\s*{/ &&
+		if ($line =~ /^.\s*\{/ &&
 		    $prevline =~ /^.\s*(?:typedef\s+)?(enum|union|struct)(?:\s+$Ident)?\s*$/) {
 			if (ERROR("OPEN_BRACE",
 				  "open brace '{' following $1 go on the same line\n" . $hereprev) &&
@@ -5345,7 +5345,7 @@ sub process {
 
 # Check for illegal assignment in if conditional -- and check for trailing
 # statements after the conditional.
-		if ($line =~ /do\s*(?!{)/) {
+		if ($line =~ /do\s*(?!\{)/) {
 			($stat, $cond, $line_nr_next, $remain_next, $off_next) =
 				ctx_statement_block($linenr, $realcnt, 0)
 					if (!defined $stat);
@@ -5403,7 +5403,7 @@ sub process {
 			substr($s, 0, length($c), '');
 			$s =~ s/\n.*//g;
 			$s =~ s/$;//g;	# Remove any comments
-			if (length($c) && $s !~ /^\s*{?\s*\\*\s*$/ &&
+			if (length($c) && $s !~ /^\s*\{?\s*\\*\s*$/ &&
 			    $c !~ /}\s*while\s*/)
 			{
 				# Find out how long the conditional actually is.
@@ -5442,7 +5442,7 @@ sub process {
 		if ($line =~ /^.\s*(?:}\s*)?else\b(.*)/) {
 			my $s = $1;
 			$s =~ s/$;//g;	# Remove any comments
-			if ($s !~ /^\s*(?:\sif|(?:{|)\s*\\?\s*$)/) {
+			if ($s !~ /^\s*(?:\sif|(?:\{|)\s*\\?\s*$)/) {
 				ERROR("TRAILING_STATEMENTS",
 				      "trailing statements should be on next line\n" . $herecurr);
 			}
@@ -5659,7 +5659,7 @@ sub process {
 			    $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&		# while (...) {...}
 			    $dstat !~ /^for\s*$Constant$/ &&				# for (...)
 			    $dstat !~ /^for\s*$Constant\s+(?:$Ident|-?$Constant)$/ &&	# for (...) bar()
-			    $dstat !~ /^do\s*{/ &&					# do {...
+			    $dstat !~ /^do\s*\{/ &&					# do {...
 			    $dstat !~ /^\(\{/ &&						# ({...
 			    $ctx !~ /^.\s*#\s*define\s+TRACE_(?:SYSTEM|INCLUDE_FILE|INCLUDE_PATH)\b/)
 			{
@@ -5811,7 +5811,7 @@ sub process {
 
 					substr($block, 0, length($cond), '');
 
-					$seen++ if ($block =~ /^\s*{/);
+					$seen++ if ($block =~ /^\s*\{/);
 
 					#print "cond<$cond> block<$block> allowed<$allowed[$allow]>\n";
 					if (statement_lines($cond) > 1) {
@@ -5909,7 +5909,7 @@ sub process {
 				fix_delete_line($fixlinenr - 1, $prevrawline);
 			}
 		}
-		if (($rawline =~ /^.\s*$/ && $prevline =~ /^..*{\s*$/)) {
+		if (($rawline =~ /^.\s*$/ && $prevline =~ /^..*\{\s*$/)) {
 			if (CHK("BRACES",
 				"Blank lines aren't necessary after an open brace '{'\n" . $hereprev) &&
 			    $fix) {
-- 
2.27.0

