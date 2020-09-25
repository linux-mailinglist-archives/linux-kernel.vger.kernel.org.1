Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917C8278FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgIYRtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:49:39 -0400
Received: from foss.arm.com ([217.140.110.172]:50282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYRtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:49:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB99101E;
        Fri, 25 Sep 2020 10:49:38 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF4DC3F718;
        Fri, 25 Sep 2020 10:49:36 -0700 (PDT)
References: <20200921163557.234036895@infradead.org> <6f55a303-0e5c-8e84-65d3-798b589a5d75@arm.com> <20200925101030.GA2594@hirez.programming.kicks-ass.net> <d26d81ec-01d6-f6c0-816b-fbd8bb71e132@arm.com> <jhj7dsi82w9.mognet@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 0/9] sched: Migrate disable support
In-reply-to: <jhj7dsi82w9.mognet@arm.com>
Date:   Fri, 25 Sep 2020 18:49:26 +0100
Message-ID: <jhj1ripoift.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/09/20 13:19, Valentin Schneider wrote:
> On 25/09/20 12:58, Dietmar Eggemann wrote:
>> With Valentin's print_rq() inspired test snippet I always see one of the
>> RT user tasks as the second guy? BTW, it has to be RT tasks, never
>> triggered with CFS tasks.
>>
>> [   57.849268] CPU2 nr_running=2
>> [   57.852241]  p=migration/2
>> [   57.854967]  p=task0-0
>
> I can also trigger the BUG_ON() using the built-in locktorture module
> (+enabling hotplug torture), and it happens very early on. I can't trigger
> it under qemu sadly :/ Also, in my case it's always a kworker:
>
> [    0.830462] CPU3 nr_running=2
> [    0.833443]  p=migration/3
> [    0.836150]  p=kworker/3:0
>
> I'm looking into what workqueue.c is doing about hotplug...

So with
- The pending migration fixup (20200925095615.GA2651@hirez.programming.kicks-ass.net)
- The workqueue set_cpus_allowed_ptr() change (from IRC)
- The set_rq_offline() move + DL/RT pull && rq->online (also from IRC)

my Juno survives rtmutex + hotplug locktorture, where it would previously
explode < 1s after boot (mostly due to the workqueue thing).

I stared a bit more at the rq_offline() + DL/RT bits and they look fine to
me.

The one thing I'm not entirely sure about is while you plugged the
class->balance() hole, AIUI we might still get RT (DL?) pull callbacks
enqueued - say if we just unthrottled an RT RQ and something changes the
priority of one of the freshly-released tasks (user or rtmutex
interaction), I don't see any stopgap preventing a pull from happening.

I slapped the following on top of my kernel and it didn't die, although I'm
not sure I'm correctly stressing this path. Perhaps we could limit that to
the pull paths, since technically we're okay with pushing out of an !online
RQ.

---
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 50aac5b6db26..00d1a7b85e97 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1403,7 +1403,7 @@ queue_balance_callback(struct rq *rq,
 {
        lockdep_assert_held(&rq->lock);

-	if (unlikely(head->next))
+	if (unlikely(head->next || !rq->online))
                return;

        head->func = (void (*)(struct callback_head *))func;
---
