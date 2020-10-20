Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDE2293EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408369AbgJTOq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:46:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39698 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408358AbgJTOq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:46:57 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603205215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tqQfoWG8Hj43S+Z/oZr1uU/U3uPsPn2aBkQ5lT15IpQ=;
        b=n5DCKc+RqmnnXctlhduH5YqGa8/nfyVDVXDSTxNxTe5eM5f7cLu2X4OBE5iokQckUn2YN7
        k1CrUURX3z2i1sgmmtuNdBDvvlnDh2iy+1tYgLwaLL3o27u5bo9QG6jtRwcVCvVMCByZwV
        488utaEwhvj4KOMk3ZFt+UWJC0TSgW9AUG3EItqdDR4yJX9ImDRrWJ31AeRbZTYA/UK/bB
        RAvfDArrUeuFkAvmfXAL4lsBv8o3kU+JWFcYQms6hPtjICLLDKMDreCm+hSuAPffTifEic
        +20/udICAwL1WSgltPbWbRwiYUwb8dRymgL5GQbKeLGJXZ3CrTolgXs0iTxf1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603205215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tqQfoWG8Hj43S+Z/oZr1uU/U3uPsPn2aBkQ5lT15IpQ=;
        b=OB8wq1vrgyOuaug+WmzntRzJeQ8ROqAuhzwQB4HozrPgNC4mVqUbltILjmqvLSKVVfNM0Y
        2Jyst2papMsVPXDw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: sched: Reenable interrupts in do sched_yield()
Date:   Tue, 20 Oct 2020 16:46:55 +0200
Message-ID: <87r1pt7y5c.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_sched_yield() invokes schedule() with interrupts disabled which is
not allowed. This goes back to the pre git era to commit a6efb709806c
("[PATCH] irqlock patch 2.5.27-H6") in the history tree.

Reenable interrupts and remove the misleading comment which "explains" it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6094,12 +6094,8 @@ static void do_sched_yield(void)
 	schedstat_inc(rq->yld_count);
 	current->sched_class->yield_task(rq);
 
-	/*
-	 * Since we are going to call schedule() anyway, there's
-	 * no need to preempt or enable interrupts:
-	 */
 	preempt_disable();
-	rq_unlock(rq, &rf);
+	rq_unlock_irq(rq, &rf);
 	sched_preempt_enable_no_resched();
 
 	schedule();
