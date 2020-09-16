Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9D326C19D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 12:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgIPK0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 06:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgIPKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 06:19:51 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DEDC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 03:18:55 -0700 (PDT)
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1kIUWT-0003eB-Cm; Wed, 16 Sep 2020 12:18:45 +0200
Date:   Wed, 16 Sep 2020 12:18:45 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com, swood@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH 2/2] sched/hotplug: Ensure only per-cpu kthreads run
 during hotplug
Message-ID: <20200916101845.5ikjhfk27bgvs3pe@flow>
References: <20200911081745.214686199@infradead.org>
 <20200911082536.528661716@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911082536.528661716@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-11 10:17:47 [+0200], Peter Zijlstra wrote:
> In preparation for migrate_disable(), make sure only per-cpu kthreads
> are allowed to run on !active CPUs.
> 
> This is ran (as one of the very first steps) from the cpu-hotplug
> task which is a per-cpu kthread and completion of the hotplug
> operation only requires such tasks.
> 
> This contraint enables the migrate_disable() implementation to wait
> for completion of all migrate_disable regions on this CPU at hotplug
> time without fear of any new ones starting.
> 
> This replaces the unlikely(rq->balance_callbacks) test at the tail of
> context_switch with an unlikely(rq->balance_work), the fast path is
> not affected.

With this on top of -rc5 I get:

[   42.678670] process 1816 (hackbench) no longer affine to cpu2
[   42.678684] process 1817 (hackbench) no longer affine to cpu2
[   42.710502] ------------[ cut here ]------------
[   42.711505] rq->clock_update_flags < RQCF_ACT_SKIP
[   42.711514] WARNING: CPU: 2 PID: 19 at kernel/sched/sched.h:1141 update_curr+0xe3/0x3f0
[   42.714005] Modules linked in:
[   42.714582] CPU: 2 PID: 19 Comm: migration/2 Not tainted 5.9.0-rc5+ #107
[   42.715836] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1 04/01/2014
[   42.717367] RIP: 0010:update_curr+0xe3/0x3f0
[   42.718212] Code: 09 00 00 01 0f 87 6c ff ff ff 80 3d 52 bd 59 01 00 0f 85 5f ff ff ff 48 c7 c7 f8 7e 2b 82 c6 05 3e bd 59 01 01 e8 bc 9a fb ff <0f> 0b e9 45 ff ff ff 8b 05 d8 d4 59 01 48 8d 6b 80 8b 15 ba 5a 5b
[   42.721839] RSP: 0018:ffffc900000e3d60 EFLAGS: 00010086
[   42.722827] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   42.724166] RDX: ffff888275fa4540 RSI: ffffffff810f37e6 RDI: ffffffff82463940
[   42.725547] RBP: ffff888276ca9600 R08: 0000000000000000 R09: 0000000000000026
[   42.726925] R10: 0000000000000046 R11: 0000000000000046 R12: ffff888276ca9580
[   42.728268] R13: ffff888276ca9580 R14: ffff888276ca9600 R15: ffff88826aa5c5c0
[   42.729659] FS:  0000000000000000(0000) GS:ffff888276c80000(0000) knlGS:0000000000000000
[   42.731186] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.732272] CR2: 00007f7952603f90 CR3: 000000026aa56000 CR4: 00000000003506e0
[   42.733657] Call Trace:
[   42.734136]  dequeue_task_fair+0xfa/0x6f0
[   42.734899]  do_set_cpus_allowed+0xbb/0x1c0
[   42.735692]  cpuset_cpus_allowed_fallback+0x73/0x1a0
[   42.736635]  select_fallback_rq+0x129/0x160
[   42.737450]  __balance_push_stop+0x132/0x230
[   42.738291]  ? migration_cpu_stop+0x1f0/0x1f0
[   42.739118]  cpu_stopper_thread+0x76/0x100
[   42.739897]  ? smpboot_thread_fn+0x21/0x1f0
[   42.740691]  smpboot_thread_fn+0x106/0x1f0
[   42.741487]  ? __smpboot_create_thread.part.0+0x100/0x100
[   42.742539]  kthread+0x135/0x150
[   42.743153]  ? kthread_create_worker_on_cpu+0x60/0x60
[   42.744106]  ret_from_fork+0x22/0x30
[   42.744792] irq event stamp: 100
[   42.745433] hardirqs last  enabled at (99): [<ffffffff81a8d46f>] _raw_spin_unlock_irq+0x1f/0x30
[   42.747116] hardirqs last disabled at (100): [<ffffffff81a8d27e>] _raw_spin_lock_irq+0x3e/0x40
[   42.748748] softirqs last  enabled at (0): [<ffffffff81077b75>] copy_process+0x665/0x1b00
[   42.750353] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   42.751552] ---[ end trace d98bb30ad2616d58 ]---

