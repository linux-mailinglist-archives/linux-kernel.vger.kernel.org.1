Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5572422D17C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 23:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGXVu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 17:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgGXVu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:50:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6164FC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pFeSSRA5u1az6E7WTbHybcN3CYCMxazk3RAH/wUsdMc=; b=DWx4g6Ysp9ssJWP1FM4g/aYQY2
        RByyxwo/nNWkv6CvAHLKmLhCGoasKtqZJ06VCXt/dwC16HUTPNZB3g0lFfVi7AIrvDmsSQMTgrE0q
        k5zfJowV4TtKvRPtL9OAQhzHE+YxeZlL2dXf3Jx5eyUlQGny9PuCw+3iIcjFjmMF0NT47kr1R2K5g
        MxaC1JwAcVJlNHLGB5LdliM3ivTDLXAhjUOIHIHzUoS+xpLec72GCf2epBhm9PPGZ+X0UV92lbO8c
        tGYH3BUe33j627c7HSMPcUG/Yf4GyHFfBzz85q5ysf+wNraH7J8TD/QKhj9e/l/jvhQflg44RX4Gk
        fDQDYMCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jz5Zu-0003BA-QQ; Fri, 24 Jul 2020 21:50:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 337BC300446;
        Fri, 24 Jul 2020 23:50:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14D6729CB6A31; Fri, 24 Jul 2020 23:50:03 +0200 (CEST)
Date:   Fri, 24 Jul 2020 23:50:03 +0200
From:   peterz@infradead.org
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, sfr@canb.auug.org.au
Subject: [PATCH v2] sched,tracing: Convert to sched_set_fifo()
Message-ID: <20200724215003.GY119549@hirez.programming.kicks-ass.net>
References: <202006192249.AYnVBGCH%lkp@intel.com>
 <20200709124505.GT597537@hirez.programming.kicks-ass.net>
 <20200709115818.36a956a4@oasis.local.home>
 <20200720214918.GM5523@worktop.programming.kicks-ass.net>
 <20200724213911.GX119549@hirez.programming.kicks-ass.net>
 <20200724174618.7487ee7c@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724174618.7487ee7c@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Subject: sched,tracing: Convert to sched_set_fifo()
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 20 Jul 2020 23:49:18 +0200

One module user of sched_setscheduler() was overlooked and is
obviously causing build failures.

Convert ring_buffer_benchmark to use sched_set_fifo_low() when fifo==1
and sched_set_fifo() when fifo==2. This is a bit of an abuse, but it
makes the thing 'work' again.

Specifically, it enables all combinations that were previously
possible:

  producer higher than consumer
  consumer higher than producer

Fixes: 616d91b68cd5 ("sched: Remove sched_setscheduler*() EXPORTs")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/trace/ring_buffer_benchmark.c |   48 ++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -45,8 +45,8 @@ MODULE_PARM_DESC(write_iteration, "# of
 static int producer_nice = MAX_NICE;
 static int consumer_nice = MAX_NICE;
 
-static int producer_fifo = -1;
-static int consumer_fifo = -1;
+static int producer_fifo;
+static int consumer_fifo;
 
 module_param(producer_nice, int, 0644);
 MODULE_PARM_DESC(producer_nice, "nice prio for producer");
@@ -55,10 +55,10 @@ module_param(consumer_nice, int, 0644);
 MODULE_PARM_DESC(consumer_nice, "nice prio for consumer");
 
 module_param(producer_fifo, int, 0644);
-MODULE_PARM_DESC(producer_fifo, "fifo prio for producer");
+MODULE_PARM_DESC(producer_fifo, "use fifo for producer: 0 - disabled, 1 - low prio, 2 - fifo");
 
 module_param(consumer_fifo, int, 0644);
-MODULE_PARM_DESC(consumer_fifo, "fifo prio for consumer");
+MODULE_PARM_DESC(consumer_fifo, "use fifo for consumer: 0 - disabled, 1 - low prio, 2 - fifo");
 
 static int read_events;
 
@@ -303,22 +303,22 @@ static void ring_buffer_producer(void)
 		trace_printk("ERROR!\n");
 
 	if (!disable_reader) {
-		if (consumer_fifo < 0)
+		if (consumer_fifo)
+			trace_printk("Running Consumer at SCHED_FIFO %s\n",
+				     consumer_fifo == 1 ? "low" : "high");
+		else
 			trace_printk("Running Consumer at nice: %d\n",
 				     consumer_nice);
-		else
-			trace_printk("Running Consumer at SCHED_FIFO %d\n",
-				     consumer_fifo);
 	}
-	if (producer_fifo < 0)
+	if (producer_fifo)
+		trace_printk("Running Producer at SCHED_FIFO %s\n",
+			     consumer_fifo == 1 ? "low" : "high");
+	else
 		trace_printk("Running Producer at nice: %d\n",
 			     producer_nice);
-	else
-		trace_printk("Running Producer at SCHED_FIFO %d\n",
-			     producer_fifo);
 
 	/* Let the user know that the test is running at low priority */
-	if (producer_fifo < 0 && consumer_fifo < 0 &&
+	if (!producer_fifo && !consumer_fifo &&
 	    producer_nice == MAX_NICE && consumer_nice == MAX_NICE)
 		trace_printk("WARNING!!! This test is running at lowest priority.\n");
 
@@ -455,21 +455,19 @@ static int __init ring_buffer_benchmark_
 	 * Run them as low-prio background tasks by default:
 	 */
 	if (!disable_reader) {
-		if (consumer_fifo >= 0) {
-			struct sched_param param = {
-				.sched_priority = consumer_fifo
-			};
-			sched_setscheduler(consumer, SCHED_FIFO, &param);
-		} else
+		if (consumer_fifo >= 2)
+			sched_set_fifo(consumer);
+		else if (consumer_fifo == 1)
+			sched_set_fifo_low(consumer);
+		else
 			set_user_nice(consumer, consumer_nice);
 	}
 
-	if (producer_fifo >= 0) {
-		struct sched_param param = {
-			.sched_priority = producer_fifo
-		};
-		sched_setscheduler(producer, SCHED_FIFO, &param);
-	} else
+	if (producer_fifo >= 2)
+		sched_set_fifo(producer);
+	else if (producer_fifo == 1)
+		sched_set_fifo_low(producer);
+	else
 		set_user_nice(producer, producer_nice);
 
 	return 0;
