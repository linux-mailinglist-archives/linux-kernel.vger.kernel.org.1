Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB52A249256
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 03:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgHSB3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 21:29:52 -0400
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:39870 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbgHSB3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 21:29:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 55053180A7FF6;
        Wed, 19 Aug 2020 01:29:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3355:3653:3865:3867:3868:3870:3872:4321:4823:5007:7903:9592:10004:10400:10848:11026:11658:11914:12043:12291:12297:12555:12683:12760:13439:14110:14181:14394:14659:14721:21080:21221:21451:21627:21740:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cough36_1c065ba27024
X-Filterd-Recvd-Size: 3569
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Aug 2020 01:29:49 +0000 (UTC)
Message-ID: <180b3b5677771c902b2e2f7a2b7090ede65fe004.camel@perches.com>
Subject: [PATCH] checkpatch: Move repeated word test
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 18 Aug 2020 18:29:48 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently this test only works on .[ch] files.

Move the test to check more file types and the commit log.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 72 +++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4aa1d9d5e62c..f4819a339a68 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2989,6 +2989,42 @@ sub process {
 			}
 		}
 
+# check for repeated words separated by a single space
+		if ($rawline =~ /^\+/ || $in_commit_log) {
+			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
+
+				my $first = $1;
+				my $second = $2;
+
+				if ($first =~ /(?:struct|union|enum)/) {
+					pos($rawline) += length($first) + length($second) + 1;
+					next;
+				}
+
+				next if ($first ne $second);
+				next if ($first eq 'long');
+
+				if (WARN("REPEATED_WORD",
+					 "Possible repeated word: '$first'\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/\b$first $second\b/$first/;
+				}
+			}
+
+			# if it's a repeated word on consecutive lines in a comment block
+			if ($prevline =~ /$;+\s*$/ &&
+			    $prevrawline =~ /($word_pattern)\s*$/) {
+				my $last_word = $1;
+				if ($rawline =~ /^\+\s*\*\s*$last_word /) {
+					if (WARN("REPEATED_WORD",
+						 "Possible repeated word: '$last_word'\n" . $hereprev) &&
+					    $fix) {
+						$fixed[$fixlinenr] =~ s/(\+\s*\*\s*)$last_word /$1/;
+					}
+				}
+			}
+		}
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
@@ -3312,42 +3348,6 @@ sub process {
 			}
 		}
 
-# check for repeated words separated by a single space
-		if ($rawline =~ /^\+/) {
-			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
-
-				my $first = $1;
-				my $second = $2;
-
-				if ($first =~ /(?:struct|union|enum)/) {
-					pos($rawline) += length($first) + length($second) + 1;
-					next;
-				}
-
-				next if ($first ne $second);
-				next if ($first eq 'long');
-
-				if (WARN("REPEATED_WORD",
-					 "Possible repeated word: '$first'\n" . $herecurr) &&
-				    $fix) {
-					$fixed[$fixlinenr] =~ s/\b$first $second\b/$first/;
-				}
-			}
-
-			# if it's a repeated word on consecutive lines in a comment block
-			if ($prevline =~ /$;+\s*$/ &&
-			    $prevrawline =~ /($word_pattern)\s*$/) {
-				my $last_word = $1;
-				if ($rawline =~ /^\+\s*\*\s*$last_word /) {
-					if (WARN("REPEATED_WORD",
-						 "Possible repeated word: '$last_word'\n" . $hereprev) &&
-					    $fix) {
-						$fixed[$fixlinenr] =~ s/(\+\s*\*\s*)$last_word /$1/;
-					}
-				}
-			}
-		}
-
 # check for space before tabs.
 		if ($rawline =~ /^\+/ && $rawline =~ / \t/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";


