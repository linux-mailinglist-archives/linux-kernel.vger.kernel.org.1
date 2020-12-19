Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2092DF02A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 16:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgLSPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 10:14:53 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:42429 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgLSPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 10:14:52 -0500
Received: by mail-il1-f199.google.com with SMTP id p10so5135228ilo.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 07:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TbZT33P9YucusuHwRp7DXzJULOA88XnMslyj3q/FMCk=;
        b=e7BkKKdIyC+Q5Bb7jioOPyIoEfVlrXXBgy5QhpBNFN187Uoh2gHjziVkmLjl5N4by3
         PQ04JOo/CmZH+fHZBpC/gjFHQCkBlERZvbmJvC39NL8y8Nq1XSPD+uz21mnus8gKID1h
         3rWLNVyW1OKpR7/SRGpyydKPupPQHztTQGKdBoI8IvqXlQAaWxadfNsOuhwX9qX/LeZe
         d3zpFkUDjGg9aWliduYu4k0nKvpz24J8xy0X31MWuRaXUYmlWtA983a0rvJ1iGqA1U2s
         BxSrckc7P3tBGGF8hRrdqMeR95QXgHVe57jYhQimUFJamKKZ8gWs30/pH48QejB+UwdA
         qsuw==
X-Gm-Message-State: AOAM532nC+YAmSYoQCKiLTT/LSbhinyFWTGfVjWMhb9/gedOfaRM9gUN
        cwwFSlsX4qK3ju6DVWeiEXuLb/OylaVJIEWBceD/I6Z2zF6g
X-Google-Smtp-Source: ABdhPJw4wRpofHqylfE6vE1ckcqV6zmstnH6azePizpuKZutmbYUbUsB2up3cC8xaufzMHqsuh7cPUuSc3ze8uvBY4fz+Y0BC3ax
MIME-Version: 1.0
X-Received: by 2002:a6b:b8d6:: with SMTP id i205mr8377575iof.135.1608390851223;
 Sat, 19 Dec 2020 07:14:11 -0800 (PST)
Date:   Sat, 19 Dec 2020 07:14:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058e2f605b6d2ad46@google.com>
Subject: INFO: rcu detected stall in ieee80211_tasklet_handler
From:   syzbot <syzbot+7bb955045fc0840decd3@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    148842c9 Merge tag 'x86-apic-2020-12-14' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f86c93500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e26d08f66b19a15
dashboard link: https://syzkaller.appspot.com/bug?extid=7bb955045fc0840decd3
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110c0613500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bb955045fc0840decd3@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (10498 ticks this GP) idle=efa/1/0x4000000000000000 softirq=19185/19191 fqs=5250 
	(t=10502 jiffies g=23877 q=34)
