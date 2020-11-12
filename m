Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519512B0ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgKLUL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:11:29 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:55857 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgKLUL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:11:28 -0500
Received: by mail-il1-f200.google.com with SMTP id w10so4836364ila.22
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xTFWMl0t1/ruluFzn/lvnjf98Ifo3UblnBOq6MrDt9U=;
        b=iVII+JQjBxwp5OtdxAncqkxk6MDD6dHAshDKh816EO3mmkBtnh9KFM6P2S3Z0NHUWD
         knet1reAEZDYz5pWZtPy2wM+1QNHDSEBCBO/xNkLvmvRxLxTBx0EBzgYsUEqf0r0HGk/
         tw3ytrxxQxKSKnj1CTu+vumNmmIQXzKApK5VC0tBhoRTC2Nm7rduxp0+OYI2W4OwmcdA
         JJtOJACyrTUoznQio7TFmGo3oj0PLfqvnVp/ix0aI8j28U6vYB5eO40RXJ4xLISvENVF
         fhmIwpVlZO3pxicaSaOeENXhbvPVsMgGPYHy4dsuntrrW5x/I+ABxzqYoO7rsQ23xelx
         FjzA==
X-Gm-Message-State: AOAM5333voeOM8C8YF5ffnTGDTlKA1hmb3VWProfMeEHZa6JphfoLw7u
        Ksbwxh+u9MVMsflSjdK2C31Q9xpG0xNpxmuHdQ8IyzEKcQkz
X-Google-Smtp-Source: ABdhPJwrJq1eECP2TmgPJkTY9XCora0RxmTLFc336c7ooWtvaqA2ZFukwZ2hyYVn+gK12EyRMKmhkpsOt4axRPmo1bIjubZTzrb3
MIME-Version: 1.0
X-Received: by 2002:a92:c7c6:: with SMTP id g6mr1061907ilk.230.1605211885230;
 Thu, 12 Nov 2020 12:11:25 -0800 (PST)
Date:   Thu, 12 Nov 2020 12:11:25 -0800
In-Reply-To: <0000000000002da9cd05a9c74d87@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035615c05b3ee84b6@google.com>
Subject: Re: INFO: rcu detected stall in input_repeat_key
From:   syzbot <syzbot+33510b19568e6f5f59c9@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, fweisbec@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    57cde551 Merge 5.10-rc3 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=154eb181500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a84e3059298aeb27
dashboard link: https://syzkaller.appspot.com/bug?extid=33510b19568e6f5f59c9
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168a6af6500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33510b19568e6f5f59c9@syzkaller.appspotmail.com

 #0: ffff888102e32888 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_direct_read fs/kernfs/file.c:203 [inline]
 #0: ffff888102e32888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read+0x174/0x590 fs/kernfs/file.c:253
 #1: ffff8881127b40f0 (kn->active#78){++++}-{0:0}, at: kernfs_file_direct_read fs/kernfs/file.c:204 [inline]
 #1: ffff8881127b40f0 (kn->active#78){++++}-{0:0}, at: kernfs_fop_read+0x197/0x590 fs/kernfs/file.c:253
 #2: ffff8881068f5218 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:736 [inline]
 #2: ffff8881068f5218 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:894
=============================================
rcu: INFO: rcu_sched self-detected stall on CPU
rcu: 	0-....: (9 ticks this GP) idle=73e/1/0x4000000000000000 softirq=13324/13325 fqs=6 
	(t=12223 jiffies g=13217 q=60087)
rcu: rcu_sched kthread starved for 2352 jiffies! g13217 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_sched       state:R  running task     stack:29096 pid:   11 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_timeout+0x148/0x250 kernel/time/timer.c:1871
 rcu_gp_fqs_loop kernel/rcu/tree.c:1925 [inline]
 rcu_gp_kthread+0x8aa/0x1630 kernel/rcu/tree.c:2099
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
NMI backtrace for cpu 0
CPU: 0 PID: 10847 Comm: systemd-udevd Not tainted 5.10.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x46/0xe0 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1da/0x200 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x1e3/0x21e kernel/rcu/tree_stall.h:318
 print_cpu_stall kernel/rcu/tree_stall.h:551 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:625 [inline]
 rcu_pending kernel/rcu/tree.c:3694 [inline]
 rcu_sched_clock_irq.cold+0x49d/0x973 kernel/rcu/tree.c:2567
 update_process_times+0x139/0x1b0 kernel/time/timer.c:1709
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:176
 tick_sched_timer+0x1c5/0x290 kernel/time/tick-sched.c:1328
 __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
 __hrtimer_run_queues+0x1ce/0xdf0 kernel/time/hrtimer.c:1583
 hrtimer_interrupt+0x300/0x8f0 kernel/time/hrtimer.c:1645
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0xf5/0x420 arch/x86/kernel/apic/apic.c:1097
 run_sysvec_on_irqstack_cond arch/x86/include/asm/irq_stack.h:91 [inline]
 sysvec_apic_timer_interrupt+0x3e/0xa0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
