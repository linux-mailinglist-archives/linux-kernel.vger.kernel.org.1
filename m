Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC32B5BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgKQJig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgKQJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:38:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2CEC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ml+AWrO6PMqaRF0x0zELssnj5J1f5i17DJx7o/swHjw=; b=ecD4yzUIy4eHZvXRSm5fpFqGS1
        IC1HOihF+b1EhuWTYh4ND4xzy0GC5e12hECr/FbJXKO1/UXCVRyAR2NRCH2DObzNJH+PMfi7cWdH6
        1c5sy1x/jCrbL9VjcEt3yMdw8dAXWe5ipow4Y83SIcBwxmk+zW5IuYma241V9q9AumwfKNzII2W4L
        TlITcNH1W/uoJ6GS3XDYMlK39cS1TiTUsAjYWQ8T5sxZx0AExhmbQEH3KhFlLkYJ8giebFH+WNSBm
        Yo5HBq1+9JUBWlGF/bhc/5ejAQisl9GTcYDhZTE80F2RrYWJhSVQM5oQc9d69n2pWXVO1lsrae4EL
        qNSEOHVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kexRW-00062f-Kt; Tue, 17 Nov 2020 09:38:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9AD29301959;
        Tue, 17 Nov 2020 10:38:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8546C2012638E; Tue, 17 Nov 2020 10:38:29 +0100 (CET)
Date:   Tue, 17 Nov 2020 10:38:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH] sched: Fix rq->nr_iowait ordering
Message-ID: <20201117093829.GD3121429@hirez.programming.kicks-ass.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
 <20201116193149.GW3371@techsingularity.net>
 <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


And poking at this reminded me of an order email from TJ that seems to
have stagnated.

---
Subject: sched: Fix rq->nr_iowait ordering
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 24 Sep 2020 13:50:42 +0200

  schedule()				ttwu()
    deactivate_task();			  if (p->on_rq && ...) // false
					    atomic_dec(&task_rq(p)->nr_iowait);
    if (prev->in_iowait)
      atomic_inc(&rq->nr_iowait);

Allows nr_iowait to be decremented before it gets incremented,
resulting in more dodgy IO-wait numbers than usual.

Note that because we can now do ttwu_queue_wakelist() before
p->on_cpu==0, we lose the natural ordering and have to further delay
the decrement.

Fixes: Fixes: c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2949,7 +2949,12 @@ ttwu_do_activate(struct rq *rq, struct t
 #ifdef CONFIG_SMP
 	if (wake_flags & WF_MIGRATED)
 		en_flags |= ENQUEUE_MIGRATED;
+	else
 #endif
+	if (p->in_iowait) {
+		delayacct_blkio_end(p);
+		atomic_dec(&task_rq(p)->nr_iowait);
+	}
 
 	activate_task(rq, p, en_flags);
 	ttwu_do_wakeup(rq, p, wake_flags, rf);
@@ -3336,11 +3341,6 @@ try_to_wake_up(struct task_struct *p, un
 	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
 		goto unlock;
 
-	if (p->in_iowait) {
-		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
-	}
-
 #ifdef CONFIG_SMP
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
@@ -3411,6 +3411,11 @@ try_to_wake_up(struct task_struct *p, un
 
 	cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
 	if (task_cpu(p) != cpu) {
+		if (p->in_iowait) {
+			delayacct_blkio_end(p);
+			atomic_dec(&task_rq(p)->nr_iowait);
+		}
+
 		wake_flags |= WF_MIGRATED;
 		psi_ttwu_dequeue(p);
 		set_task_cpu(p, cpu);