NMI backtrace for cpu 1
CPU: 1 PID: 10164 Comm: syz-executor.0 Not tainted 5.10.0-syzkaller #0
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
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1376
 __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
 __hrtimer_run_queues+0x1ce/0xea0 kernel/time/hrtimer.c:1583
 hrtimer_interrupt+0x334/0x940 kernel/time/hrtimer.c:1645
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1085 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1102
 run_sysvec_on_irqstack_cond arch/x86/include/asm/irq_stack.h:91 [inline]
 sysvec_apic_timer_interrupt+0x48/0x100 arch/x86/kernel/apic/apic.c:1096
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:628
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/irqflags.h:85 [inline]
RIP: 0010:lock_acquire kernel/locking/lockdep.c:5440 [inline]
RIP: 0010:lock_acquire+0x2c7/0x740 kernel/locking/lockdep.c:5402
Code: 48 c7 c7 20 68 4b 89 48 83 c4 20 e8 43 fc 8f 07 b8 ff ff ff ff 65 0f c1 05 26 6f ab 7e 83 f8 01 0f 85 36 03 00 00 ff 34 24 9d <e9> 3a fe ff ff 65 ff 05 8d 5d ab 7e 48 8b 05 86 51 82 0b e8 61 f1
RSP: 0018:ffffc90000d90810 EFLAGS: 00000246
RAX: 0000000000000001 RBX: 1ffff920001b2104 RCX: 0000000000000001
RDX: 1ffff1100242cb38 RSI: 0000000000000302 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8ebb083f
R10: fffffbfff1d76107 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8880275114b8 R14: 0000000000000000 R15: 0000000000000000
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
 spin_lock_bh include/linux/spinlock.h:359 [inline]
 ieee80211_rx_handlers+0xd7/0xae50 net/mac80211/rx.c:3769
 ieee80211_invoke_rx_handlers net/mac80211/rx.c:3834 [inline]
 ieee80211_prepare_and_rx_handle+0x2482/0x6360 net/mac80211/rx.c:4518
 __ieee80211_rx_handle_packet net/mac80211/rx.c:4579 [inline]
 ieee80211_rx_list+0xdf3/0x23d0 net/mac80211/rx.c:4759
 ieee80211_rx_napi+0xf7/0x3d0 net/mac80211/rx.c:4780
 ieee80211_rx include/net/mac80211.h:4502 [inline]
 ieee80211_tasklet_handler+0xd3/0x130 net/mac80211/main.c:235
 tasklet_action_common.constprop.0+0x22f/0x2d0 kernel/softirq.c:560
 __do_softirq+0x2a0/0x9f6 kernel/softirq.c:298
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0xaa/0xd0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:393 [inline]
 __irq_exit_rcu kernel/softirq.c:423 [inline]
 irq_exit_rcu+0x132/0x200 kernel/softirq.c:435
 sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1096
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:628
RIP: 0010:__tlb_remove_page_size+0x38/0x420 mm/mmu_gather.c:70
Code: 89 fb e8 1b 5b cb ff 48 8d 7b 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 5b 03 00 00 48 8b 6b 18 <31> ff 48 89 ee e8 5e 53 cb ff 48 85 ed 0f 84 8b 01 00 00 e8 e0 5a
RSP: 0018:ffffc9000a15f760 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffffc9000a15fa60 RCX: ffffffff81a1cc28
RDX: 1ffff9200142bf4f RSI: ffffffff81a52265 RDI: ffffc9000a15fa78
RBP: ffffffffffffffff R08: 0000000000000000 R09: ffffea0000cc0047
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8880139a30e8 R14: ffffea0000cc0740 R15: 000000000101e000
 __tlb_remove_page include/asm-generic/tlb.h:438 [inline]
 zap_pte_range mm/memory.c:1256 [inline]
 zap_pmd_range mm/memory.c:1357 [inline]
 zap_pud_range mm/memory.c:1386 [inline]
 zap_p4d_range mm/memory.c:1407 [inline]
 unmap_page_range+0xea7/0x2640 mm/memory.c:1428
 unmap_single_vma+0x198/0x300 mm/memory.c:1473
 unmap_vmas+0x168/0x2e0 mm/memory.c:1505
 exit_mmap+0x2b1/0x530 mm/mmap.c:3220
 __mmput+0x122/0x470 kernel/fork.c:1081
 mmput+0x53/0x60 kernel/fork.c:1102
 exit_mm kernel/exit.c:500 [inline]
 do_exit+0xaa9/0x29f0 kernel/exit.c:810
 do_group_exit+0x125/0x310 kernel/exit.c:920
 get_signal+0x42a/0x1fb0 kernel/signal.c:2792
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x124/0x200 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x460fba
Code: Unable to access opcode bytes at RIP 0x460f90.
RSP: 002b:00007f178679cc48 EFLAGS: 00000246 ORIG_RAX: 00000000000000e4
RAX: 0000000000000000 RBX: 00000000004cd6bc RCX: 0000000000460fba
RDX: 0000000000503b20 RSI: 00007f178679cc50 RDI: 0000000000000001
RBP: 000000000119bf80 R08: 000000000000000e R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 000000000119bf8c
R13: 00007fff5143dfdf R14: 00007f178679d9c0 R15: 000000000119bf8c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
