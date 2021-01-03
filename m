Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9D12E8B3D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 08:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbhACG77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 01:59:59 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:40837 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhACG7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 01:59:53 -0500
Received: by mail-il1-f198.google.com with SMTP id g1so24418211ilq.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 22:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NLSr+yPAZm+8Rq0UX+u/qwJH/7MDt70kGeXBEt+Zgi0=;
        b=olkHqi3J5evZs3YckRcOoPW1DS1UZuuEtg6pYDFIQF830o4bsiF/KAOqJuTnzCoGZd
         2Cii7HKcE7GA5XsqF5TnsBMBj7l0joehfkue+fcu+a5OpQqRozOMWdoxaBnnRsXbHRLM
         X9eWLyMnPIy1IgsZ53xeoBkDwPb9F9mptXr+Ksl0jEzAS7moV+Yp9u9mXdojBxMurKuN
         KuohYIFwK0yJvvo0KbMIXJMybLlL2mZ+3WYW/kuCrV+cV/hRfdyVjPAviBmevJpzcGzd
         ZfzR5r+lEuGYRxyPxrg/6DPtQP92lHJpF3L1lz9595zqYJQJcZbyyelcn/5vZtDYuWqo
         zNnw==
X-Gm-Message-State: AOAM532BpxDIeij6BLIaUV4eSZLmUxJYoq1OO5nGjGCsF4cFTx+VUaMV
        8QEwCs61k01wNpBo71RNRJgt+AnkIlFskYwvwQuMYnQxxTcY
X-Google-Smtp-Source: ABdhPJxv2MUcsM5EqyifYxEJKC95lSO2flfmuQX+yQwpuOAplIeGDGw84oJYh4XU2nPdtAfK6xUPqAaF0z1Z7ko1OOUWk9Uzwdu/
MIME-Version: 1.0
X-Received: by 2002:a02:8482:: with SMTP id f2mr58390343jai.93.1609657151938;
 Sat, 02 Jan 2021 22:59:11 -0800 (PST)
Date:   Sat, 02 Jan 2021 22:59:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0645805b7f982e4@google.com>
Subject: possible deadlock in lock_timer_base
From:   syzbot <syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian@brauner.io,
        linux-kernel@vger.kernel.org, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d7a03a44 Add linux-next specific files for 20201223
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=155fb7b7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea251547cbb170c5
dashboard link: https://syzkaller.appspot.com/bug?extid=8983d6d4f7df556be565
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.10.0-next-20201223-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/9817 is trying to acquire lock:
ffffffff8b48b998 (allocation_wait.lock){..-.}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137

but task is already holding lock:
ffff8880b9e24898 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:944

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&base->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
       lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:944
       __mod_timer+0x398/0xe30 kernel/time/timer.c:1017
       __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1655
       queue_delayed_work_on+0xd1/0xe0 kernel/workqueue.c:1680
       psi_task_change+0x142/0x220 kernel/sched/psi.c:807
       psi_enqueue kernel/sched/stats.h:82 [inline]
       enqueue_task kernel/sched/core.c:1592 [inline]
       activate_task kernel/sched/core.c:1615 [inline]
       wake_up_new_task+0x9f2/0xdd0 kernel/sched/core.c:3834
       kernel_clone+0x1f0/0xab0 kernel/fork.c:2489
       kernel_thread+0xb5/0xf0 kernel/fork.c:2517
       rest_init+0x23/0x388 init/main.c:687
       start_kernel+0x470/0x491 init/main.c:1064
       secondary_startup_64_no_verify+0xb0/0xbb

-> #2 (&rq->lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
       rq_lock kernel/sched/sched.h:1318 [inline]
       task_fork_fair+0x74/0x4d0 kernel/sched/fair.c:10767
       sched_fork+0x3fc/0xbd0 kernel/sched/core.c:3764
       copy_process+0x1d61/0x6fc0 kernel/fork.c:2070
       kernel_clone+0xe7/0xab0 kernel/fork.c:2465
       kernel_thread+0xb5/0xf0 kernel/fork.c:2517
       rest_init+0x23/0x388 init/main.c:687
       start_kernel+0x470/0x491 init/main.c:1064
       secondary_startup_64_no_verify+0xb0/0xbb

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
       try_to_wake_up+0x98/0x13b0 kernel/sched/core.c:3335
       autoremove_wake_function+0x12/0x140 kernel/sched/wait.c:404
       __wake_up_common+0x147/0x650 kernel/sched/wait.c:108
       __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:138
       __kfence_alloc+0xa0/0xbc0 mm/kfence/core.c:710
       kfence_alloc include/linux/kfence.h:108 [inline]
       slab_alloc_node mm/slub.c:2826 [inline]
       kmem_cache_alloc_node_trace+0x28d/0x3d0 mm/slub.c:2953
       kmalloc_node include/linux/slab.h:570 [inline]
       kzalloc_node include/linux/slab.h:693 [inline]
       alloc_worker kernel/workqueue.c:1826 [inline]
       create_worker+0xfe/0x6d0 kernel/workqueue.c:1923
       maybe_create_worker kernel/workqueue.c:2094 [inline]
       manage_workers kernel/workqueue.c:2146 [inline]
       worker_thread+0xaef/0x1120 kernel/workqueue.c:2393
       kthread+0x3b1/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

