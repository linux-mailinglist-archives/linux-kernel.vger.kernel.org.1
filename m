Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC89296CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462264AbgJWKZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462201AbgJWKZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:25:17 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56427C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pwB07HLOjdLdHR1fwUU0rUBjwGriYzqrq3cRu9cgll0=; b=D9QV0aRqAj8VcIkksgBpLybzs3
        l6E6bgvrGGzSBIex0cdV1560WF/DVhbvjW8Insk31mt6EjsZ2nxLDDVtJMYi+12i1hC0k+FTtIMbZ
        I+6wXPf+CSLRQnbywYP//ZWw+amJ4CNYeuTig7oTwh+GlRG3lZJ+0xleHVn0MKJiE4uE9Vtz5bgG1
        dOKqf9VCW7feYM8j4jdEDGkXfBttE6/LanH2E00ZiZ1rlQP9NgRSYYPXC4djA1GwM9Ls+MbpeTWrn
        LSsG/lMFi6e5LTaBXTZt14c3PzIAvOE1V4B8bQ65EdtkEtKTqLxAEfUUk+BXgAZzoREqg4P7qV9m2
        ESnTtNhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuFp-0003BQ-SM; Fri, 23 Oct 2020 10:25:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DEEA4307938;
        Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 710F629DDA663; Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Message-ID: <20201023102347.406912197@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Oct 2020 12:12:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v4 14/19] sched, lockdep: Annotate ->pi_lock recursion
References: <20201023101158.088940906@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a valid ->pi_lock recursion issue where the actual PI code
tries to wake up the stop task. Make lockdep aware so it doesn't
complain about this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2602,6 +2602,7 @@ int select_task_rq(struct task_struct *p
 
 void sched_set_stop_task(int cpu, struct task_struct *stop)
 {
+	static struct lock_class_key stop_pi_lock;
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
 	struct task_struct *old_stop = cpu_rq(cpu)->stop;
 
@@ -2617,6 +2618,20 @@ void sched_set_stop_task(int cpu, struct
 		sched_setscheduler_nocheck(stop, SCHED_FIFO, &param);
 
 		stop->sched_class = &stop_sched_class;
+
+		/*
+		 * The PI code calls rt_mutex_setprio() with ->pi_lock held to
+		 * adjust the effective priority of a task. As a result,
+		 * rt_mutex_setprio() can trigger (RT) balancing operations,
+		 * which can then trigger wakeups of the stop thread to push
+		 * around the current task.
+		 *
+		 * The stop task itself will never be part of the PI-chain, it
+		 * never blocks, therefore that ->pi_lock recursion is safe.
+		 * Tell lockdep about this by placing the stop->pi_lock in its
+		 * own class.
+		 */
+		lockdep_set_class(&stop->pi_lock, &stop_pi_lock);
 	}
 
 	cpu_rq(cpu)->stop = stop;


