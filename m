Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7955A2DB49F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgLOTow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:44:52 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:54142 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgLOTow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:44:52 -0500
Received: by mail-il1-f198.google.com with SMTP id q2so17403772ilt.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 11:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bnMQHyVuNRW4FmDtS5jLqA8xqV27SF2laNKFgWIyJ60=;
        b=ncvb8IvWhURjP6q1d8mWdk04BHAiA57pVdKcvaeE/u5xwEq2Trid+rbsYi6V07wl7H
         ICkEkQUh/Gf5Ygch0bRsfrri09uIYxwELFgov3/E57icowhoChwtCuoZgHzGsvI2A36x
         eqycxH3H7949aszGe9CHdjG4SSv50OUgOqmrmaotr+R9aWI8LloUANguhKngCrVL8U8g
         ffrAoK4wVi1FewqMk9Rol0brCzH3Pam49tTZDB01G5x6xi3dL9+XgGjsYV80w7svzbMw
         yVrEyMOuWS5BzF7AaATfXjifDtV+hWjxWvX01e1TcM58hOr1jxw47otWCtmRUF+HMVzF
         nSaw==
X-Gm-Message-State: AOAM5334tSW9NcpKYy1Gh2FEd//8ncCWCy2aTsCxl8KuHzWkmp4gUDtu
        MsV0ySLsqqgFwruSuXkV6p/Y9J5FkFgOyAPwCA8cU2IwFFZo
X-Google-Smtp-Source: ABdhPJzwA7dicc5MhZCrRZgL2ltk2V41+udHzdm+rmSSy4b6C1Ub8MnunhwiiMxMrB6OdvgQbTQWwotwaGq3ACaJuIwRNB6WFqUU
MIME-Version: 1.0
X-Received: by 2002:a92:9881:: with SMTP id a1mr43456337ill.238.1608061451022;
 Tue, 15 Dec 2020 11:44:11 -0800 (PST)
Date:   Tue, 15 Dec 2020 11:44:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090b89c05b685fb6d@google.com>
Subject: INFO: rcu detected stall in dput (4)
From:   syzbot <syzbot+d4d47d10526314a4f4cb@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    33dc9614 Merge tag 'ktest-v5.10-rc6' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1426d433500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3416bb960d5c705d
dashboard link: https://syzkaller.appspot.com/bug?extid=d4d47d10526314a4f4cb
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179a240f500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c81937500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4d47d10526314a4f4cb@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (10493 ticks this GP) idle=4ae/1/0x4000000000000000 softirq=20089/20090 fqs=0 
	(t=10500 jiffies g=24993 q=7)
rcu: rcu_preempt kthread starved for 10500 jiffies! g24993 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
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
CPU: 0 PID: 14966 Comm: syz-executor610 Not tainted 5.10.0-rc7-syzkaller #0
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
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_sysvec_on_irqstack arch/x86/include/asm/irq_stack.h:37 [inline]
 run_sysvec_on_irqstack_cond arch/x86/include/asm/irq_stack.h:89 [inline]
 sysvec_apic_timer_interrupt+0xbd/0x100 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
RIP: 0010:kvm_wait arch/x86/kernel/kvm.c:854 [inline]
RIP: 0010:kvm_wait+0x9c/0xd0 arch/x86/kernel/kvm.c:831
Code: 02 48 89 da 83 e2 07 38 d0 7f 04 84 c0 75 32 0f b6 03 41 38 c4 75 13 e8 32 52 46 00 e9 07 00 00 00 0f 00 2d 96 06 19 08 fb f4 <e8> 1f 52 46 00 eb af c3 e9 07 00 00 00 0f 00 2d 80 06 19 08 f4 eb
RSP: 0018:ffffc9000ab97c90 EFLAGS: 00000202
RAX: 000000000000acef RBX: ffff88814221fb08 RCX: ffffffff8155a917
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000246 R08: 0000000000000001 R09: ffffffff8ebaf69f
R10: fffffbfff1d75ed3 R11: 0000000000000000 R12: 0000000000000003
R13: ffffed1028443f61 R14: 0000000000000001 R15: ffff8880b9e356c0
 pv_wait arch/x86/include/asm/paravirt.h:564 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x8b8/0xb40 kernel/locking/qspinlock.c:508
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:554 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]
 do_raw_spin_lock+0x200/0x2b0 kernel/locking/spinlock_debug.c:113
 spin_lock include/linux/spinlock.h:354 [inline]
 dentry_kill fs/dcache.c:710 [inline]
 dput+0x941/0xbc0 fs/dcache.c:878
 __fput+0x3ab/0x920 fs/file_table.c:294
 task_work_run+0xdd/0x190 kernel/task_work.c:151
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:164 [inline]
 exit_to_user_mode_prepare+0x17e/0x1a0 kernel/entry/common.c:191
 syscall_exit_to_user_mode+0x38/0x260 kernel/entry/common.c:266
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x406b01
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 24 1a 00 00 c3 48 83 ec 08 e8 6a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 b3 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffde6771d20 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007ffde6771d60 RCX: 0000000000406b01
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000004 R08: 0000006400000340 R09: 0000006400000340
R10: 00007ffde6771d60 R11: 0000000000000293 R12: 000000000000002d
R13: 0000000000000006 R14: 00000000006e2a1c R15: 0000000000000001


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