RIP: 0010:__preempt_count_sub arch/x86/include/asm/preempt.h:84 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x25/0x40 kernel/locking/spinlock.c:191
Code: 80 00 00 00 00 55 48 89 fd 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 2a a7 89 fb 48 89 ef e8 c2 64 8a fb f6 c7 02 75 0c 53 9d <65> ff 0d 94 3e 65 7a 5b 5d c3 e8 4c c2 a7 fb eb ed 66 2e 0f 1f 84
RSP: 0018:ffffc90000007c90 EFLAGS: 00000246
RAX: 00000000000059ac RBX: 0000000000000246 RCX: ffffffff8125c797
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff859cb074
RBP: ffff88810b8be218 R08: 0000000000000001 R09: ffffffff898c853f
R10: fffffbfff13190a7 R11: 0000000000000000 R12: 0000000000000246
R13: ffff88810b8be218 R14: 0000000000000021 R15: ffff88810b8be108
 spin_unlock_irqrestore include/linux/spinlock.h:409 [inline]
 input_repeat_key+0x118/0x380 drivers/input/input.c:201
 call_timer_fn+0x1a5/0x630 kernel/time/timer.c:1410
 expire_timers kernel/time/timer.c:1455 [inline]
 __run_timers.part.0+0x67c/0xa10 kernel/time/timer.c:1747
 __run_timers kernel/time/timer.c:1728 [inline]
 run_timer_softirq+0x80/0x120 kernel/time/timer.c:1760
 __do_softirq+0x1b2/0x945 kernel/softirq.c:298
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0x80/0xa0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:393 [inline]
 __irq_exit_rcu kernel/softirq.c:423 [inline]
 irq_exit_rcu+0x110/0x1a0 kernel/softirq.c:435
 sysvec_apic_timer_interrupt+0x43/0xa0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
