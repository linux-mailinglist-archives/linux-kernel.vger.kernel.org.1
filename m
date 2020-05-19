Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351BC1D9DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 19:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgESR3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 13:29:05 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:39444 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729185AbgESR3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:29:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8BFFE182244E8;
        Tue, 19 May 2020 17:29:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3870:3871:3874:4321:5007:9592:10004:10400:10848:11026:11473:11658:11914:12043:12114:12296:12297:12438:12555:12760:12986:13019:13069:13255:13311:13357:13439:14181:14394:14659:14721:21080:21627:21990:30012:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bite97_2b148ed26d0e
X-Filterd-Recvd-Size: 1920
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 May 2020 17:29:03 +0000 (UTC)
Message-ID: <b10a31d999addb474530afaca7b2d4929a8da474.camel@perches.com>
Subject: [PATCH] lockdep: Use different indentation in
 print_lock_class_header/print_lock_trace
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Date:   Tue, 19 May 2020 10:29:02 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code that uses the printk return value in
kernel/locking/lockdep.c is odd because the printk
return value includes both the length of a KERN_<LEVEL>
prefix and a newline.  depth is also double counted.

Change the code to calculate depth + 3 + strlen.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/locking/lockdep.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2fadc2635946..265227edc550 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1960,11 +1960,9 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
 		if (class->usage_mask & (1 << bit)) {
-			int len = depth;
-
-			len += printk("%*s   %s", depth, "", usage_str[bit]);
-			len += printk(KERN_CONT " at:\n");
-			print_lock_trace(class->usage_traces[bit], len);
+			printk("%*s   %s at:\n", depth, "", usage_str[bit]);
+			print_lock_trace(class->usage_traces[bit],
+					 depth + 3 + strlen(usage_str[bit]);
 		}
 	}
 	printk("%*s }\n", depth, "");



