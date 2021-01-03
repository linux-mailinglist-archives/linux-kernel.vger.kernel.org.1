Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C2E2E8B74
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 10:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbhACI5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 03:57:54 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:50983 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbhACI5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 03:57:53 -0500
Received: by mail-il1-f197.google.com with SMTP id t8so24610223ils.17
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 00:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=czMF8+sgGc1H1dAhR2MSZKcWUVM9tD7P1gxxLYUuTpE=;
        b=hDKSSEEp8SYfoyPSOhYZ9ZvemLap7V9siCqirSjIJU2cW7NoGdwvcvawrFDCymQfGr
         /kj9tV9RtKTyJOTXpzxO2Df4is6+ch3PJ5y3Ikh01vOZUVgsR/r0hwRsFvzo24zqMzw+
         SWXTXyasjEaWMLIzc6ahDQmtVpQqRPqiYeY4bA2WRV2SgNSIKWcmy4AQiXVuIsl1JKaB
         al3UzbpWpgjCVizTXrIwWTOB7wKC2jJeDLAaCxT1DMWSqzCXwZNwlD2UfF6pWVRTaGjq
         /inzMHkcBk0Ts7hAHBlDAnUb7+HBo99s/HMbG6gJbQrURP62q18rwn4A9o1FIjCjXWw4
         SnKA==
X-Gm-Message-State: AOAM533SoQOdDPNc94fqo5+vWMWu+2SX1ulTyvDWDQQDzVavb4mLnOkO
        jRl/u46NEEj7O7ieGdTiUm4wQ+vKix8kfqWxdhRmkw0i1Cv+
X-Google-Smtp-Source: ABdhPJzixfUOl2XQyUwzeebAvACwsVpLGimZA4l28pB1+wV5ts1OyBoqjmKgquHTnctNAXIaiq3sEsX/6k4KxOIz28Tg/nnuxqAL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10c8:: with SMTP id s8mr42123534ilj.13.1609664232681;
 Sun, 03 Jan 2021 00:57:12 -0800 (PST)
Date:   Sun, 03 Jan 2021 00:57:12 -0800
In-Reply-To: <00000000000058e2f605b6d2ad46@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbf3eb05b7fb2834@google.com>
Subject: Re: INFO: rcu detected stall in ieee80211_tasklet_handler
From:   syzbot <syzbot+7bb955045fc0840decd3@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, hdanton@sina.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    3516bd72 Merge tag 's390-5.11-3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e9d077500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2455d075a1c4afa8
dashboard link: https://syzkaller.appspot.com/bug?extid=7bb955045fc0840decd3
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114c140b500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146750eb500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bb955045fc0840decd3@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (8387 ticks this GP) idle=6c6/1/0x4000000000000000 softirq=9854/9855 fqs=5094 
	(t=10501 jiffies g=9217 q=198)
