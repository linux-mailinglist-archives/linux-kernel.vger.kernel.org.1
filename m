Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9472E93C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbhADKzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbhADKzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:55:06 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9B5C061796
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 02:54:25 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id x203so6163653ooa.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 02:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzQgLP7iGPD5/PwakB4S7nss/a98ahASb2efVDte/js=;
        b=kWaYF+jwyn+JS96dDl2qytq/RsDOfBkuiiCYacT11b5F2s2VrvwCLKWkIzBlvAkR1y
         Gq9CtBFQhqxplZ7yqYPEvKSz/YNJM92YAjxLW2RCdY+UWjvHB/naARlbFndtCOrRMRwW
         plc/Pt+a3iUJ5ntWXTPOwxuNmvADVTRdfR9OAMnYrE/6nwCWLefk4hmqR1XUfE+/fH2M
         rokAegNaViz1DsWRFSIvsAwIBok2oZwsrd5PK+Qx9GLmAhsOQz/5QqO8Ny4CfHpO3qXq
         iO+aYA0TRGsbi98dxjMY105+C9zbR9OBnUKnWFlp76UqnFZ38EMowmN1vq3fMXuGGq2n
         5qwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzQgLP7iGPD5/PwakB4S7nss/a98ahASb2efVDte/js=;
        b=PX93ETbx4Cn1EBC2zvPyLtvJI692ZqAoCwpVpMG2NM7VsAvMNHi0cYL7e1c2BIubk6
         q+ky6Mh/oGHgBkaDMgTPZ1wW0IWSTzzcT2t4zRXStjEwxx+K530poz6FRw1kitQgJvqd
         prQKnuGrKryWkCTm58D+knQch8TrZYqIYONnN+jTxIuieuoLE9kqOJ3rhDyVtFyRm2CT
         9jbLqqrV40X2jxvDmYk+xwa3gG+SdrTK8P8t5n8bejYSZj02t+tPV2UuQPTYCsl7uXyr
         NUNGJjo4uVnR+Ox96tIODpulpb+AwvSQTlaachKCgVJrpiqgPvlcOTixVVXCzfWYIxjQ
         UA+g==
X-Gm-Message-State: AOAM530Lw/FWnpsOP8sH/bsekHLna5Enpk24jcCiNavr0Rw7KoxGu0AB
        bx803o5ZKEsNnEpV064/q799+aqzsZNRnBODvLQsCwsN5vE=
X-Google-Smtp-Source: ABdhPJypogNZVK3T31VIXc6mx3bG52Q8Qpgu22VrMHuEaUqYcbiN45DNXxlhhMIlJWaPcQ8ds8Dx0Ir3mjd5REQ0Cx8=
X-Received: by 2002:a4a:4ccb:: with SMTP id a194mr48690556oob.14.1609757664935;
 Mon, 04 Jan 2021 02:54:24 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c0645805b7f982e4@google.com> <20210103094904.14908-1-hdanton@sina.com>
