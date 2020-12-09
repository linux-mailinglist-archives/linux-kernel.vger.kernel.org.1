Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4482D4D25
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 22:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbgLIVxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 16:53:53 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:32927 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgLIVxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:53:52 -0500
Received: by mail-il1-f199.google.com with SMTP id j20so2683987ilk.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 13:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mWO9Fz7k1rrPc0FScWzq428C0n/Gy3elcGUpYOVjFvY=;
        b=IjSfu4iE6EjNtxHKxt7ZdIaMKIrd2Gusk8YHN+RRAEtp4I3X7pPt1cMY7MqmRt5zkT
         Lr3ifv4aRK2ANYM4FAsl2hXT3xsR9Wcz8UWGzfi9ZrhZTj1z4UB2pzq3S9ELFY1EvdYk
         m+AJSZF/NHs2mQKlWvU+7V4XJjnahoRM/5bOyUXKi+SMrwteDsM80i9dm92fypk9tj6U
         OMVaGotB1XzKw9U4yAUHw5gMW69qrNgWixXaxIjMIBSa7ww09FYgD9jQU7LzinkmKMrs
         Zcru6/A/JCFUubDb77xnnNqWS3oaBehKXfXiJ9RfJ4tN1Lt+hBeGjgNy8LZY7xGuDw3u
         ohoA==
X-Gm-Message-State: AOAM531/dm/Bt4Khasotr3eDCXm9tfXkByHTvgBodf4Mt47jUxoc6UpB
        zsvIrvVMxFwDd8jTfyaDEV7NhpTz8QOF4eyEIFz73s4cfEGf
X-Google-Smtp-Source: ABdhPJwCkoi8mgdH57L/sMUSPNpi+wsVuYV888y0kELxtOVA+OqnVkMyOGEyIWZTmo9iiao3i1YiCZIFSzp8xGIROuWqYBR6/XWg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:be7:: with SMTP id d7mr5942899ilu.81.1607550791552;
 Wed, 09 Dec 2020 13:53:11 -0800 (PST)
Date:   Wed, 09 Dec 2020 13:53:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e395b105b60f152b@google.com>
Subject: INFO: rcu detected stall in tasklet_action_common
From:   syzbot <syzbot+cdb28ae22d09b2142434@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b3298500 Merge tag 'for-5.10/dm-fixes' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135a07ab500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
dashboard link: https://syzkaller.appspot.com/bug?extid=cdb28ae22d09b2142434
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b43345500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102d68df500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdb28ae22d09b2142434@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (10194 ticks this GP) idle=25a/1/0x4000000000000000 softirq=8880/8882 fqs=1 
	(t=10502 jiffies g=8805 q=65)
rcu: rcu_preempt kthread starved for 10501 jiffies! g8805 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:29512 pid:   11 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3779 [inline]
 __schedule+0x893/0x2130 kernel/sched/core.c:4528
 schedule+0xcf/0x270 kernel/sched/core.c:4606
 schedule_timeout+0x148/0x250 kernel/time/timer.c:1871
 rcu_gp_fqs_loop kernel/rcu/tree.c:1925 [inline]
 rcu_gp_kthread+0xb4c/0x1c90 kernel/rcu/tree.c:2099
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
NMI backtrace for cpu 0
CPU: 0 PID: 8880 Comm: syz-executor561 Not tainted 5.10.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x1e3/0x21e kernel/rcu/tree_stall.h:331
 print_cpu_stall kernel/rcu/tree_stall.h:563 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:637 [inline]
 rcu_pending kernel/rcu/tree.c:3694 [inline]
 rcu_sched_clock_irq.cold+0x472/0xee8 kernel/rcu/tree.c:2567
 update_process_times+0x77/0xd0 kernel/time/timer.c:1709
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:176
 tick_sched_timer+0x1d1/0x2a0 kernel/time/tick-sched.c:1328
 __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
 __hrtimer_run_queues+0x1ce/0xea0 kernel/time/hrtimer.c:1583
 hrtimer_interrupt+0x334/0x940 kernel/time/hrtimer.c:1645
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1097
 run_sysvec_on_irqstack_cond arch/x86/include/asm/irq_stack.h:91 [inline]
 sysvec_apic_timer_interrupt+0x48/0x100 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
RIP: 0010:__ieee80211_rx_handle_packet net/mac80211/rx.c:4568 [inline]
RIP: 0010:ieee80211_rx_list+0x9fc/0x23d0 net/mac80211/rx.c:4759
Code: d2 0f 85 8d 17 00 00 48 8b 44 24 10 bf 50 00 00 00 0f b7 00 41 89 c4 66 89 44 24 08 66 41 81 e4 fc 00 44 89 e6 e8 e4 36 21 f9 <66> 41 83 fc 50 0f 84 be 11 00 00 e8 a4 3e 21 f9 44 89 e6 bf 80 00
RSP: 0018:ffffc90000007cb8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff884ec5cc
RDX: 0000000000000080 RSI: ffff88801b054ec0 RDI: 0000000000000003
RBP: ffff88801a9ae140 R08: 0000000000000001 R09: ffffc90000007d48
R10: 0000000000000050 R11: 0000000000000001 R12: 0000000000000080
R13: ffff88801a9ae140 R14: ffff88801a650c80 R15: ffffc90000007d48
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
 sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
RIP: 0010:__list_del_entry_valid+0xa/0xf0 lib/list_debug.c:39
Code: fd 48 8b 34 24 eb a1 48 89 f7 48 89 34 24 e8 dd 3c f7 fd 48 8b 34 24 eb b4 0f 1f 80 00 00 00 00 48 b8 00 00 00 00 00 fc ff df <41> 55 41 54 55 48 89 fd 48 83 c7 08 48 89 fa 48 c1 ea 03 80 3c 02
RSP: 0018:ffffc9000206fab0 EFLAGS: 00000293
RAX: dffffc0000000000 RBX: ffffc9000217fb70 RCX: ffffffff8163ffc3
RDX: ffff88801b054ec0 RSI: ffffffff83d03751 RDI: ffffc9000217fb88
RBP: ffffc9000217fb78 R08: 0000000000000001 R09: ffff88801be61a63
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000217fb88
R13: ffffc90000dfe148 R14: ffffc9000217fb90 R15: 00000000006e3000
 __list_del_entry include/linux/list.h:132 [inline]
 list_del_init include/linux/list.h:204 [inline]
 plist_del+0x1ad/0x480 lib/plist.c:130
 __unqueue_futex+0xc9/0x1b0 kernel/futex.c:1440
 mark_wake_futex+0x10f/0x1a0 kernel/futex.c:1458
 futex_wake+0x3b4/0x490 kernel/futex.c:1618
 do_futex+0x322/0x1a60 kernel/futex.c:3770
 __do_sys_futex+0x2a2/0x470 kernel/futex.c:3828
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x448969
Code: e8 4c 09 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 cb 05 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9c01bc6cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00000000006e39e8 RCX: 0000000000448969
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00000000006e39ec
RBP: 00000000006e39e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e39ec
R13: 00007ffd71e0be4f R14: 00007f9c01bc79c0 R15: 00000000006e39ec


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
