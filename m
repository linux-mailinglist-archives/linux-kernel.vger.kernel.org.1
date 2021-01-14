Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A592F569F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbhANBuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:50:03 -0500
Received: from foss.arm.com ([217.140.110.172]:42404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbhANA2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:28:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A1C11FB;
        Wed, 13 Jan 2021 16:15:31 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C76B83F719;
        Wed, 13 Jan 2021 16:15:29 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, jiangshanlai@gmail.com,
        cai@redhat.com, vincent.donnefort@arm.com, decui@microsoft.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH] sched/core: Print out straggler tasks in sched_cpu_dying()
In-Reply-To: <20210113220244.GC2743@paulmck-ThinkPad-P72>
References: <20210113183141.11974-1-valentin.schneider@arm.com> <20210113220244.GC2743@paulmck-ThinkPad-P72>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 14 Jan 2021 00:15:24 +0000
Message-ID: <jhjft34z84j.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/21 14:02, Paul E. McKenney wrote:
>
> Given that I am not seeing much sched_cpu_dying(), this patch didn't
> produce any output.  (I will try other configurations.)
>

Thanks for giving it a spin! I think with the current series (either
Lai's or Peter's) sched_cpu_dying() should go smoothly, but you never
know.

> However, it did produce the following new-to-me splat, which will
> hopefully be of some help.
>
>                                                       Thanx, Paul
>
> ------------------------------------------------------------------------
>
> WARNING: CPU: 2 PID: 23 at kernel/kthread.c:508 kthread_set_per_cpu+0x3b/0x50

Aha, so that's that warning I was expecting to see [1].
Did you also get the process_one_work() one?

FWIW I think Peter's suggested approach of killing+respawning the pcpu
kworkers should prevent at least this one from showing up - all of the
affinity / flag changes would happen before the task gets enqueued
anywhere.

[1]: http://lore.kernel.org/r/jhjturkzzv9.mognet@arm.com

> Modules linked in:
> CPU: 2 PID: 23 Comm: cpuhp/2 Not tainted 5.11.0-rc3+ #1180
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
> RIP: 0010:kthread_set_per_cpu+0x3b/0x50
> Code: 00 48 85 c0 74 1f 40 84 f6 74 16 81 e2 00 00 00 04 74 1b 83 bf a0 03 00 00
> +01 75 0e f0 80 08 01 c3 f0 80 20 fe c3 0f 0b eb d0 <0f> 0b eb ee 0f 0b eb e1 0f
> +1f 00 66 2e 0f 1f 84 00 00 00 00 00 f6
> RSP: 0000:ffffb25c80103df8 EFLAGS: 00010202
> RAX: ffff94ac8188ec00 RBX: ffff94ac81390240 RCX: 0000000000000000
> RDX: 0000000004000000 RSI: 0000000000000001 RDI: ffff94ac818fde00
> RBP: ffff94ac9f4aadc0 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000004 R11: 0000000000000000 R12: ffff94ac9f4ab0e8
> R13: 0000000000000002 R14: ffffffffb9868c40 R15: 00000000ffffffff
> FS:  0000000000000000(0000) GS:ffff94ac9f480000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000001b022000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  workqueue_online_cpu+0x19c/0x360
>  ? workqueue_prepare_cpu+0x70/0x70
>  cpuhp_invoke_callback+0x9e/0x890
>  cpuhp_thread_fun+0x199/0x230
>  ? _raw_spin_unlock_irqrestore+0x2f/0x50
>  ? sort_range+0x20/0x20
>  smpboot_thread_fn+0x193/0x230
>  kthread+0x13b/0x160
>  ? kthread_insert_work_sanity_check+0x50/0x50
>  ret_from_fork+0x22/0x30
> irq event stamp: 38113
> hardirqs last  enabled at (38121): [<ffffffffb80dafaa>]
> +console_unlock+0x46a/0x550
> hardirqs last disabled at (38130): [<ffffffffb80daf16>]
> +console_unlock+0x3d6/0x550
> softirqs last  enabled at (37574): [<ffffffffb9000342>] __do_softirq+0x342/0x48e
> softirqs last disabled at (37567): [<ffffffffb8e00f92>]
> +asm_call_irq_on_stack+0x12/0x20
> ---[ end trace 0b77ae0f211adc14 ]---
