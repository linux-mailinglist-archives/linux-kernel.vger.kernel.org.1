Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8612A2B0B40
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKLR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:26:28 -0500
Received: from foss.arm.com ([217.140.110.172]:54702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgKLR01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:26:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2A82169C;
        Thu, 12 Nov 2020 09:26:26 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 851E63F73C;
        Thu, 12 Nov 2020 09:26:24 -0800 (PST)
References: <20201023101158.088940906@infradead.org> <20201023102346.921768277@infradead.org> <8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com>
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
Message-ID: <jhjd00ixz9z.mognet@arm.com>
In-reply-to: <8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com>
Date:   Thu, 12 Nov 2020 17:26:14 +0000
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/11/20 16:38, Qian Cai wrote:
> Some syscall fuzzing from an unprivileged user starts to trigger this below
> since this commit first appeared in the linux-next today. Does it ring any
> bells?
>

What's the .config? I'm interested in
CONFIG_PREEMPT
CONFIG_PREEMPT_RT
CONFIG_SMP

From a quick look it seems that tree doesn't have Thomas' "generalization" of
migrate_disable(), so if this doesn't have PREEMPT_RT we could forget about
migrate_disable() for now.

> [12065.065837][ T1310] INFO: task trinity-c30:91730 blocked for more than 368 seconds.
> [12065.073524][ T1310]       Tainted: G             L    5.10.0-rc3-next-20201112 #2
> [12065.081076][ T1310] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [12065.089648][ T1310] task:trinity-c30     state:D stack:26576 pid:91730 ppid: 82688 flags:0x00000000
> [12065.098818][ T1310] Call trace:
> [12065.101987][ T1310]  __switch_to+0xf0/0x1a8
> [12065.106227][ T1310]  __schedule+0x6ec/0x1708
> [12065.110505][ T1310]  schedule+0x1bc/0x3b0
> [12065.114562][ T1310]  schedule_timeout+0x3c4/0x4c0
> [12065.119275][ T1310]  wait_for_completion+0x13c/0x248
> [12065.124257][ T1310]  affine_move_task+0x410/0x688
> (inlined by) affine_move_task at kernel/sched/core.c:2261
> [12065.129013][ T1310]  __set_cpus_allowed_ptr+0x1b4/0x370
> [12065.134248][ T1310]  sched_setaffinity+0x4f0/0x7e8
> [12065.139088][ T1310]  __arm64_sys_sched_setaffinity+0x1f4/0x2a0
> [12065.144972][ T1310]  do_el0_svc+0x124/0x228
> [12065.149165][ T1310]  el0_sync_handler+0x208/0x384
> [12065.153876][ T1310]  el0_sync+0x140/0x180
> [12065.157971][ T1310]

So that's a task changing the affinity of some task (either itself or
another; I can't say without a decoded stacktrace), and then blocking on a
wait_for_completion() that apparently never happens.

I don't see stop_one_cpu() in the trace, so I assume it's the !task_running
case, for which the completion should be completed before getting to the
wait (unless we *do* have migrate_disable()).

Could you please run scripts/decode_stacktrace.sh on the above?

> [12065.157971][ T1310] Showing all locks held in the system:
> [12065.166401][ T1310] 1 lock held by khungtaskd/1310:
> [12065.171288][ T1310]  #0: ffff800018d0cb40 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.56+0x0/0x38
> [12065.182210][ T1310] 4 locks held by trinity-main/82688:
> [12065.187515][ T1310] 2 locks held by kworker/u513:3/82813:
> [12065.192922][ T1310]  #0: ffff000000419d38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x69c/0x18c8
> [12065.203890][ T1310]  #1: ffff0000122bfd40 ((work_completion)(&buf->work)){+.+.}-{0:0}, at: __update_idle_core+0xa8/0x460
> [12065.214916][ T1310] 1 lock held by trinity-c35/137168:
> [12065.220061][ T1310]  #0: ffff0087ce767898 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x48
> [12065.229483][ T1310] 3 locks held by trinity-c61/137611:
> [12065.234757][ T1310] 1 lock held by trinity-c7/137630:
> [12065.239828][ T1310] 1 lock held by trinity-c57/137714:
> [12065.242612][T137611] futex_wake_op: trinity-c61 tries to shift op by 1008; fix this program
> [12065.245012][ T1310] 1 lock held by trinity-c52/137771:
> [12065.258538][ T1310] 2 locks held by trinity-c42/137835:
> [12065.263783][ T1310] 4 locks held by trinity-c22/137868:
> [12065.269051][ T1310]  #0: ffff000e78503798 (&rq->lock){-.-.}-{2:2}, at: newidle_balance+0x92c/0xd78
> [12065.278155][ T1310]  #1: ffff0087ce767930 (&tty->atomic_write_lock){+.+.}-{3:3}, at: tty_write_lock+0x30/0x58
> [12065.288317][ T1310]  #2: ffff800018d0cb40 (rcu_read_lock){....}-{1:2}, at: __mutex_lock+0x24c/0x1310
> [12065.297592][ T1310]  #3: ffff800018d0cb40 (rcu_read_lock){....}-{1:2}, at: lock_page_memcg+0x98/0x240
> [12065.307026][ T1310] 2 locks held by trinity-c34/137896:
> [12065.312266][ T1310]  #0: ffff000e78463798 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x22c/0x1708
> [12065.321023][ T1310]  #1: ffff800018d0cb40 (rcu_read_lock){....}-{1:2}, at: __update_idle_core+0xa8/0x460
> [12065.330663][ T1310] 2 locks held by trinity-c43/137909:
> [12065.335996][ T1310] 1 lock held by trinity-c24/137910:
> [12065.341164][ T1310] 1 lock held by trinity-c1/137954:
> [12065.346272][ T1310] 1 lock held by trinity-c49/138020:
> [12065.351425][ T1310] 1 lock held by trinity-c10/138021:
> [12065.356649][ T1310] 1 lock held by trinity-c32/138039:
> [12065.361813][ T1310] 4 locks held by trinity-c36/138042:
> [12065.367129][ T1310] 2 locks held by trinity-c14/138061:
> [12065.372378][ T1310] 2 locks held by trinity-c38/138070:
> [12065.377688][ T1310] 1 lock held by trinity-c50/138074:
> [12065.382885][ T1310] 1 lock held by trinity-c12/138085:
> [12065.388186][ T1310] 1 lock held by trinity-c4/138087:
> [12065.393272][ T1310] 3 locks held by trinity-c6/138091:
> [12065.398492][ T1310] 2 locks held by trinity-c48/138095:
> [12065.403757][ T1310] 2 locks held by trinity-c62/138097:
> [12065.409045][ T1310] 2 locks held by trinity-main/138107:
> [12065.414441][ T1310] 1 lock held by modprobe/138108:
> [12065.419351][ T1310]
> [12065.421560][ T1310] =============================================
> [12065.421560][ T1310]