That comes due to DEQUEUE_NOCLOCK in do_set_cpus_allowed(). And then
there is this:

[   42.752454] ======================================================
[   42.752455] WARNING: possible circular locking dependency detected
[   42.752455] 5.9.0-rc5+ #107 Not tainted
[   42.752455] ------------------------------------------------------
[   42.752456] migration/2/19 is trying to acquire lock:
[   42.752456] ffffffff824639f8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0xa/0x30
[   42.752458] but task is already holding lock:
[   42.752458] ffff888276ca9598 (&rq->lock){-.-.}-{2:2}, at: __balance_push_stop+0x50/0x230
[   42.752460] which lock already depends on the new lock.
[   42.752460] the existing dependency chain (in reverse order) is:
[   42.752461] -> #2 (&rq->lock){-.-.}-{2:2}:
[   42.752462]        _raw_spin_lock+0x27/0x40
[   42.752462]        task_fork_fair+0x30/0x1b0
[   42.752462]        sched_fork+0x10b/0x280
[   42.752463]        copy_process+0x702/0x1b00
[   42.752464]        _do_fork+0x5a/0x450
[   42.752464]        kernel_thread+0x50/0x70
[   42.752465]        rest_init+0x19/0x240
[   42.752465]        start_kernel+0x548/0x56a
[   42.752466]        secondary_startup_64+0xa4/0xb0

[   42.752467] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[   42.752468]        _raw_spin_lock_irqsave+0x36/0x50
[   42.752469]        try_to_wake_up+0x4e/0x720
[   42.752469]        up+0x3b/0x50
[   42.752470]        __up_console_sem+0x29/0x60
[   42.752470]        console_unlock+0x390/0x690
[   42.752471]        con_font_op+0x2ec/0x480
[   42.752471]        vt_ioctl+0x4d1/0x16e0
[   42.752471]        tty_ioctl+0x3e2/0x9a0
[   42.752472]        __x64_sys_ioctl+0x81/0x9a
[   42.752472]        do_syscall_64+0x33/0x40
[   42.752472]        entry_SYSCALL_64_after_hwframe+0x44/0xa9

[   42.752473] -> #0 ((console_sem).lock){-.-.}-{2:2}:
[   42.752474]        __lock_acquire+0x11af/0x2010
[   42.752474]        lock_acquire+0xb7/0x400
[   42.752474]        _raw_spin_lock_irqsave+0x36/0x50
[   42.752474]        down_trylock+0xa/0x30
[   42.752475]        __down_trylock_console_sem+0x23/0x90
[   42.752475]        vprintk_emit+0xf6/0x380
[   42.752476]        printk+0x53/0x6a
[   42.752476]        __warn_printk+0x42/0x84
[   42.752476]        update_curr+0xe3/0x3f0
[   42.752477]        dequeue_task_fair+0xfa/0x6f0
[   42.752477]        do_set_cpus_allowed+0xbb/0x1c0
[   42.752478]        cpuset_cpus_allowed_fallback+0x73/0x1a0
[   42.752479]        select_fallback_rq+0x129/0x160
[   42.752479]        __balance_push_stop+0x132/0x230
[   42.752480]        cpu_stopper_thread+0x76/0x100
[   42.752480]        smpboot_thread_fn+0x106/0x1f0
[   42.752480]        kthread+0x135/0x150
[   42.752480]        ret_from_fork+0x22/0x30

