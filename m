Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC729CC28
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 23:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756532AbgJ0WpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 18:45:13 -0400
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:53578 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2900918AbgJ0WpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 18:45:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CA8CA1802926E;
        Tue, 27 Oct 2020 22:45:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3354:3653:3865:3866:3867:3868:3871:4321:4605:5007:7550:9010:9592:10004:10400:10848:11026:11473:11658:11914:12043:12297:12438:12555:12679:12683:12760:12986:13439:14181:14394:14659:14721:21080:21221:21433:21451:21627:30029:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: lake84_1d0d2cc2727f
X-Filterd-Recvd-Size: 4428
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 27 Oct 2020 22:45:09 +0000 (UTC)
Message-ID: <c04dd1c810e8d6a68e6a632e3191ae91651c8edf.camel@perches.com>
Subject: [PATCH -next] checkpatch: Update __attribute__((section("name")))
 quote removal
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 27 Oct 2020 15:45:08 -0700
In-Reply-To: <20201025193103.23223-1-dwaipayanray1@gmail.com>
References: <20201025193103.23223-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 33def8498fdd ("treewide: Convert macro and uses of
__section(foo) to __section("foo")") removed the stringification of the
section name and now requires quotes around the named section.

Update checkpatch to not remove any quotes when suggesting conversion
of __attribute__((section("name"))) to __section("name")

Miscellanea:

o Add section to the hash with __section replacement
o Remove separate test for __attribute__((section
o Remove the limitation on converting attributes containing only
  known, possible conversions.  Any unknown attribute types are now
  left as-is and known types are converted and moved before
  __attribute__ and removed from within the __attribute__((list...)).

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7800a090e8fe..a97f2ab11568 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6216,51 +6216,37 @@ sub process {
 				"noreturn"			=> "__noreturn",
 				"packed"			=> "__packed",
 				"pure"				=> "__pure",
+				"section"			=> "__section",
 				"used"				=> "__used"
 			);
 
-			my @conv_array = ();
-			my $conv_possible = 1;
-
 			while ($attr =~ /\s*(\w+)\s*(${balanced_parens})?/g) {
-				my $curr_attr = $1;
+				my $orig_attr = $1;
 				my $params = '';
 				$params = $2 if defined($2);
+				my $curr_attr = $orig_attr;
 				$curr_attr =~ s/^[\s_]+|[\s_]+$//g;
-
 				if (exists($attr_list{$curr_attr})) {
+					my $new = $attr_list{$curr_attr};
 					if ($curr_attr eq "format" && $params) {
 						$params =~ /^\s*\(\s*(\w+)\s*,\s*(.*)/;
-						push(@conv_array, "__$1\($2");
+						$new = "__$1\($2";
 					} else {
-						my $new = $attr_list{$curr_attr};
-						push(@conv_array, "$new$params");
+						$new = "$new$params";
+					}
+					if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+						 "Prefer $new over __attribute__(($orig_attr$params))\n" . $herecurr) &&
+					    $fix) {
+						my $remove = "\Q$orig_attr\E" . '\s*' . "\Q$params\E" . '(?:\s*,\s*)?';
+						$fixed[$fixlinenr] =~ s/$remove//;
+						$fixed[$fixlinenr] =~ s/\b__attribute__/$new __attribute__/;
+						$fixed[$fixlinenr] =~ s/\}\Q$new\E/} $new/;
 					}
-				} else {
-					$conv_possible = 0;
-					last;
-				}
-			}
-
-			if (scalar @conv_array > 0 && $conv_possible == 1) {
-				my $replace = join(' ', @conv_array);
-				if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
-				         "$replace is preferred over __attribute__(($attr))\n" . $herecurr) &&
-					$fix) {
-					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*\Q$attr\E\s*\)\s*\)/$replace/;
-					$fixed[$fixlinenr] =~ s/\}\Q$replace\E/} $replace/;
 				}
 			}
 
-			# Check for __attribute__ section, prefer __section
-			if ($attr =~ /^_*section_*\s*\(\s*("[^"]*")/) {
-				my $old = substr($attr, $-[1], $+[1] - $-[1]);
-				my $new = substr($old, 1, -1);
-				if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
-				         "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr) &&
-					$fix) {
-					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*section_*\s*\(\s*\Q$old\E\s*\)\s*\)\s*\)/__section($new)/;
-				}
+			if (show_type("PREFER_DEFINED_ATTRIBUTE_MACRO") && $fix) {
+				$fixed[$fixlinenr] =~ s/ __attribute__\s*\(\s*\(\s*\)\s*\)//;
 			}
 
 			# Check for __attribute__ unused, prefer __always_unused or __maybe_unused
 			

