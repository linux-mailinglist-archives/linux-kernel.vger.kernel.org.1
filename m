Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2403E22E6A2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 09:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgG0Hdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 03:33:46 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:52432 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgG0Hdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:33:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DDE75180A8134;
        Mon, 27 Jul 2020 07:33:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3653:3865:3866:3867:3868:3870:3871:3872:4321:4823:5007:6119:7903:10010:10400:10848:11026:11658:11914:12043:12291:12295:12297:12438:12555:12683:12760:13439:14181:14394:14659:14721:21080:21221:21451:21627:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: toe01_580981926f5f
X-Filterd-Recvd-Size: 3330
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Jul 2020 07:33:43 +0000 (UTC)
Message-ID: <cda9b566ad67976e1acd62b053de50ee44a57250.camel@perches.com>
Subject: [PATCH] checkpatch: Add test for repeated words
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Jul 2020 00:33:42 -0700
In-Reply-To: <16aa5f86f2f899a9156305ead4b7042449278eea.camel@perches.com>
References: <20200726162902.Horde.TCqHYaODbkzEpM-rFzDd8A2@messagerie.si.c-s.fr>
         <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
         <add7c13b1ca24c8cb6f243b99d61c19287020efd.camel@perches.com>
         <4e505c35-8428-89bb-7f9b-bc819382c3cd@infradead.org>
         <16aa5f86f2f899a9156305ead4b7042449278eea.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to avoid adding repeated words either on the
same line or consecutive comment lines in a block

e.g.:

duplicated word in comment block

	/*
	 * this is a comment block where the last word of the previous
	 * previous line is also the first word of the next line
	 */

and simple duplication

	/* test this this again */

Inspired-by: Randy Dunlap (rdunlap@infradead.org>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e9fde28eb0de..c6ef76b72bf3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -591,6 +591,8 @@ our @mode_permission_funcs = (
 	["__ATTR", 2],
 );
 
+my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';
+
 #Create a search pattern for all these functions to speed up a loop below
 our $mode_perms_search = "";
 foreach my $entry (@mode_permission_funcs) {
@@ -3340,6 +3342,42 @@ sub process {
 			}
 		}
 
+# check for repeated words separated by a single space
+		if ($rawline =~ /^\+/) {
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
 # check for space before tabs.
 		if ($rawline =~ /^\+/ && $rawline =~ / \t/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";


