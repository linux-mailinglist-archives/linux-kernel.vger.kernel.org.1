Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E371C7968
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 20:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgEFSak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 14:30:40 -0400
Received: from smtprelay0056.hostedemail.com ([216.40.44.56]:40510 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729400AbgEFSak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:30:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C5A7C1004DD83;
        Wed,  6 May 2020 18:30:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3870:3872:3874:4321:4419:5007:6119:6691:7903:10004:10400:10848:11026:11658:11914:12043:12296:12297:12438:12555:12679:12760:12986:13069:13311:13357:13439:14181:14394:14659:14721:21080:21451:21627:30012:30054:30056,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: hen04_7a19eb4392937
X-Filterd-Recvd-Size: 1844
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 May 2020 18:30:38 +0000 (UTC)
Message-ID: <47372467902a047c03b0fd29aab56e0c38d3f848.camel@perches.com>
Subject: [PATCH] percpu_ref: Use a more common logging style
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date:   Wed, 06 May 2020 11:30:37 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the trailing newline from the used-once pr_fmt
and add it to the single use of pr_<level> in this code
to use a more common logging style.

Miscellanea:

o Use %lu in the pr_debug format and remove the unnecessary cast

Signed-off-by: Joe Perches <joe@perches.com>
---
 lib/percpu-refcount.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 8d092609928e..0ba686b8fe57 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define pr_fmt(fmt) "%s: " fmt "\n", __func__
+#define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -141,8 +141,8 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 	for_each_possible_cpu(cpu)
 		count += *per_cpu_ptr(percpu_count, cpu);
 
-	pr_debug("global %ld percpu %ld",
-		 atomic_long_read(&ref->count), (long)count);
+	pr_debug("global %lu percpu %lu\n",
+		 atomic_long_read(&ref->count), count);
 
 	/*
 	 * It's crucial that we sum the percpu counters _before_ adding the sum


