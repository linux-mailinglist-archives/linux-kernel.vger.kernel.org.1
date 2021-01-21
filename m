Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171A32FEC90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbhAUOCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:02:48 -0500
Received: from foss.arm.com ([217.140.110.172]:37386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbhAUOBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:01:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19767139F;
        Thu, 21 Jan 2021 06:01:07 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AB593F68F;
        Thu, 21 Jan 2021 06:01:05 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        cai@redhat.com, vincent.donnefort@arm.com, decui@microsoft.com,
        paulmck@kernel.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, tj@kernel.org, peterz@infradead.org
Subject: Re: [PATCH -v3 8/9] sched: Fix CPU hotplug / tighten is_per_cpu_kthread()
In-Reply-To: <20210121103507.102416009@infradead.org>
References: <20210121101702.402798862@infradead.org> <20210121103507.102416009@infradead.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Jan 2021 14:01:03 +0000
Message-ID: <jhjeeiemlsw.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/21 11:17, Peter Zijlstra wrote:
> @@ -7504,6 +7525,9 @@ int sched_cpu_deactivate(unsigned int cp
>        * preempt-disabled and RCU users of this state to go away such that
>        * all new such users will observe it.
>        *
> +	 * Specifically, we rely on ttwu to no longer target this CPU, see
> +	 * ttwu_queue_cond() and is_cpu_allowed().
> +	 *

So the last time ttwu_queue_wakelist() can append a task onto a dying
CPU's wakelist is before sched_cpu_deactivate()'s synchronize_rcu()
returns. 

As discussed on IRC, paranoia would have us issue a

  flush_smp_call_function_from_idle()

upon returning from said sync, but this will require further surgery.

Do we want something like the below in the meantime? Ideally we'd warn on
setting rq->ttwu_pending when !cpu_active(), but as per the above this is
allowed before the synchronize_rcu() returns.

---

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ed6ff94aa68a..4b5b4b02ee64 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7590,6 +7590,7 @@ int sched_cpu_starting(unsigned int cpu)
  */
 int sched_cpu_wait_empty(unsigned int cpu)
 {
+	WARN_ON_ONCE(READ_ONCE(cpu_rq(cpu)->ttwu_pending));
 	balance_hotplug_wait();
 	return 0;
 }

>        * Do sync before park smpboot threads to take care the rcu boost case.
>        */
>       synchronize_rcu();