-> #0 (allocation_wait.lock){..-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:2868 [inline]
       check_prevs_add kernel/locking/lockdep.c:2993 [inline]
       validate_chain kernel/locking/lockdep.c:3608 [inline]
       __lock_acquire+0x2ade/0x5500 kernel/locking/lockdep.c:4832
       lock_acquire kernel/locking/lockdep.c:5437 [inline]
       lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
       __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137
       __kfence_alloc+0xa0/0xbc0 mm/kfence/core.c:710
       kfence_alloc include/linux/kfence.h:108 [inline]
       slab_alloc_node mm/slub.c:2826 [inline]
       slab_alloc mm/slub.c:2911 [inline]
       kmem_cache_alloc+0x259/0x470 mm/slub.c:2916
       kmem_cache_zalloc include/linux/slab.h:672 [inline]
       fill_pool+0x264/0x5c0 lib/debugobjects.c:171
       __debug_object_init+0x7a/0xd10 lib/debugobjects.c:560
       debug_object_init lib/debugobjects.c:615 [inline]
       debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:701
       debug_timer_activate kernel/time/timer.c:727 [inline]
       __mod_timer+0x77d/0xe30 kernel/time/timer.c:1048
       __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1655
       queue_delayed_work_on+0xd1/0xe0 kernel/workqueue.c:1680
       queue_delayed_work include/linux/workqueue.h:522 [inline]
       schedule_delayed_work include/linux/workqueue.h:626 [inline]
       unaccount_event kernel/events/core.c:4703 [inline]
       _free_event+0xf49/0x1300 kernel/events/core.c:4812
       put_event kernel/events/core.c:4935 [inline]
       perf_event_release_kernel+0xa24/0xe00 kernel/events/core.c:5050
       perf_release+0x33/0x40 kernel/events/core.c:5060
       __fput+0x283/0x920 fs/file_table.c:280
       task_work_run+0xdd/0x190 kernel/task_work.c:140
       tracehook_notify_resume include/linux/tracehook.h:189 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
       exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
       __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
       syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  allocation_wait.lock --> &rq->lock --> &base->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&base->lock);
                               lock(&rq->lock);
                               lock(&base->lock);
  lock(allocation_wait.lock);

 *** DEADLOCK ***

1 lock held by syz-executor.0/9817:
 #0: ffff8880b9e24898 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:944

stack backtrace:
CPU: 0 PID: 9817 Comm: syz-executor.0 Not tainted 5.10.0-next-20201223-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2117
 check_prev_add kernel/locking/lockdep.c:2868 [inline]
 check_prevs_add kernel/locking/lockdep.c:2993 [inline]
 validate_chain kernel/locking/lockdep.c:3608 [inline]
 __lock_acquire+0x2ade/0x5500 kernel/locking/lockdep.c:4832
 lock_acquire kernel/locking/lockdep.c:5437 [inline]
 lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
 __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137
 __kfence_alloc+0xa0/0xbc0 mm/kfence/core.c:710
 kfence_alloc include/linux/kfence.h:108 [inline]
 slab_alloc_node mm/slub.c:2826 [inline]
 slab_alloc mm/slub.c:2911 [inline]
 kmem_cache_alloc+0x259/0x470 mm/slub.c:2916
 kmem_cache_zalloc include/linux/slab.h:672 [inline]
 fill_pool+0x264/0x5c0 lib/debugobjects.c:171
 __debug_object_init+0x7a/0xd10 lib/debugobjects.c:560
 debug_object_init lib/debugobjects.c:615 [inline]
 debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:701
 debug_timer_activate kernel/time/timer.c:727 [inline]
 __mod_timer+0x77d/0xe30 kernel/time/timer.c:1048
 __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1655
 queue_delayed_work_on+0xd1/0xe0 kernel/workqueue.c:1680
 queue_delayed_work include/linux/workqueue.h:522 [inline]
 schedule_delayed_work include/linux/workqueue.h:626 [inline]
 unaccount_event kernel/events/core.c:4703 [inline]
 _free_event+0xf49/0x1300 kernel/events/core.c:4812
 put_event kernel/events/core.c:4935 [inline]
 perf_event_release_kernel+0xa24/0xe00 kernel/events/core.c:5050
 perf_release+0x33/0x40 kernel/events/core.c:5060
 __fput+0x283/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x190 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x417bf1
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 a4 1a 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffe977a18a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000417bf1
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000ab3 R09: 00000000e0282ab7
R10: 00007ffe977a1980 R11: 0000000000000293 R12: 000000000119ca00
R13: 000000000119ca00 R14: 00000000000003e8 R15: 000000000119bf8c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