[   42.752481] other info that might help us debug this:
[   42.752482] Chain exists of:
[   42.752482]   (console_sem).lock --> &p->pi_lock --> &rq->lock
[   42.752483]  Possible unsafe locking scenario:
[   42.752484]        CPU0                    CPU1
[   42.752484]        ----                    ----
[   42.752484]   lock(&rq->lock);
[   42.752485]                                lock(&p->pi_lock);
[   42.752486]                                lock(&rq->lock);
[   42.752486]   lock((console_sem).lock);
[   42.752487]  *** DEADLOCK ***
[   42.752488] 3 locks held by migration/2/19:
[   42.752488]  #0: ffff88826aa5d0f8 (&p->pi_lock){-.-.}-{2:2}, at: __balance_push_stop+0x48/0x230
[   42.752489]  #1: ffff888276ca9598 (&rq->lock){-.-.}-{2:2}, at: __balance_push_stop+0x50/0x230
[   42.752490]  #2: ffffffff82478e00 (rcu_read_lock){....}-{1:2}, at: cpuset_cpus_allowed_fallback+0x0/0x1a0
[   42.752491] stack backtrace:
[   42.752492] CPU: 2 PID: 19 Comm: migration/2 Not tainted 5.9.0-rc5+ #107
[   42.752492] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1 04/01/2014
[   42.752492] Call Trace:
[   42.752493]  dump_stack+0x77/0xa0
[   42.752493]  check_noncircular+0x156/0x170
[   42.752493]  __lock_acquire+0x11af/0x2010
[   42.752493]  ? __lock_acquire+0x1692/0x2010
[   42.752493]  lock_acquire+0xb7/0x400
[   42.752494]  ? down_trylock+0xa/0x30
[   42.752494]  ? log_store.constprop.0+0x1a4/0x250
[   42.752494]  ? printk+0x53/0x6a
[   42.752494]  _raw_spin_lock_irqsave+0x36/0x50
[   42.752495]  ? down_trylock+0xa/0x30
[   42.752495]  down_trylock+0xa/0x30
[   42.752495]  ? printk+0x53/0x6a
[   42.752495]  __down_trylock_console_sem+0x23/0x90
[   42.752495]  vprintk_emit+0xf6/0x380
[   42.752496]  printk+0x53/0x6a
[   42.752496]  __warn_printk+0x42/0x84
[   42.752496]  update_curr+0xe3/0x3f0
[   42.752496]  dequeue_task_fair+0xfa/0x6f0
[   42.752497]  do_set_cpus_allowed+0xbb/0x1c0
[   42.752497]  cpuset_cpus_allowed_fallback+0x73/0x1a0
[   42.752497]  select_fallback_rq+0x129/0x160
[   42.752497]  __balance_push_stop+0x132/0x230
[   42.752497]  ? migration_cpu_stop+0x1f0/0x1f0
[   42.752498]  cpu_stopper_thread+0x76/0x100
[   42.752498]  ? smpboot_thread_fn+0x21/0x1f0
[   42.752498]  smpboot_thread_fn+0x106/0x1f0
[   42.752498]  ? __smpboot_create_thread.part.0+0x100/0x100
[   42.752499]  kthread+0x135/0x150
[   42.752499]  ? kthread_create_worker_on_cpu+0x60/0x60
[   42.752499]  ret_from_fork+0x22/0x30
[   42.878095] numa_remove_cpu cpu 2 node 0: mask now 0-1,3-7
[   42.879977] smpboot: CPU 2 is now offline

Sebastian
