Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD6E24A865
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 23:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHSVWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 17:22:15 -0400
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:51706 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbgHSVWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:22:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A7FFD2465;
        Wed, 19 Aug 2020 21:22:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3866:3867:3870:3871:3874:4321:5007:6119:7903:7974:8957:10004:10400:10848:11026:11473:11658:11914:12043:12297:12438:12555:12760:13069:13161:13229:13311:13357:13439:13846:14181:14394:14659:14721:21080:21221:21451:21627:21990:30054:30056:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: scene64_34169932702b
X-Filterd-Recvd-Size: 2308
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Aug 2020 21:22:11 +0000 (UTC)
Message-ID: <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>
Subject: [PATCH] checkpatch: Add test for comma use that should be semicolon
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>
Date:   Wed, 19 Aug 2020 14:22:10 -0700
In-Reply-To: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are commas used as statement terminations that should typically
have used semicolons instead.  Only direct assignments or use of a single
function or value on a single line are detected by this test.

e.g.:
	foo = bar(),		/* typical use is semicolon not comma */
	bar = baz();

Add an imperfect test to detect these comma uses.

No false positives were found in testing, but many types of false negatives
are possible.

e.g.:
	foo = bar() + 1,	/* comma use, but not direct assignment */
	bar = baz();

Signed-off-by: Joe Perches <joe@perches.com
---
 scripts/checkpatch.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl= 
index 60d4a79674b6..93b99809df07 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4936,6 +4936,17 @@ sub process {
 			}
 		}
 
+# check if a statement with a comma should be two statements like:
+#	foo = bar(),	/* comma should be semicolon */
+#	bar = baz();
+		if (defined($stat) &&
+		    $stat =~ /^\+\s*(?:$Lval\s*$Assignment\s*)?$FuncArg\s*,\s*(?:$Lval\s*$Assignment\s*)?$FuncArg\s*;\s*$/) {
+			my $cnt = statement_rawlines($stat);
+			my $herectx = get_stat_here($linenr, $cnt, $here);
+			WARN("SUSPECT_COMMA_SEMICOLON",
+			     "Possible comma where semicolon could be used\n" . $herectx);
+		}
+
 # return is not a function
 		if (defined($stat) && $stat =~ /^.\s*return(\s*)\(/s) {
 			my $spacing = $1;

