Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC72A2E8641
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 05:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbhABENO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 23:13:14 -0500
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:59818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727171AbhABENO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 23:13:14 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 79BF61802926E;
        Sat,  2 Jan 2021 04:12:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:800:960:968:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:2194:2197:2199:2200:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3653:3865:3866:3867:3868:3870:3871:4321:4605:5007:7652:7903:8957:10004:10848:11026:11658:11914:12043:12291:12297:12346:12438:12555:12679:12683:12760:12986:13181:13229:13439:14181:14394:14659:14721:21080:21221:21433:21451:21627:21939:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: home30_0c137cb274bc
X-Filterd-Recvd-Size: 5339
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 Jan 2021 04:12:31 +0000 (UTC)
Message-ID: <9015fd00742bf4e5b824ad6d7fd7189530958548.camel@perches.com>
Subject: [PATCH] checkpatch: Improve blank line after declaration test
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 01 Jan 2021 20:12:30 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid multiple false positives by ignoring attributes.

Various attributes like volatile and ____cacheline_aligned_in_smp cause
checkpatch to emit invalid "Missing a blank line after declarations"
messages.

Use copies of $sline and $prevline, remove $Attribute and $Sparse, and
use the existing tests to avoid these false positives.

Miscellanea:

o Add volatile to $Attribute

This also reduces checkpatch runtime a bit by moving the indentation
comparison test to the start of the block to avoid multiple unnecessary
regex tests.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 52 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 00085308ed9d..cfa0a7393ef5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -382,6 +382,7 @@ our $InitAttribute = qr{$InitAttributeData|$InitAttributeConst|$InitAttributeIni
 # We need \b after 'init' otherwise 'initconst' will cause a false positive in a check
 our $Attribute	= qr{
 			const|
+			volatile|
 			__percpu|
 			__nocast|
 			__safe|
@@ -3783,43 +3784,48 @@ sub process {
 		}
 
 # check for missing blank lines after declarations
-		if ($sline =~ /^\+\s+\S/ &&			#Not at char 1
-			# actual declarations
-		    ($prevline =~ /^\+\s+$Declare\s*$Ident\s*[=,;:\[]/ ||
+# (declarations must have the same indentation and not be at the start of line)
+		if (($prevline =~ /\+(\s+)\S/) && $sline =~ /^\+$1\S/) {
+			# use temporaries
+			my $sl = $sline;
+			my $pl = $prevline;
+			# remove $Attribute/$Sparse uses to simplify comparisons
+			$sl =~ s/\b(?:$Attribute|$Sparse)\b//g;
+			$pl =~ s/\b(?:$Attribute|$Sparse)\b//g;
+			if (($pl =~ /^\+\s+$Declare\s*$Ident\s*[=,;:\[]/ ||
 			# function pointer declarations
-		     $prevline =~ /^\+\s+$Declare\s*\(\s*\*\s*$Ident\s*\)\s*[=,;:\[\(]/ ||
+			     $pl =~ /^\+\s+$Declare\s*\(\s*\*\s*$Ident\s*\)\s*[=,;:\[\(]/ ||
 			# foo bar; where foo is some local typedef or #define
-		     $prevline =~ /^\+\s+$Ident(?:\s+|\s*\*\s*)$Ident\s*[=,;\[]/ ||
+			     $pl =~ /^\+\s+$Ident(?:\s+|\s*\*\s*)$Ident\s*[=,;\[]/ ||
 			# known declaration macros
-		     $prevline =~ /^\+\s+$declaration_macros/) &&
+			     $pl =~ /^\+\s+$declaration_macros/) &&
 			# for "else if" which can look like "$Ident $Ident"
-		    !($prevline =~ /^\+\s+$c90_Keywords\b/ ||
+			    !($pl =~ /^\+\s+$c90_Keywords\b/ ||
 			# other possible extensions of declaration lines
-		      $prevline =~ /(?:$Compare|$Assignment|$Operators)\s*$/ ||
+			      $pl =~ /(?:$Compare|$Assignment|$Operators)\s*$/ ||
 			# not starting a section or a macro "\" extended line
-		      $prevline =~ /(?:\{\s*|\\)$/) &&
+			      $pl =~ /(?:\{\s*|\\)$/) &&
 			# looks like a declaration
-		    !($sline =~ /^\+\s+$Declare\s*$Ident\s*[=,;:\[]/ ||
+			    !($sl =~ /^\+\s+$Declare\s*$Ident\s*[=,;:\[]/ ||
 			# function pointer declarations
-		      $sline =~ /^\+\s+$Declare\s*\(\s*\*\s*$Ident\s*\)\s*[=,;:\[\(]/ ||
+			      $sl =~ /^\+\s+$Declare\s*\(\s*\*\s*$Ident\s*\)\s*[=,;:\[\(]/ ||
 			# foo bar; where foo is some local typedef or #define
-		      $sline =~ /^\+\s+$Ident(?:\s+|\s*\*\s*)$Ident\s*[=,;\[]/ ||
+			      $sl =~ /^\+\s+$Ident(?:\s+|\s*\*\s*)$Ident\s*[=,;\[]/ ||
 			# known declaration macros
-		      $sline =~ /^\+\s+$declaration_macros/ ||
+			      $sl =~ /^\+\s+$declaration_macros/ ||
 			# start of struct or union or enum
-		      $sline =~ /^\+\s+(?:static\s+)?(?:const\s+)?(?:union|struct|enum|typedef)\b/ ||
+			      $sl =~ /^\+\s+(?:static\s+)?(?:const\s+)?(?:union|struct|enum|typedef)\b/ ||
 			# start or end of block or continuation of declaration
-		      $sline =~ /^\+\s+(?:$|[\{\}\.\#\"\?\:\(\[])/ ||
+			      $sl =~ /^\+\s+(?:$|[\{\}\.\#\"\?\:\(\[])/ ||
 			# bitfield continuation
-		      $sline =~ /^\+\s+$Ident\s*:\s*\d+\s*[,;]/ ||
+			      $sl =~ /^\+\s+$Ident\s*:\s*\d+\s*[,;]/ ||
 			# other possible extensions of declaration lines
-		      $sline =~ /^\+\s+\(?\s*(?:$Compare|$Assignment|$Operators)/) &&
-			# indentation of previous and current line are the same
-		    (($prevline =~ /\+(\s+)\S/) && $sline =~ /^\+$1\S/)) {
-			if (WARN("LINE_SPACING",
-				 "Missing a blank line after declarations\n" . $hereprev) &&
-			    $fix) {
-				fix_insert_line($fixlinenr, "\+");
+			      $sl =~ /^\+\s+\(?\s*(?:$Compare|$Assignment|$Operators)/)) {
+				if (WARN("LINE_SPACING",
+					 "Missing a blank line after declarations\n" . $hereprev) &&
+				    $fix) {
+					fix_insert_line($fixlinenr, "\+");
+				}
 			}
 		}
 


