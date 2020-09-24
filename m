Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFEB276D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIXJ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:27:36 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:38541 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbgIXJ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:26:27 -0400
Received: by mail-io1-f79.google.com with SMTP id e21so1959674iod.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+LuhOMFNoKeY8ppqvg4ruohbMvs+mTUuo+9aV12ewiY=;
        b=NKnKzagFXusLPeewlWITrIftSchS4sGKa6MuHAgfPB3zJ2Q3lUF4oWJzWjNpDT9PSY
         fCHkg2zVaglvQyr6ChdxC5x9Nv/ZGCYis6V6mTizq6lO5QhR8qV/qlqyDLvtqXcUVrdY
         +98e5sk+o8vgZPzVBoONcu+RbWxYE+XqSAsxKjV37OcGFFrb3YSMjR3O5rljD+y12lIY
         4GSF+pzuZS/V7Ly0mLPBOPumdDrXIPp0vkYL6/r3EBZ1BOh841+9DlECFBzJlgiH+4yH
         u9kiGpYhrKn/HlMlUxbN67SnNKPNSM24eursaEvtEV6o3D3BsumDL6iih9hyOhtR743C
         Jb2A==
X-Gm-Message-State: AOAM530m5riJSoYfNDJkNWqdLglrC9/TglmHbc2g3NdsKFwFuf2HOsji
        1E/LIADN/1nZlOggXOOYispUAxqqSSz5ddfBkzZJKdf0aRB2
X-Google-Smtp-Source: ABdhPJzfyk/grlfr4i7yiAsnPeU5A8uR1iKS1udPEqMVDlTn/CPeThRa4uRXDcmHxfV6TC73eZxykU3sAKIFoPghJReTQ6fZD7NA
MIME-Version: 1.0
X-Received: by 2002:a5e:a705:: with SMTP id b5mr2588234iod.73.1600939585930;
 Thu, 24 Sep 2020 02:26:25 -0700 (PDT)
Date:   Thu, 24 Sep 2020 02:26:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000538f3205b00bcb06@google.com>
Subject: INFO: rcu detected stall in sys_exit_group (6)
From:   syzbot <syzbot+f04854e1c5c9e913cc27@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    805c6d3c Merge branch 'fixes' of git://git.kernel.org/pub/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11fef4e3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af502ec9a451c9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=f04854e1c5c9e913cc27
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d419c5900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1686b4bb900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f04854e1c5c9e913cc27@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
------------[ cut here ]------------
WARNING: CPU: 1 PID: 27130 at kernel/sched/core.c:3013 rq_unlock kernel/sched/sched.h:1325 [inline]
WARNING: CPU: 1 PID: 27130 at kernel/sched/core.c:3013 try_invoke_on_locked_down_task+0x12d/0x270 kernel/sched/core.c:3019
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 27130 Comm: syz-executor076 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 panic+0x2c0/0x800 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:try_invoke_on_locked_down_task+0x12d/0x270 kernel/sched/sched.h:1325
Code: f8 48 c1 e8 03 42 8a 04 38 84 c0 0f 85 10 01 00 00 8b 74 24 18 48 89 ef e8 90 47 09 00 4c 89 ef e8 48 4c fb 06 e9 a4 00 00 00 <0f> 0b e9 2b ff ff ff 48 c7 c1 34 d6 af 89 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc90000da8c50 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff888097326380 RCX: 6195009cdd28a200
RDX: ffffc90000da8d00 RSI: ffffffff8162e8d0 RDI: ffff888089c50500
RBP: ffffffff8162e8d0 R08: dffffc0000000000 R09: fffffbfff12df8f9
R10: fffffbfff12df8f9 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff896ff600 R14: ffff888089c50500 R15: dffffc0000000000
 rcu_print_task_stall kernel/rcu/tree_stall.h:267 [inline]
 print_other_cpu_stall kernel/rcu/tree_stall.h:475 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:634 [inline]
 rcu_pending kernel/rcu/tree.c:3637 [inline]
 rcu_sched_clock_irq+0x12bc/0x1eb0 kernel/rcu/tree.c:2519
 update_process_times+0x130/0x1b0 kernel/time/timer.c:1710
 tick_sched_handle kernel/time/tick-sched.c:176 [inline]
 tick_sched_timer+0x25e/0x410 kernel/time/tick-sched.c:1328
 __run_hrtimer kernel/time/hrtimer.c:1524 [inline]
 __hrtimer_run_queues+0x42d/0x930 kernel/time/hrtimer.c:1588
 hrtimer_interrupt+0x373/0xd60 kernel/time/hrtimer.c:1650
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0xf0/0x260 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0x94/0xf0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:770 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x63/0x90 kernel/locking/spinlock.c:191
Code: b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 0c 48 c7 c7 b8 17 6d 89 e8 cc 9b 68 f9 48 83 3d 3c d8 20 01 00 74 2a 4c 89 f7 57 9d <0f> 1f 44 00 00 bf 01 00 00 00 e8 4e a3 04 f9 65 8b 05 73 be b5 77
RSP: 0018:ffffc9000ad479a0 EFLAGS: 00000282
RAX: 1ffffffff12da2f7 RBX: ffffffff8bc9d3e8 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000282
RBP: 1ffff11010d98d45 R08: ffffffff817ad120 R09: fffffbfff1793a7e
R10: fffffbfff1793a7e R11: 0000000000000000 R12: ffff888084aa9000
R13: 0000000000000013 R14: 0000000000000282 R15: 0000000000000001
 __debug_check_no_obj_freed lib/debugobjects.c:977 [inline]
 debug_check_no_obj_freed+0x592/0x640 lib/debugobjects.c:998
 free_pages_prepare mm/page_alloc.c:1214 [inline]
 free_pcp_prepare+0x1f5/0x400 mm/page_alloc.c:1244
 free_unref_page_prepare mm/page_alloc.c:3099 [inline]
 free_unref_page_list+0xb0/0x550 mm/page_alloc.c:3168
 release_pages+0x13aa/0x1550 mm/swap.c:913
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0x780/0x910 mm/mmu_gather.c:249
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:328
 exit_mmap+0x296/0x550 mm/mmap.c:3185
 __mmput+0x113/0x370 kernel/fork.c:1076
 exit_mm+0x4cd/0x550 kernel/exit.c:483
 do_exit+0x576/0x1f20 kernel/exit.c:793
 do_group_exit+0x161/0x2d0 kernel/exit.c:903
 __do_sys_exit_group+0x13/0x20 kernel/exit.c:914
 __se_sys_exit_group+0x10/0x10 kernel/exit.c:912
 __x64_sys_exit_group+0x37/0x40 kernel/exit.c:912
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x443da8
Code: Bad RIP value.
RSP: 002b:00007ffcf8796618 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000443da8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004c3850 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d5180 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
