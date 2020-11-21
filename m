Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBAF2BBD1A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgKUEzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:55:19 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:49201 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgKUEzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:55:17 -0500
Received: by mail-il1-f200.google.com with SMTP id s74so9276307ili.16
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 20:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Bc8DJgBNhzyknhToDKlCX+JkuaB11Va6geaeIXU01nE=;
        b=iji7z7KcPcvZJQArc0ZQX9kTsU2Jwe7/cH0qb9+GR6FKmAe0vXIyk0rfzEk3eaKF7r
         QuAci7g0x/6uu6ka+nlMM7geU8mxwWT2ut9CScb39+cohVTrS1iMKQBSDbX9YIPk1jqi
         H6LBF+ZY1orY7OjM0ukFHQmcw2hE3T/mznatUCZAIBY2ZJWtHBy+G7vaV57VyLjVIO3L
         VoxLSDSLF7iCfGuqgKrykno8BmmA3UHY+7jVVOP4s/y5IWHK6v+OpqdQQhX/DBElqbM+
         RkoWUi5DjFp+ebBF0Ee9MruOR+dDq7X2UMFUnJF/XHpg1HnouySZudnlqLsd+SOWUaw1
         91Hg==
X-Gm-Message-State: AOAM533O9LQzFDQBVa4iG/qAL3Qks6QOLdklbe9k9eBCWG0J8KrS8tQ+
        OLg5tzNRzH4sdY1iy/WhE1AumrKAuTP5TjUK67uWwe7X2RTQ
X-Google-Smtp-Source: ABdhPJy7jTsYFQbu+2stHEviHh2ADsNbk/5yIIh45u18OZoQ1AtChCr2ehXwg0NxNJ5eVesTx/pC19Olx6poLQCbggKPqLZyD3TN
MIME-Version: 1.0
X-Received: by 2002:a6b:b2c4:: with SMTP id b187mr28358647iof.187.1605934515653;
 Fri, 20 Nov 2020 20:55:15 -0800 (PST)
Date:   Fri, 20 Nov 2020 20:55:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056928205b496c43b@google.com>
Subject: INFO: task hung in sync_inodes_sb (4)
From:   syzbot <syzbot+7d50f1e54a12ba3aeae2@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, emmanuel.grumbach@intel.com,
        johannes.berg@intel.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luciano.coelho@intel.com,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    03430750 Add linux-next specific files for 20201116
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17027fdc500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1c4c3f27041fdb8
dashboard link: https://syzkaller.appspot.com/bug?extid=7d50f1e54a12ba3aeae2
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124a8841500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a4fce2500000

The issue was bisected to:

commit c68df2e7be0c1238ea3c281fd744a204ef3b15a0
Author: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date:   Thu Sep 15 13:30:02 2016 +0000

    mac80211: allow using AP_LINK_PS with mac80211-generated TIM IE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1445e981500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1645e981500000
console output: https://syzkaller.appspot.com/x/log.txt?x=1245e981500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d50f1e54a12ba3aeae2@syzkaller.appspotmail.com
Fixes: c68df2e7be0c ("mac80211: allow using AP_LINK_PS with mac80211-generated TIM IE")

INFO: task syz-executor017:8513 blocked for more than 143 seconds.
      Not tainted 5.10.0-rc3-next-20201116-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor017 state:D stack:27448 pid: 8513 ppid:  8507 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4269 [inline]
 __schedule+0x890/0x2030 kernel/sched/core.c:5019
 schedule+0xcf/0x270 kernel/sched/core.c:5098
 wb_wait_for_completion+0x17b/0x230 fs/fs-writeback.c:209
 sync_inodes_sb+0x1a6/0x9d0 fs/fs-writeback.c:2559
 __sync_filesystem fs/sync.c:34 [inline]
 sync_filesystem fs/sync.c:67 [inline]
 sync_filesystem+0x15c/0x260 fs/sync.c:48
 generic_shutdown_super+0x70/0x370 fs/super.c:448
 kill_block_super+0x97/0xf0 fs/super.c:1446
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 deactivate_super+0xad/0xd0 fs/super.c:366
 cleanup_mnt+0x3a3/0x530 fs/namespace.c:1123
 task_work_run+0xdd/0x190 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x1f0/0x200 kernel/entry/common.c:199
 syscall_exit_to_user_mode+0x38/0x260 kernel/entry/common.c:274
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44e0e7
Code: Unable to access opcode bytes at RIP 0x44e0bd.
RSP: 002b:00007fff42061288 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00000000000cee4c RCX: 000000000044e0e7
RDX: 0000000000400be0 RSI: 0000000000000002 RDI: 00007fff42061330
RBP: 0000000000002142 R08: 0000000000000000 R09: 0000000000000009
R10: 0000000000000005 R11: 0000000000000206 R12: 00007fff420623e0
R13: 0000000001f67880 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
2 locks held by kworker/u4:5/225:
 #0: ffff8881413a4138 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881413a4138 ((wq_completion)writeback){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff8881413a4138 ((wq_completion)writeback){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff8881413a4138 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff8881413a4138 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff8881413a4138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x821/0x15a0 kernel/workqueue.c:2243
 #1: ffffc9000191fda8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x854/0x15a0 kernel/workqueue.c:2247
1 lock held by khungtaskd/1655:
 #0: ffffffff8b339ce0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6252
1 lock held by in:imklog/8188:
 #0: ffff888017c8f4f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:932
2 locks held by syz-executor017/8513:
 #0: ffff88801a8500e0 (&type->s_umount_key#49){+.+.}-{3:3}, at: deactivate_super+0xa5/0xd0 fs/super.c:365
 #1: ffff888143f5e708 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:344 [inline]
 #1: ffff888143f5e708 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x18c/0x9d0 fs/fs-writeback.c:2557

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1655 Comm: khungtaskd Not tainted 5.10.0-rc3-next-20201116-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:147 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:253 [inline]
 watchdog+0xd89/0xf30 kernel/hung_task.c:338
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_idle_do_entry+0x1c9/0x250 drivers/acpi/processor_idle.c:517


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