In-Reply-To: <20210103094904.14908-1-hdanton@sina.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 4 Jan 2021 11:54:13 +0100
Message-ID: <CANpmjNM_dY20SzLqCwdL=zSxUg-6uw+tvxj+ZAUBo1z4WHsKpQ@mail.gmail.com>
Subject: Re: possible deadlock in lock_timer_base
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jan 2021 at 10:49, Hillf Danton <hdanton@sina.com> wrote:
>
> Sat, 02 Jan 2021 22:59:11 -0800
> > syzbot found the following issue on:
> >
> > HEAD commit:    d7a03a44 Add linux-next specific files for 20201223
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=155fb7b7500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ea251547cbb170c5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8983d6d4f7df556be565
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.10.0-next-20201223-syzkaller #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.0/9817 is trying to acquire lock:
> > ffffffff8b48b998 (allocation_wait.lock){..-.}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137
> >
> > but task is already holding lock:
> > ffff8880b9e24898 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:944
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #3 (&base->lock){-.-.}-{2:2}:
> >        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >        _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
> >        lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:944
> >        __mod_timer+0x398/0xe30 kernel/time/timer.c:1017
> >        __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1655
> >        queue_delayed_work_on+0xd1/0xe0 kernel/workqueue.c:1680
> >        psi_task_change+0x142/0x220 kernel/sched/psi.c:807
> >        psi_enqueue kernel/sched/stats.h:82 [inline]
> >        enqueue_task kernel/sched/core.c:1592 [inline]
> >        activate_task kernel/sched/core.c:1615 [inline]
> >        wake_up_new_task+0x9f2/0xdd0 kernel/sched/core.c:3834
> >        kernel_clone+0x1f0/0xab0 kernel/fork.c:2489
> >        kernel_thread+0xb5/0xf0 kernel/fork.c:2517
> >        rest_init+0x23/0x388 init/main.c:687
> >        start_kernel+0x470/0x491 init/main.c:1064
> >        secondary_startup_64_no_verify+0xb0/0xbb
> >
> > -> #2 (&rq->lock){-.-.}-{2:2}:
> >        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >        _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
> >        rq_lock kernel/sched/sched.h:1318 [inline]
> >        task_fork_fair+0x74/0x4d0 kernel/sched/fair.c:10767
> >        sched_fork+0x3fc/0xbd0 kernel/sched/core.c:3764
> >        copy_process+0x1d61/0x6fc0 kernel/fork.c:2070
> >        kernel_clone+0xe7/0xab0 kernel/fork.c:2465
> >        kernel_thread+0xb5/0xf0 kernel/fork.c:2517
> >        rest_init+0x23/0x388 init/main.c:687
> >        start_kernel+0x470/0x491 init/main.c:1064
> >        secondary_startup_64_no_verify+0xb0/0xbb
> >
> > -> #1 (&p->pi_lock){-.-.}-{2:2}:
> >        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >        _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
> >        try_to_wake_up+0x98/0x13b0 kernel/sched/core.c:3335
> >        autoremove_wake_function+0x12/0x140 kernel/sched/wait.c:404
> >        __wake_up_common+0x147/0x650 kernel/sched/wait.c:108
> >        __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:138
> >        __kfence_alloc+0xa0/0xbc0 mm/kfence/core.c:710
> >        kfence_alloc include/linux/kfence.h:108 [inline]
> >        slab_alloc_node mm/slub.c:2826 [inline]
> >        kmem_cache_alloc_node_trace+0x28d/0x3d0 mm/slub.c:2953
> >        kmalloc_node include/linux/slab.h:570 [inline]
> >        kzalloc_node include/linux/slab.h:693 [inline]
> >        alloc_worker kernel/workqueue.c:1826 [inline]
> >        create_worker+0xfe/0x6d0 kernel/workqueue.c:1923
> >        maybe_create_worker kernel/workqueue.c:2094 [inline]
> >        manage_workers kernel/workqueue.c:2146 [inline]
> >        worker_thread+0xaef/0x1120 kernel/workqueue.c:2393
> >        kthread+0x3b1/0x4a0 kernel/kthread.c:292
> >        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> >
> > -> #0 (allocation_wait.lock){..-.}-{2:2}:
> >        check_prev_add kernel/locking/lockdep.c:2868 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:2993 [inline]
> >        validate_chain kernel/locking/lockdep.c:3608 [inline]
> >        __lock_acquire+0x2ade/0x5500 kernel/locking/lockdep.c:4832
> >        lock_acquire kernel/locking/lockdep.c:5437 [inline]
> >        lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
> >        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >        _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
> >        __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137
> >        __kfence_alloc+0xa0/0xbc0 mm/kfence/core.c:710
> >        kfence_alloc include/linux/kfence.h:108 [inline]
> >        slab_alloc_node mm/slub.c:2826 [inline]
> >        slab_alloc mm/slub.c:2911 [inline]
> >        kmem_cache_alloc+0x259/0x470 mm/slub.c:2916
> >        kmem_cache_zalloc include/linux/slab.h:672 [inline]
> >        fill_pool+0x264/0x5c0 lib/debugobjects.c:171
> >        __debug_object_init+0x7a/0xd10 lib/debugobjects.c:560
> >        debug_object_init lib/debugobjects.c:615 [inline]
> >        debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:701
> >        debug_timer_activate kernel/time/timer.c:727 [inline]
> >        __mod_timer+0x77d/0xe30 kernel/time/timer.c:1048
> >        __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1655
> >        queue_delayed_work_on+0xd1/0xe0 kernel/workqueue.c:1680
> >        queue_delayed_work include/linux/workqueue.h:522 [inline]
> >        schedule_delayed_work include/linux/workqueue.h:626 [inline]
> >        unaccount_event kernel/events/core.c:4703 [inline]
> >        _free_event+0xf49/0x1300 kernel/events/core.c:4812
> >        put_event kernel/events/core.c:4935 [inline]
> >        perf_event_release_kernel+0xa24/0xe00 kernel/events/core.c:5050
> >        perf_release+0x33/0x40 kernel/events/core.c:5060
> >        __fput+0x283/0x920 fs/file_table.c:280
> >        task_work_run+0xdd/0x190 kernel/task_work.c:140
> >        tracehook_notify_resume include/linux/tracehook.h:189 [inline]
> >        exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
> >        exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
> >        __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
> >        syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
> >        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > other info that might help us debug this:
> >
> > Chain exists of:
> >   allocation_wait.lock --> &rq->lock --> &base->lock
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&base->lock);
> >                                lock(&rq->lock);
> >                                lock(&base->lock);
> >   lock(allocation_wait.lock);
> >
> >  *** DEADLOCK ***
> >
> > 1 lock held by syz-executor.0/9817:
> >  #0: ffff8880b9e24898 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:944
> >
> > stack backtrace:
> > CPU: 0 PID: 9817 Comm: syz-executor.0 Not tainted 5.10.0-next-20201223-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:79 [inline]
> >  dump_stack+0x107/0x163 lib/dump_stack.c:120
> >  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2117
> >  check_prev_add kernel/locking/lockdep.c:2868 [inline]
> >  check_prevs_add kernel/locking/lockdep.c:2993 [inline]
> >  validate_chain kernel/locking/lockdep.c:3608 [inline]
> >  __lock_acquire+0x2ade/0x5500 kernel/locking/lockdep.c:4832
> >  lock_acquire kernel/locking/lockdep.c:5437 [inline]
> >  lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >  _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
> >  __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137
> >  __kfence_alloc+0xa0/0xbc0 mm/kfence/core.c:710
> >  kfence_alloc include/linux/kfence.h:108 [inline]
> >  slab_alloc_node mm/slub.c:2826 [inline]
> >  slab_alloc mm/slub.c:2911 [inline]
> >  kmem_cache_alloc+0x259/0x470 mm/slub.c:2916
> >  kmem_cache_zalloc include/linux/slab.h:672 [inline]
> >  fill_pool+0x264/0x5c0 lib/debugobjects.c:171
> >  __debug_object_init+0x7a/0xd10 lib/debugobjects.c:560
> >  debug_object_init lib/debugobjects.c:615 [inline]
> >  debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:701
> >  debug_timer_activate kernel/time/timer.c:727 [inline]
> >  __mod_timer+0x77d/0xe30 kernel/time/timer.c:1048
> >  __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1655
> >  queue_delayed_work_on+0xd1/0xe0 kernel/workqueue.c:1680
> >  queue_delayed_work include/linux/workqueue.h:522 [inline]
> >  schedule_delayed_work include/linux/workqueue.h:626 [inline]
> >  unaccount_event kernel/events/core.c:4703 [inline]
> >  _free_event+0xf49/0x1300 kernel/events/core.c:4812
> >  put_event kernel/events/core.c:4935 [inline]
> >  perf_event_release_kernel+0xa24/0xe00 kernel/events/core.c:5050
> >  perf_release+0x33/0x40 kernel/events/core.c:5060
> >  __fput+0x283/0x920 fs/file_table.c:280
> >  task_work_run+0xdd/0x190 kernel/task_work.c:140
> >  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
> >  exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
> >  exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
> >  syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > RIP: 0033:0x417bf1
> > Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 a4 1a 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> > RSP: 002b:00007ffe977a18a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> > RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000417bf1
> > RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000003
> > RBP: 0000000000000001 R08: 0000000000000ab3 R09: 00000000e0282ab7
> > R10: 00007ffe977a1980 R11: 0000000000000293 R12: 000000000119ca00
> > R13: 000000000119ca00 R14: 00000000000003e8 R15: 000000000119bf8c
>
> To avoid ttwu, open code wait_event_timeout().

