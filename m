Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC802A224F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 00:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgKAXLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 18:11:07 -0500
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:51218 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727309AbgKAXLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 18:11:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 7DC9A182CED34;
        Sun,  1 Nov 2020 23:11:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2304:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3867:3868:4321:5007:10004:10400:10848:11232:11658:11914:12043:12297:12555:12760:12986:13069:13255:13311:13357:13439:14181:14394:14659:14721:21080:21220:21221:21433:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: ocean01_0d17f88272ab
X-Filterd-Recvd-Size: 1740
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Nov 2020 23:11:05 +0000 (UTC)
Message-ID: <7b74137743c58ce0633ec4d575b94e2210e4dbe7.camel@perches.com>
Subject: [PATCH] checkpatch: Add __alias and __weak to suggested
 __attribute__ conversions
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 01 Nov 2020 15:11:04 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __alias and __weak to the suggested __attribute__((<foo>)) conversions.

Signed-off-by: Joe Perches <joe@perches.com>
---
This depends on the patch to remove stringification from the __alias macro.

 scripts/checkpatch.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 58095d9d8f34..2438a22b0255 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6197,6 +6197,7 @@ sub process {
 			$attr =~ s/\s*\(\s*(.*)\)\s*/$1/;
 
 			my %attr_list = (
+				"alias"				=> "__alias",
 				"aligned"			=> "__aligned",
 				"always_inline"			=> "__always_inline",
 				"assume_aligned"		=> "__assume_aligned",
@@ -6217,7 +6218,8 @@ sub process {
 				"packed"			=> "__packed",
 				"pure"				=> "__pure",
 				"section"			=> "__section",
-				"used"				=> "__used"
+				"used"				=> "__used",
+				"weak"				=> "__weak"
 			);
 
 			while ($attr =~ /\s*(\w+)\s*(${balanced_parens})?/g) {


