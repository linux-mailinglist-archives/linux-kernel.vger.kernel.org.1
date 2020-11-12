Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4F12B0E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgKLTbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:31:34 -0500
Received: from foss.arm.com ([217.140.110.172]:56364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgKLTbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:31:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FD621042;
        Thu, 12 Nov 2020 11:31:31 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFCF23F6CF;
        Thu, 12 Nov 2020 11:31:28 -0800 (PST)
References: <20201023101158.088940906@infradead.org> <20201023102346.921768277@infradead.org> <8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com> <jhjd00ixz9z.mognet@arm.com> <13786aa5a5fc958708ef1182c885d1a574449d99.camel@redhat.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qian Cai <cai@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 10/19] sched: Fix migrate_disable() vs set_cpus_allowed_ptr()
In-reply-to: <13786aa5a5fc958708ef1182c885d1a574449d99.camel@redhat.com>
Date:   Thu, 12 Nov 2020 19:31:12 +0000
Message-ID: <jhja6vmxthb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/11/20 18:01, Qian Cai wrote:
> On Thu, 2020-11-12 at 17:26 +0000, Valentin Schneider wrote:
>> On 12/11/20 16:38, Qian Cai wrote:
>> > Some syscall fuzzing from an unprivileged user starts to trigger this below
>> > since this commit first appeared in the linux-next today. Does it ring any
>> > bells?
>> >
>>
>> What's the .config? I'm interested in
>> CONFIG_PREEMPT
>> CONFIG_PREEMPT_RT
>> CONFIG_SMP
>
> https://cailca.coding.net/public/linux/mm/git/files/master/arm64.config
>
> # CONFIG_PREEMPT is not set
> CONFIG_SMP=y
>

So that's CONFIG_PREEMPT_NONE=y

> Also, I have been able to reproduce this on powerpc as well just now.
>
[...]
>
> [12065.101987][ T1310] __switch_to (arch/arm64/kernel/process.c:580)
> [12065.106227][ T1310] __schedule (kernel/sched/core.c:4272 kernel/sched/core.c:5019)
> [12065.110505][ T1310] schedule (./arch/arm64/include/asm/current.h:19 (discriminator 1) ./arch/arm64/include/asm/preempt.h:53 (discriminator 1) kernel/sched/core.c:5099 (discriminator 1))
> [12065.114562][ T1310] schedule_timeout (kernel/time/timer.c:1848)
> [12065.119275][ T1310] wait_for_completion (kernel/sched/completion.c:85 kernel/sched/completion.c:106 kernel/sched/completion.c:117 kernel/sched/completion.c:138)
> [12065.124257][ T1310] affine_move_task (./include/linux/instrumented.h:101 ./include/asm-generic/atomic-instrumented.h:220 ./include/linux/refcount.h:272 ./include/linux/refcount.h:315 ./include/linux/refcount.h:333 kernel/sched/core.c:2263)
> [12065.129013][ T1310] __set_cpus_allowed_ptr (kernel/sched/core.c:2353)
> [12065.134248][ T1310] sched_setaffinity (kernel/sched/core.c:6460)
> [12065.139088][ T1310] __arm64_sys_sched_setaffinity (kernel/sched/core.c:6511 kernel/sched/core.c:6500 kernel/sched/core.c:6500)
> [12065.144972][ T1310] do_el0_svc (arch/arm64/kernel/syscall.c:36 arch/arm64/kernel/syscall.c:48 arch/arm64/kernel/syscall.c:159 arch/arm64/kernel/syscall.c:205)
> [12065.149165][ T1310] el0_sync_handler (arch/arm64/kernel/entry-common.c:236 arch/arm64/kernel/entry-common.c:254)
> [12065.153876][ T1310] el0_sync (arch/arm64/kernel/entry.S:741)
>

Thanks!

One thing I don't get: that trace shows refcount_dec_and_test()
(kernel/sched/core.c:2263) happening before the wait_for_completion(). It's
not the case in the below trace.

