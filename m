Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F82E2D3BFF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgLIHKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:10:20 -0500
Received: from smtprelay0129.hostedemail.com ([216.40.44.129]:35636 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725283AbgLIHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:10:20 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BEAAE182251A0;
        Wed,  9 Dec 2020 07:09:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 64,4,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2332:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3865:3866:3867:3868:3874:4321:5007:10004:10400:10848:11026:11473:11658:11914:12043:12296:12297:12555:12679:12760:13069:13255:13311:13357:13439:14181:14394:14659:14721:21080:21221:21433:21451:21627:21660:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: feast98_4a0d944273ed
X-Filterd-Recvd-Size: 2268
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Dec 2020 07:09:35 +0000 (UTC)
Message-ID: <993b72b2ef91a57c5e725b52971ce3fd31375061.camel@perches.com>
Subject: [PATCH] checkpatch: Add printk_once and printk_ratelimit to prefer
 pr_<level> warning
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Dec 2020 23:09:34 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the _once and _ratelimited variants to the test for
printk(KERN_<LEVEL> that should prefer pr_<level>.

Miscellanea:

o Add comment description for the conversions

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b086d1cd6c2..52f467fd32f9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4543,16 +4543,22 @@ sub process {
 			     "printk() should include KERN_<LEVEL> facility level\n" . $herecurr);
 		}
 
-		if ($line =~ /\bprintk\s*\(\s*KERN_([A-Z]+)/) {
-			my $orig = $1;
+# prefer variants of (subsystem|netdev|dev|pr)_<level> to printk(KERN_<LEVEL>
+		if ($line =~ /\b(printk(_once|_ratelimited)?)\s*\(\s*KERN_([A-Z]+)/) {
+			my $printk = $1;
+			my $modifier = $2;
+			my $orig = $3;
 			my $level = lc($orig);
 			$level = "warn" if ($level eq "warning");
 			my $level2 = $level;
 			$level2 = "dbg" if ($level eq "debug");
+			$level .= $modifier;
+			$level2 .= $modifier;
 			WARN("PREFER_PR_LEVEL",
-			     "Prefer [subsystem eg: netdev]_$level2([subsystem]dev, ... then dev_$level2(dev, ... then pr_$level(...  to printk(KERN_$orig ...\n" . $herecurr);
+			     "Prefer [subsystem eg: netdev]_$level2([subsystem]dev, ... then dev_$level2(dev, ... then pr_$level(...  to $printk(KERN_$orig ...\n" . $herecurr);
 		}
 
+# prefer dev_<level> to dev_printk(KERN_<LEVEL>
 		if ($line =~ /\bdev_printk\s*\(\s*KERN_([A-Z]+)/) {
 			my $orig = $1;
 			my $level = lc($orig);