RIP: 0010:unwind_next_frame+0x108b/0x1f60 arch/x86/kernel/unwind_orc.c:584
Code: 40 48 89 f8 48 c1 e8 03 0f b6 34 08 49 8d 40 03 49 89 c1 49 c1 e9 03 41 0f b6 0c 09 49 89 f9 41 83 e1 07 44 38 ce 41 0f 9e c1 <40> 84 f6 40 0f 95 c6 41 84 f1 0f 85 fb 0b 00 00 83 e0 07 38 c1 40
RSP: 0018:ffffc90003577578 EFLAGS: 00000293
RAX: ffffffff88843663 RBX: ffffc900035776a0 RCX: 0000000000000000
RDX: ffffc900035776e0 RSI: 0000000000000000 RDI: ffffffff88843662
RBP: 1ffff920006aeeb7 R08: ffffffff88843660 R09: 0000000000000001
R10: 000000000000560c R11: ffffc900035776a0 R12: ffffc900035776a0
R13: ffffc900035776d5 R14: ffffc900035776f0 R15: 0000000000000001
 __unwind_start+0x51b/0x800 arch/x86/kernel/unwind_orc.c:696
 unwind_start arch/x86/include/asm/unwind.h:60 [inline]
 arch_stack_walk+0x5c/0xe0 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0x102/0x140 mm/kasan/common.c:422
 slab_free_hook mm/slub.c:1544 [inline]
 slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1577
 slab_free mm/slub.c:3142 [inline]
 kfree+0xe5/0x5e0 mm/slub.c:4124
 tomoyo_path_perm+0x23d/0x400 security/tomoyo/file.c:842
 security_inode_getattr+0xcf/0x140 security/security.c:1279
 vfs_getattr fs/stat.c:121 [inline]
 vfs_statx+0x164/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_lstat include/linux/fs.h:3109 [inline]
 __do_sys_newlstat+0x91/0x110 fs/stat.c:362
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f3fa5c82335
Code: 69 db 2b 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 83 ff 01 48 89 f0 77 30 48 89 c7 48 89 d6 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 03 f3 c3 90 48 8b 15 31 db 2b 00 f7 d8 64 89
RSP: 002b:00007fff72486668 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 0000563af5d53100 RCX: 00007f3fa5c82335
RDX: 00007fff724866a0 RSI: 00007fff724866a0 RDI: 0000563af5d52100
RBP: 00007fff72486760 R08: 00007f3fa5f41268 R09: 0000000000001010
R10: 0000000000000080 R11: 0000000000000246 R12: 0000563af5d52100
R13: 0000563af5d52115 R14: 0000563af5d3170c R15: 0000563af5d31714
task:systemd         state:S stack:23432 pid:    1 ppid:     0 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_hrtimeout_range_clock+0x333/0x380 kernel/time/hrtimer.c:2130
 ep_poll fs/eventpoll.c:1908 [inline]
 do_epoll_wait+0xe84/0x10a0 fs/eventpoll.c:2323
 __do_sys_epoll_wait fs/eventpoll.c:2333 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2330 [inline]
 __x64_sys_epoll_wait+0x93/0xf0 fs/eventpoll.c:2330
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f54533ca303
Code: Unable to access opcode bytes at RIP 0x7f54533ca2d9.
RSP: 002b:00007ffe47e3f060 EFLAGS: 00000293 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 000056511a84bf50 RCX: 00007f54533ca303
RDX: 0000000000000025 RSI: 00007ffe47e3f070 RDI: 0000000000000004
RBP: 00007ffe47e3f330 R08: 431bde82d7b634db R09: 0000000000000020
R10: 00000000ffffffff R11: 0000000000000293 R12: 00007ffe47e3f070
R13: 0000000000000001 R14: ffffffffffffffff R15: 0000000000000002
task:kthreadd        state:S stack:28264 pid:    2 ppid:     0 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 kthreadd+0x59d/0x750 kernel/kthread.c:621
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:rcu_gp          state:I stack:30144 pid:    3 ppid:     2 flags:0x00004000
Workqueue:  0x0 (rcu_gp)
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:rcu_par_gp      state:I stack:30784 pid:    4 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kworker/0:0     state:I stack:23352 pid:    5 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 worker_thread+0x14c/0x1120 kernel/workqueue.c:2439
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kworker/0:0H    state:I stack:29504 pid:    6 ppid:     2 flags:0x00004000
Workqueue:  0x0 (kblockd)
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 worker_thread+0x14c/0x1120 kernel/workqueue.c:2439
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:mm_percpu_wq    state:I stack:30912 pid:    9 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:ksoftirqd/0     state:S stack:27080 pid:   10 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 smpboot_thread_fn+0x589/0x870 kernel/smpboot.c:161
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:rcu_sched       state:I stack:29096 pid:   11 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_timeout+0x148/0x250 kernel/time/timer.c:1871
 rcu_gp_fqs_loop kernel/rcu/tree.c:1925 [inline]
 rcu_gp_kthread+0x8aa/0x1630 kernel/rcu/tree.c:2099
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:migration/0     state:R  running task     stack:30568 pid:   12 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 smpboot_thread_fn+0x589/0x870 kernel/smpboot.c:161
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:cpuhp/0         state:S stack:27984 pid:   13 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 smpboot_thread_fn+0x589/0x870 kernel/smpboot.c:161
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:cpuhp/1         state:S stack:28104 pid:   14 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 smpboot_thread_fn+0x589/0x870 kernel/smpboot.c:161
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:migration/1     state:S stack:30168 pid:   15 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 smpboot_thread_fn+0x589/0x870 kernel/smpboot.c:161
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:ksoftirqd/1     state:S stack:25464 pid:   16 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 smpboot_thread_fn+0x589/0x870 kernel/smpboot.c:161
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kworker/1:0H    state:I stack:28016 pid:   18 ppid:     2 flags:0x00004000
Workqueue:  0x0 (kblockd)
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 worker_thread+0x14c/0x1120 kernel/workqueue.c:2439
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kdevtmpfs       state:S stack:27616 pid:   19 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 devtmpfs_work_loop drivers/base/devtmpfs.c:401 [inline]
 devtmpfsd+0x30d/0x333 drivers/base/devtmpfs.c:434
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:netns           state:I stack:30488 pid:   20 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kworker/u4:1    state:I stack:26352 pid:   21 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 worker_thread+0x14c/0x1120 kernel/workqueue.c:2439
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kworker/1:1     state:D stack:22864 pid:   31 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_preempt_disabled+0xc/0x20 kernel/sched/core.c:4660
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10a0 kernel/locking/mutex.c:1103
 __input_unregister_device+0x16d/0x470 drivers/input/input.c:2088
 input_unregister_device+0xb4/0xf0 drivers/input/input.c:2273
 hidinput_disconnect+0x15e/0x3d0 drivers/hid/hid-input.c:1982
 hid_disconnect+0x13f/0x1a0 drivers/hid/hid-core.c:2026
 hid_hw_stop drivers/hid/hid-core.c:2073 [inline]
 hid_device_remove+0x186/0x240 drivers/hid/hid-core.c:2316
 __device_release_driver+0x3bd/0x6f0 drivers/base/dd.c:1154
 device_release_driver_internal drivers/base/dd.c:1185 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1208
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x502/0xec0 drivers/base/core.c:3115
 hid_remove_device drivers/hid/hid-core.c:2485 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2504
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1434
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:458
 __device_release_driver+0x3bd/0x6f0 drivers/base/dd.c:1154
 device_release_driver_internal drivers/base/dd.c:1185 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1208
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x502/0xec0 drivers/base/core.c:3115
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1417
 usb_disconnect.cold+0x27d/0x780 drivers/usb/core/hub.c:2218
 hub_port_connect drivers/usb/core/hub.c:5074 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x1c8a/0x42d0 drivers/usb/core/hub.c:5591
 process_one_work+0x933/0x1520 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kauditd         state:S stack:30184 pid:   32 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 freezable_schedule include/linux/freezer.h:172 [inline]
 kauditd_thread+0x6af/0xb90 kernel/audit.c:881
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kworker/u4:4    state:D stack:23992 pid:  419 ppid:     2 flags:0x00004000
Workqueue: events_unbound fsnotify_mark_destroy_workfn
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1847
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x168/0x270 kernel/sched/completion.c:138
 __synchronize_srcu+0x137/0x220 kernel/rcu/srcutree.c:922
 fsnotify_mark_destroy_workfn+0xfd/0x340 fs/notify/mark.c:836
 process_one_work+0x933/0x1520 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:khungtaskd      state:S stack:29808 pid: 1267 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_timeout+0x148/0x250 kernel/time/timer.c:1871
 watchdog+0xf9/0xf70 kernel/hung_task.c:298
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:oom_reaper      state:S stack:30400 pid: 1268 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 freezable_schedule include/linux/freezer.h:172 [inline]
 oom_reaper+0x90c/0xcc0 mm/oom_kill.c:645
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:writeback       state:I stack:30696 pid: 1269 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kcompactd0      state:S stack:29104 pid: 1271 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_timeout+0x148/0x250 kernel/time/timer.c:1871
 freezable_schedule_timeout include/linux/freezer.h:192 [inline]
 kcompactd+0x566/0xca0 mm/compaction.c:2814
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kblockd         state:I stack:30696 pid: 1296 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:tpm_dev_wq      state:I stack:30304 pid: 1383 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:ata_sff         state:I stack:30488 pid: 1390 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:md              state:I stack:30696 pid: 1424 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:edac-poller     state:I stack:30488 pid: 1427 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:rpciod          state:I stack:30696 pid: 1543 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kworker/u5:0    state:I stack:30816 pid: 1544 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 worker_thread+0x14c/0x1120 kernel/workqueue.c:2439
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:xprtiod         state:I stack:30488 pid: 1545 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:cfg80211        state:I stack:30488 pid: 1548 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kswapd0         state:S stack:30248 pid: 1558 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 kswapd_try_to_sleep mm/vmscan.c:3836 [inline]
 kswapd+0xb5b/0xd30 mm/vmscan.c:3897
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:nfsiod          state:I stack:30488 pid: 1575 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:acpi_thermal_pm state:I stack:30576 pid: 1608 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:hwrng           state:S stack:30136 pid: 1653 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 add_hwgenerator_randomness+0x1b0/0x220 drivers/char/random.c:2310
 hwrng_fillfn+0x1e7/0x2d0 drivers/char/hw_random/core.c:452
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:scsi_eh_0       state:S stack:30720 pid: 1696 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 scsi_error_handler+0x529/0xec0 drivers/scsi/scsi_error.c:2212
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:scsi_tmf_0      state:I stack:30696 pid: 1697 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kworker/1:1H    state:I stack:29016 pid: 1711 ppid:     2 flags:0x00004000
Workqueue:  0x0 (kblockd)
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 worker_thread+0x14c/0x1120 kernel/workqueue.c:2439
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:target_completi state:I stack:30696 pid: 1723 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:xcopy_wq        state:I stack:30696 pid: 1724 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:libertastf      state:I stack:30696 pid: 1782 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:zd1211rw        state:I stack:30488 pid: 1801 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:u132            state:I stack:30488 pid: 1866 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:uas             state:I stack:30488 pid: 1878 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:usbip_event     state:I stack:30576 pid: 2165 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:pvrusb2-context state:S stack:30456 pid: 2368 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 pvr2_context_thread_func+0x5e2/0x850 drivers/media/usb/pvrusb2/pvrusb2-context.c:160
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kvub300c        state:I stack:30696 pid: 2416 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kvub300p        state:I stack:30696 pid: 2417 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kvub300d        state:I stack:30696 pid: 2418 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kmemstick       state:I stack:30696 pid: 2422 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:elousb          state:I stack:30784 pid: 2445 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:ipv6_addrconf   state:I stack:30488 pid: 2579 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:kworker/0:1H    state:R  running task     stack:29192 pid: 2600 ppid:     2 flags:0x00004000
Workqueue:  0x0 (kblockd)
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 worker_thread+0x14c/0x1120 kernel/workqueue.c:2439
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:ext4-rsv-conver state:I stack:30696 pid: 2601 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 rescuer_thread+0x7a7/0xd30 kernel/workqueue.c:2581
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
task:systemd-journal state:R  running task     stack:24024 pid: 2628 ppid:     1 flags:0x00000108
Call Trace:
task:systemd-udevd   state:S stack:23112 pid: 2638 ppid:     1 flags:0x00000100
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_hrtimeout_range_clock+0x333/0x380 kernel/time/hrtimer.c:2130
 ep_poll fs/eventpoll.c:1908 [inline]
 do_epoll_wait+0xe84/0x10a0 fs/eventpoll.c:2323
 __do_sys_epoll_wait fs/eventpoll.c:2333 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2330 [inline]
 __x64_sys_epoll_wait+0x93/0xf0 fs/eventpoll.c:2330
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f3fa5c902e3
Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 3d 29 54 2b 00 00 75 13 49 89 ca b8 e8 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 0b c2 00 00 48 89 04 24
RSP: 002b:00007fff724892c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000563af5d420e0 RCX: 00007f3fa5c902e3
RDX: 000000000000000f RSI: 00007fff724892d0 RDI: 000000000000000a
RBP: 00007fff72489490 R08: 0000000000000008 R09: 00007fff725ce0f0
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff724892d0
R13: 0000000000000001 R14: ffffffffffffffff R15: 0000000000000000
task:systemd-timesyn state:S stack:26824 pid: 2708 ppid:     1 flags:0x00000100
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_hrtimeout_range_clock+0x333/0x380 kernel/time/hrtimer.c:2130
 ep_poll fs/eventpoll.c:1908 [inline]
 do_epoll_wait+0xe84/0x10a0 fs/eventpoll.c:2323
 __do_sys_epoll_wait fs/eventpoll.c:2333 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2330 [inline]
 __x64_sys_epoll_wait+0x93/0xf0 fs/eventpoll.c:2330
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fac634cb303
Code: Unable to access opcode bytes at RIP 0x7fac634cb2d9.
RSP: 002b:00007ffe6b17c680 EFLAGS: 00000293 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000559047df18f0 RCX: 00007fac634cb303
RDX: 0000000000000006 RSI: 00007ffe6b17c690 RDI: 0000000000000004
RBP: 00007ffe6b17c7e0 R08: 431bde82d7b634db R09: 00007ffe6b1810f0
R10: 00000000ffffffff R11: 0000000000000293 R12: 00007ffe6b17c690
R13: 0000000000000001 R14: ffffffffffffffff R15: 0000000000000000
task:sd-resolve      state:S stack:28736 pid: 2709 ppid:     1 flags:0x00000100
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1847
 __skb_wait_for_more_packets+0x30f/0x580 net/core/datagram.c:122
 unix_dgram_recvmsg+0x1ff/0xb60 net/unix/af_unix.c:2112
 sock_recvmsg_nosec net/socket.c:885 [inline]
 sock_recvmsg net/socket.c:903 [inline]
 sock_recvmsg net/socket.c:899 [inline]
 __sys_recvfrom+0x248/0x3a0 net/socket.c:2049
 __do_sys_recvfrom net/socket.c:2067 [inline]
 __se_sys_recvfrom net/socket.c:2063 [inline]
 __x64_sys_recvfrom+0xdd/0x1b0 net/socket.c:2063
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fac6379151f
Code: Unable to access opcode bytes at RIP 0x7fac637914f5.
RSP: 002b:00007fac60f0caa0 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007fac6379151f
RDX: 0000000000002800 RSI: 00007fac60f0cca0 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000002800 R14: 00007fac60f0cca0 R15: 00007fac60f11ca0
task:dhclient        state:S stack:27400 pid: 2710 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_hrtimeout_range_clock+0x195/0x380 kernel/time/hrtimer.c:2139
 poll_schedule_timeout.constprop.0+0x107/0x1e0 fs/select.c:243
 do_select+0x119c/0x1640 fs/select.c:603
 core_sys_select+0x3c3/0x960 fs/select.c:677
 kern_select+0x13d/0x1c0 fs/select.c:718
 __do_sys_select fs/select.c:725 [inline]
 __se_sys_select fs/select.c:722 [inline]
 __x64_sys_select+0xba/0x150 fs/select.c:722
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f237ccf35e3
Code: Unable to access opcode bytes at RIP 0x7f237ccf35b9.
RSP: 002b:00007ffed314ce28 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
RAX: ffffffffffffffda RBX: 00007f237d7d5010 RCX: 00007f237ccf35e3
RDX: 00007f237d7d4210 RSI: 00007f237d7d4110 RDI: 0000000000000007
RBP: 00007ffed314ce68 R08: 00007ffed314ce80 R09: 0000000000000a58
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffed314ce80
R13: 00007ffed314ce70 R14: 00007ffed314ce78 R15: 0000000000000000
task:rsyslogd        state:S stack:24240 pid: 4264 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_hrtimeout_range_clock+0x195/0x380 kernel/time/hrtimer.c:2139
 poll_schedule_timeout.constprop.0+0x107/0x1e0 fs/select.c:243
 do_select+0x119c/0x1640 fs/select.c:603
 core_sys_select+0x3c3/0x960 fs/select.c:677
 kern_select+0x13d/0x1c0 fs/select.c:718
 __do_sys_select fs/select.c:725 [inline]
 __se_sys_select fs/select.c:722 [inline]
 __x64_sys_select+0xba/0x150 fs/select.c:722
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f4be4ef1603
Code: Unable to access opcode bytes at RIP 0x7f4be4ef15d9.
RSP: 002b:00007ffdf7478f00 EFLAGS: 00000293 ORIG_RAX: 0000000000000017
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4be4ef1603
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 000055aeb1679040 R08: 00007ffdf7478f20 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffdf7478f20
R13: 000055aeb1679008 R14: 00007ffdf7478f18 R15: 0000000000000000
task:in:imuxsock     state:S stack:27832 pid: 4271 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_hrtimeout_range_clock+0x333/0x380 kernel/time/hrtimer.c:2130
 poll_schedule_timeout.constprop.0+0x107/0x1e0 fs/select.c:243
 do_select+0x119c/0x1640 fs/select.c:603
 core_sys_select+0x3c3/0x960 fs/select.c:677
 kern_select+0x13d/0x1c0 fs/select.c:718
 __do_sys_select fs/select.c:725 [inline]
 __se_sys_select fs/select.c:722 [inline]
 __x64_sys_select+0xba/0x150 fs/select.c:722
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f4be4ef1603
Code: Unable to access opcode bytes at RIP 0x7f4be4ef15d9.
RSP: 002b:00007f4be3ba0d20 EFLAGS: 00000293 ORIG_RAX: 0000000000000017
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4be4ef1603
RDX: 0000000000000000 RSI: 00007f4be3ba0d40 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000004000001
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000001 R14: 00007f4be3ba0d40 R15: 0000000000000003
task:in:imklog       state:S stack:29032 pid: 4272 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 do_syslog.part.0+0x247/0x7d0 kernel/printk/printk.c:1611
 do_syslog+0x49/0x60 kernel/printk/printk.c:1596
 kmsg_read+0x90/0xb0 fs/proc/kmsg.c:40
 pde_read fs/proc/inode.c:321 [inline]
 proc_reg_read+0x119/0x300 fs/proc/inode.c:331
 vfs_read+0x1b5/0x570 fs/read_write.c:494
 ksys_read+0x12d/0x250 fs/read_write.c:634
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f4be5de322d
Code: Unable to access opcode bytes at RIP 0x7f4be5de3203.
RSP: 002b:00007f4be377f580 EFLAGS: 00000293 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4be5de322d
RDX: 0000000000001fa0 RSI: 00007f4be377fda0 RDI: 0000000000000004
RBP: 000055aeb2c5e9d0 R08: 0000000000000000 R09: 0000000000000000
R10: 2ce33e6c02ce33e7 R11: 0000000000000293 R12: 00007f4be377fda0
R13: 0000000000001fa0 R14: 0000000000001f9f R15: 00007f4be37802af
task:rs:main Q:Reg   state:S stack:27560 pid: 4274 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 freezable_schedule include/linux/freezer.h:172 [inline]
 futex_wait_queue_me+0x2a7/0x570 kernel/futex.c:2603
 futex_wait+0x1df/0x560 kernel/futex.c:2705
 do_futex+0x15b/0x1a70 kernel/futex.c:3764
 __do_sys_futex+0x2a2/0x470 kernel/futex.c:3827
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f4be5de017f
Code: Unable to access opcode bytes at RIP 0x7f4be5de0155.
RSP: 002b:00007f4be339ec70 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4be5de017f
RDX: 000000000000116b RSI: 0000000000000080 RDI: 000055aeb2c5b28c
RBP: 000055aeb2c5b288 R08: 000055aeb2c5b000 R09: 00000000000008b5
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4be339ecd0
R13: 0000000000000000 R14: 000055aeb1668290 R15: 0000000000000000
task:cron            state:S stack:24592 pid: 4266 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 freezable_schedule include/linux/freezer.h:172 [inline]
 do_nanosleep+0x1b1/0x660 kernel/time/hrtimer.c:1878
 hrtimer_nanosleep+0x1f9/0x430 kernel/time/hrtimer.c:1931
 __do_sys_nanosleep kernel/time/hrtimer.c:1965 [inline]
 __se_sys_nanosleep kernel/time/hrtimer.c:1952 [inline]
 __x64_sys_nanosleep+0x1dc/0x260 kernel/time/hrtimer.c:1952
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f6d46013270
Code: Unable to access opcode bytes at RIP 0x7f6d46013246.
RSP: 002b:00007ffc33f1adc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000023
RAX: ffffffffffffffda RBX: fffffffffffffeb0 RCX: 00007f6d46013270
RDX: 00007ffc33f3c080 RSI: 00007ffc33f1add0 RDI: 00007ffc33f1add0
RBP: 0000000000000002 R08: 0000000000000010 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc33f1af20 R14: 0000000000000000 R15: 0000000000000000
task:agetty          state:S stack:26744 pid: 4269 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_hrtimeout_range_clock+0x333/0x380 kernel/time/hrtimer.c:2130
 poll_schedule_timeout.constprop.0+0x107/0x1e0 fs/select.c:243
 do_select+0x119c/0x1640 fs/select.c:603
 core_sys_select+0x3c3/0x960 fs/select.c:677
 kern_select+0x13d/0x1c0 fs/select.c:718
 __do_sys_select fs/select.c:725 [inline]
 __se_sys_select fs/select.c:722 [inline]
 __x64_sys_select+0xba/0x150 fs/select.c:722
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fb3e26bc5e3
Code: Unable to access opcode bytes at RIP 0x7fb3e26bc5b9.
RSP: 002b:00007ffdb1411a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
RAX: ffffffffffffffda RBX: 00007ffdb1411a40 RCX: 00007fb3e26bc5e3
RDX: 0000000000000000 RSI: 00007ffdb1411b00 RDI: 0000000000000005
RBP: 00007ffdb1411a30 R08: 0000000000000000 R09: 00007ffdb1411ac0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdb1411a24
R13: 00007ffdb1411b80 R14: 00007ffdb1411a80 R15: 0000000000000000
task:agetty          state:S stack:26768 pid: 4270 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_hrtimeout_range_clock+0x333/0x380 kernel/time/hrtimer.c:2130
 poll_schedule_timeout.constprop.0+0x107/0x1e0 fs/select.c:243
 do_select+0x119c/0x1640 fs/select.c:603
 core_sys_select+0x3c3/0x960 fs/select.c:677
 kern_select+0x13d/0x1c0 fs/select.c:718
 __do_sys_select fs/select.c:725 [inline]
 __se_sys_select fs/select.c:722 [inline]
 __x64_sys_select+0xba/0x150 fs/select.c:722
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f858f6365e3
Code: Unable to access opcode bytes at RIP 0x7f858f6365b9.
RSP: 002b:00007ffc163ef098 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
RAX: ffffffffffffffda RBX: 00007ffc163ef0d0 RCX: 00007f858f6365e3
RDX: 0000000000000000 RSI: 00007ffc163ef190 RDI: 0000000000000005
RBP: 00007ffc163ef0c0 R08: 0000000000000000 R09: 00007ffc163ef150
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc163ef0b4
R13: 00007ffc163ef210 R14: 00007ffc163ef110 R15: 0000000000000000
task:agetty          state:S stack:24760 pid: 4275 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_hrtimeout_range_clock+0x333/0x380 kernel/time/hrtimer.c:2130
 poll_schedule_timeout.constprop.0+0x107/0x1e0 fs/select.c:243
 do_select+0x119c/0x1640 fs/select.c:603
 core_sys_select+0x3c3/0x960 fs/select.c:677
 kern_select+0x13d/0x1c0 fs/select.c:718
 __do_sys_select fs/select.c:725 [inline]
 __se_sys_select fs/select.c:722 [inline]
 __x64_sys_select+0xba/0x150 fs/select.c:722
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f5ac325b5e3
Code: Unable to access opcode bytes at RIP 0x7f5ac325b5b9.
RSP: 002b:00007ffe7f614f28 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
RAX: ffffffffffffffda RBX: 00007ffe7f614f60 RCX: 00007f5ac325b5e3
RDX: 0000000000000000 RSI: 00007ffe7f615020 RDI: 0000000000000005
RBP: 00007ffe7f614f50 R08: 0000000000000000 R09: 00007ffe7f614fe0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe7f614f44
R13: 00007ffe7f6150a0 R14: 00007ffe7f614fa0 R15: 0000000000000000
task:sshd            state:S stack:27640 pid: 4278 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_hrtimeout_range_clock+0x333/0x380 kernel/time/hrtimer.c:2130
 poll_schedule_timeout.constprop.0+0x107/0x1e0 fs/select.c:243
 do_select+0x119c/0x1640 fs/select.c:603
 core_sys_select+0x3c3/0x960 fs/select.c:677
 kern_select+0x13d/0x1c0 fs/select.c:718
 __do_sys_select fs/select.c:725 [inline]
 __se_sys_select fs/select.c:722 [inline]
 __x64_sys_select+0xba/0x150 fs/select.c:722
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f098a79d5e3
Code: Unable to access opcode bytes at RIP 0x7f098a79d5b9.
RSP: 002b:00007ffef3e113d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
RAX: ffffffffffffffda RBX: 0000564acc86ced0 RCX: 00007f098a79d5e3
RDX: 0000000000000000 RSI: 0000564acc86ced0 RDI: 0000000000000007
RBP: 0000000000000064 R08: 0000000000000000 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffef3e11654
R13: 0000000000000000 R14: 0000564acb0c8ce8 R15: 0000000000000063
task:agetty          state:S stack:24240 pid: 4279 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 schedule_hrtimeout_range_clock+0x333/0x380 kernel/time/hrtimer.c:2130
 poll_schedule_timeout.constprop.0+0x107/0x1e0 fs/select.c:243
 do_select+0x119c/0x1640 fs/select.c:603