> == powerpc ==
> [18060.020301][ T676] [c000200014227670] [c000000000a6d1e8] __func__.5350+0x1220e0/0x181338 unreliable
> [18060.020333][ T676] [c000200014227850] [c00000000001a278] __switch_to (arch/powerpc/kernel/process.c:1273)
> [18060.020351][ T676] [c0002000142278c0] [c0000000008f3e94] __schedule (kernel/sched/core.c:4269 kernel/sched/core.c:5019)
> [18060.020377][ T676] [c000200014227990] [c0000000008f4638] schedule (./include/asm-generic/preempt.h:59 (discriminator 1) kernel/sched/core.c:5099 (discriminator 1))
> [18060.020394][ T676] [c0002000142279c0] [c0000000008fbd34] schedule_timeout (kernel/time/timer.c:1847)
> [18060.020420][ T676] [c000200014227ac0] [c0000000008f6398] wait_for_completion (kernel/sched/completion.c:85 kernel/sched/completion.c:106 kernel/sched/completion.c:117 kernel/sched/completion.c:138)
> [18060.020455][ T676] [c000200014227b30] [c000000000100fd4] affine_move_task (kernel/sched/core.c:2261)
> [18060.020481][ T676] [c000200014227c90] [c000000000101444] __set_cpus_allowed_ptr (kernel/sched/core.c:2353)
> [18060.020507][ T676] [c000200014227d00] [c000000000106eac] sched_setaffinity (kernel/sched/core.c:6460)
> [18060.020533][ T676] [c000200014227d70] [c000000000107134] sys_sched_setaffinity (kernel/sched/core.c:6511 kernel/sched/core.c:6500)
> [18060.020559][ T676] [c000200014227dc0] [c00000000002a6d8] system_call_exception (arch/powerpc/kernel/syscall_64.c:111)
> [18060.020585][ T676] [c000200014227e20] [c00000000000d0a8] system_call_common (arch/powerpc/kernel/entry_64.S:302)

I take back what I said in that previous email; we could have gone through
the task_running() stop_one_cpu() and *then* hit the

  wait_for_completion(&pending->done);

and that is actually the only case that makes sense to me here, because the
!task_running() one will do the completion before waiting (that kernel has
no way to make a task Migration Disabled).

I think what is happening here is:

  affine_move_task()
      // task_running() case
      stop_one_cpu()
      wait_for_completion(&pending->done);

and this is !PREEMPT, so the stopper can very well hit:

  migration_cpu_stop()
    // Task moved between unlocks and scheduling the stopper
    task_rq(p) != rq &&
    // task_running() case
    dest_cpu >= 0

    => no complete_all(), ever :(

This is an annoying case because we didn't have to bother about it before;
a rq mismatch meant the task was fine, because we modified
->cpus_allowed_mask prior.

With migrate_disable(), we have to chase after the bloody task because
we have to preempt it to get a stable is_migration_disabled() reading. It
could have been Migration Disabled, got some pending installed, got out of
Migration Disabled, moved around, gone Migration Disabled again and got
some more pending before we get to run the stopper :(

a) Do you also get this on CONFIG_PREEMPT=y?
b) Could you try the below?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 02076e6d3792..fad0a8e62aca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1923,7 +1923,7 @@ static int migration_cpu_stop(void *data)
 		else
 			p->wake_cpu = dest_cpu;
 
-	} else if (dest_cpu < 0) {
+	} else if (dest_cpu < 0 || pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
 		 * preempt_enable() and scheduling the stopper task. At that
@@ -1933,6 +1933,17 @@ static int migration_cpu_stop(void *data)
 		 * more likely.
 		 */
 
+		/*
+		 * The task moved before the stopper got to run. We're holding
+		 * ->pi_lock, so the allowed mask is stable - if it got
+		 * somewhere allowed, we're done.
+		 */
+		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
+			p->migration_pending = NULL;
+			complete = true;
+			goto out;
+		}
+
 		/*
 		 * When this was migrate_enable() but we no longer have an
 		 * @pending, a concurrent SCA 'fixed' things and we should be