NMI backtrace for cpu 1
CPU: 1 PID: 8914 Comm: syz-executor318 Not tainted 5.11.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x1e3/0x21e kernel/rcu/tree_stall.h:337
 print_cpu_stall kernel/rcu/tree_stall.h:569 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:643 [inline]
 rcu_pending kernel/rcu/tree.c:3751 [inline]
 rcu_sched_clock_irq.cold+0x472/0xec3 kernel/rcu/tree.c:2580
 update_process_times+0x16d/0x200 kernel/time/timer.c:1782
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1369
 __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
 __hrtimer_run_queues+0x1ce/0xea0 kernel/time/hrtimer.c:1583
 hrtimer_interrupt+0x334/0x940 kernel/time/hrtimer.c:1645
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1085 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1102
 run_sysvec_on_irqstack_cond arch/x86/include/asm/irq_stack.h:91 [inline]
 sysvec_apic_timer_interrupt+0x48/0x100 arch/x86/kernel/apic/apic.c:1096
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:628
RIP: 0010:queue_work_on+0x83/0xd0 kernel/workqueue.c:1530
Code: 31 ff 89 ee e8 ae dd 28 00 40 84 ed 74 46 e8 24 d7 28 00 31 ff 48 89 de e8 0a df 28 00 48 85 db 75 26 e8 10 d7 28 00 41 56 9d <48> 83 c4 08 44 89 f8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 f6 d6 28
RSP: 0018:ffffc90000d908a0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000100
RDX: ffff888023705340 RSI: ffffffff81499e80 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8ebda887
R10: fffffbfff1d7b510 R11: 0000000000000000 R12: ffff88801bc955b0
R13: ffff88801ca14000 R14: 0000000000000246 R15: 0000000000000001
 queue_work include/linux/workqueue.h:507 [inline]
 ieee80211_queue_work net/mac80211/util.c:932 [inline]
 ieee80211_queue_work+0x129/0x160 net/mac80211/util.c:925
 ieee80211_rx_h_mgmt net/mac80211/rx.c:3627 [inline]
 ieee80211_rx_handlers+0x3b86/0xae50 net/mac80211/rx.c:3793
 ieee80211_invoke_rx_handlers net/mac80211/rx.c:3823 [inline]
 ieee80211_prepare_and_rx_handle+0x2414/0x61c0 net/mac80211/rx.c:4503
 __ieee80211_rx_handle_packet net/mac80211/rx.c:4564 [inline]
 ieee80211_rx_list+0x1077/0x2430 net/mac80211/rx.c:4744
 ieee80211_rx_napi+0xf7/0x3d0 net/mac80211/rx.c:4767
 ieee80211_rx include/net/mac80211.h:4507 [inline]
 ieee80211_tasklet_handler+0xd4/0x130 net/mac80211/main.c:235
 tasklet_action_common.constprop.0+0x1d7/0x2d0 kernel/softirq.c:555
 __do_softirq+0x2a5/0x9f7 kernel/softirq.c:343
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0xaa/0xd0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:226 [inline]
 __irq_exit_rcu kernel/softirq.c:420 [inline]
 irq_exit_rcu+0x134/0x200 kernel/softirq.c:432
 sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1096
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:628
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x7/0x60 kernel/kcov.c:197
Code: 0f bd c8 49 8b 14 24 48 63 c9 e9 66 ff ff ff 4c 01 ca 49 89 13 e9 00 fd ff ff 66 0f 1f 84 00 00 00 00 00 65 8b 05 29 7a 8f 7e <89> c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b 14 25 00 f0 01 00 a9
RSP: 0018:ffffc90001e97768 EFLAGS: 00000202
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff888023705340
RDX: 0000000000000000 RSI: ffff888023705340 RDI: 0000000000000003
RBP: ffff88802f464000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81a441c3 R11: 0000000000000000 R12: 000000000000008d
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000424000
 __preempt_count_add arch/x86/include/asm/preempt.h:79 [inline]
 rcu_read_lock_sched_notrace include/linux/rcupdate.h:758 [inline]
 trace_rss_stat+0x180/0x290 include/trace/events/kmem.h:338
 mm_trace_rss_stat mm/memory.c:161 [inline]
 add_mm_counter include/linux/mm.h:1895 [inline]
 add_mm_rss_vec mm/memory.c:491 [inline]
 zap_pte_range mm/memory.c:1314 [inline]
 zap_pmd_range mm/memory.c:1368 [inline]
 zap_pud_range mm/memory.c:1397 [inline]
 zap_p4d_range mm/memory.c:1418 [inline]
 unmap_page_range+0x100e/0x2640 mm/memory.c:1439
 unmap_single_vma+0x198/0x300 mm/memory.c:1484
 unmap_vmas+0x168/0x2e0 mm/memory.c:1516
 exit_mmap+0x2b1/0x5a0 mm/mmap.c:3220
 __mmput+0x122/0x470 kernel/fork.c:1083
 mmput+0x53/0x60 kernel/fork.c:1104
 exit_mm kernel/exit.c:501 [inline]
 do_exit+0xb6a/0x2ae0 kernel/exit.c:812
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x3ec/0x2010 kernel/signal.c:2770
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44c2b9
Code: Unable to access opcode bytes at RIP 0x44c28f.
RSP: 002b:00007f9025121ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000048
RAX: 0000000000000000 RBX: 00000000006e8a08 RCX: 000000000044c2b9
RDX: 0000000000042000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00000000006e8a00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e8a0c
R13: 00007ffc7d12f4ff R14: 00007f90251229c0 R15: 20c49ba5e353f7cf