Thanks, I'll send a patch.

> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -94,9 +94,6 @@ DEFINE_STATIC_KEY_FALSE(kfence_allocatio
>  /* Gates the allocation, ensuring only one succeeds in a given period. */
>  static atomic_t allocation_gate = ATOMIC_INIT(1);
>
> -/* Wait queue to wake up allocation-gate timer task. */
> -static DECLARE_WAIT_QUEUE_HEAD(allocation_wait);
> -
>  /* Statistics counters for debugfs. */
>  enum kfence_counter_id {
>         KFENCE_COUNTER_ALLOCATED,
> @@ -586,6 +583,8 @@ late_initcall(kfence_debugfs_init);
>  static struct delayed_work kfence_timer;
>  static void toggle_allocation_gate(struct work_struct *work)
>  {
> +       unsigned long end;
> +
>         if (!READ_ONCE(kfence_enabled))
>                 return;
>
> @@ -596,7 +595,11 @@ static void toggle_allocation_gate(struc
>          * Await an allocation. Timeout after 1 second, in case the kernel stops
>          * doing allocations, to avoid stalling this worker task for too long.
>          */
> -       wait_event_timeout(allocation_wait, atomic_read(&allocation_gate) != 0, HZ);
> +       for (end = jiffies + HZ; jiffies < end;) {
> +               if (atomic_read(&allocation_gate) != 0)
> +                       break;

We need set_current_state(TASK_UNINTERRUPTIBLE) here, otherwise
schedule_timeout() has no effect. I'll fix this...

> +               schedule_timeout(1);
> +       }

__set_current_state(TASK_RUNNING);

>         /* Disable static key and reset timer. */
>         static_branch_disable(&kfence_allocation_key);
> @@ -707,7 +710,6 @@ void *__kfence_alloc(struct kmem_cache *
>          */
>         if (atomic_read(&allocation_gate) || atomic_inc_return(&allocation_gate) > 1)
>                 return NULL;
> -       wake_up(&allocation_wait);
>
>         if (!READ_ONCE(kfence_enabled))
>                 return NULL;
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20210103094904.14908-1-hdanton%40sina.com.
