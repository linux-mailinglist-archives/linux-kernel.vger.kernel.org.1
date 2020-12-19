Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2C2DF02C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 16:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgLSPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 10:14:57 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:57312 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgLSPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 10:14:52 -0500
Received: by mail-il1-f199.google.com with SMTP id r20so5109080ilh.23
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 07:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oN43FYZmO6xBUFSKxc3nldqLgeGHsLmpTfBUrugOME8=;
        b=IWL6kz/XqDib7W7mJatvSVgruVJLrJ72DKn+lwFwZcXbVrypb450xyx399cSbhQ4WC
         mepg60wtH0c5uGdsE3SOgpnwozf/gM3yDxR5wvjdpu7DwKo09zjvPn0HSqp/PiWlkVr1
         s/6R/x6WobzB1ibi6BqD2X6N/8CX2he29/cN3ryhQxoC+GTCdIOXjnFAbwBb5LqHJA1l
         kHPHv/VoAf/9jNVs/Nr6cSier5O9IMy3Z12AuCzwQES0loHu8yKIyz7CPnHg6xkN6EJZ
         GD+pW29as7KNNvbiUUNkPJp/5aMrxhZVZRRtVV9IZIdibNY1ZCj7TQvW/WSc1qsTi8h4
         1z1Q==
X-Gm-Message-State: AOAM533nV+MscBjp+1B/y7OIwRh/FP3izY3CrFfFt9Vxd8+qjPzvCgWf
        8upqQkeNCZ7ngb2Fi7GMTzofFKXev3/mwMAlK//v16MH43g7
X-Google-Smtp-Source: ABdhPJwM4Zrf6u57VGpT45mk7KN8G4hw6KcAuHcQepJLdTjb941b9TG7L/PHC1f4OBYlx2/MpWRlwF/6IvNRG2gjZizpkwEpHUPe
MIME-Version: 1.0
X-Received: by 2002:a92:360a:: with SMTP id d10mr9480249ila.198.1608390851446;
 Sat, 19 Dec 2020 07:14:11 -0800 (PST)
Date:   Sat, 19 Dec 2020 07:14:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c4c2c05b6d2ad6d@google.com>
Subject: INFO: task can't die in lock_mount
From:   syzbot <syzbot+88a6c9cb23c5d25506d7@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0d52778b Add linux-next specific files for 20201218
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10b64333500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c81cc44aa25b5b3
dashboard link: https://syzkaller.appspot.com/bug?extid=88a6c9cb23c5d25506d7
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88a6c9cb23c5d25506d7@syzkaller.appspotmail.com

INFO: task syz-executor.2:16374 can't die for more than 143 seconds.
task:syz-executor.2  state:D stack:27224 pid:16374 ppid:  8541 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4327 [inline]
 __schedule+0x8eb/0x21b0 kernel/sched/core.c:5078
 schedule+0xcf/0x270 kernel/sched/core.c:5157
 rwsem_down_write_slowpath+0x809/0x1220 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x132/0x150 kernel/locking/rwsem.c:1407
 inode_lock include/linux/fs.h:773 [inline]
 lock_mount+0x8a/0x2e0 fs/namespace.c:2211
 do_new_mount_fc fs/namespace.c:2839 [inline]
 do_new_mount fs/namespace.c:2898 [inline]
 path_mount+0x1678/0x1e70 fs/namespace.c:3227
 do_mount fs/namespace.c:3240 [inline]
 __do_sys_mount fs/namespace.c:3448 [inline]
 __se_sys_mount fs/namespace.c:3425 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3425
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e149
RSP: 002b:00007f774260fc68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 000000000045e149
RDX: 0000000020002100 RSI: 00000000200020c0 RDI: 0000000000000000
RBP: 000000000119bfd0 R08: 0000000020002140 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00007ffe6071fc4f R14: 00007f77426109c0 R15: 000000000119bf8c
INFO: task syz-executor.2:16374 blocked for more than 143 seconds.
      Not tainted 5.10.0-next-20201218-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:27224 pid:16374 ppid:  8541 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4327 [inline]
 __schedule+0x8eb/0x21b0 kernel/sched/core.c:5078
 schedule+0xcf/0x270 kernel/sched/core.c:5157
 rwsem_down_write_slowpath+0x809/0x1220 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x132/0x150 kernel/locking/rwsem.c:1407
 inode_lock include/linux/fs.h:773 [inline]
 lock_mount+0x8a/0x2e0 fs/namespace.c:2211
 do_new_mount_fc fs/namespace.c:2839 [inline]
 do_new_mount fs/namespace.c:2898 [inline]
 path_mount+0x1678/0x1e70 fs/namespace.c:3227
 do_mount fs/namespace.c:3240 [inline]
 __do_sys_mount fs/namespace.c:3448 [inline]
 __se_sys_mount fs/namespace.c:3425 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3425
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e149
RSP: 002b:00007f774260fc68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 000000000045e149
RDX: 0000000020002100 RSI: 00000000200020c0 RDI: 0000000000000000
RBP: 000000000119bfd0 R08: 0000000020002140 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00007ffe6071fc4f R14: 00007f77426109c0 R15: 000000000119bf8c
INFO: task syz-executor.2:16381 can't die for more than 144 seconds.
task:syz-executor.2  state:R  running task     stack:27912 pid:16381 ppid:  8541 flags:0x00004006
Call Trace:
 context_switch kernel/sched/core.c:4327 [inline]
 __schedule+0x8eb/0x21b0 kernel/sched/core.c:5078
 preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:5238

Showing all locks held in the system:
1 lock held by khungtaskd/1666:
 #0: ffffffff8b793ae0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x28c kernel/locking/lockdep.c:6254
1 lock held by in:imklog/8371:
 #0: ffff8880213a0d70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:947
1 lock held by syz-executor.2/16374:
 #0: ffff88807e1b9c50 (&type->i_mutex_dir_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:773 [inline]
 #0: ffff88807e1b9c50 (&type->i_mutex_dir_key#8){++++}-{3:3}, at: lock_mount+0x8a/0x2e0 fs/namespace.c:2211
3 locks held by syz-executor.2/16381:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1666 Comm: khungtaskd Not tainted 5.10.0-next-20201218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x3c/0xef lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:147 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:253 [inline]
 watchdog+0xe75/0x1020 kernel/hung_task.c:338
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 4528 Comm: kworker/u4:6 Not tainted 5.10.0-next-20201218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:check_preemption_disabled+0x2/0x150 lib/smp_processor_id.c:13
Code: 00 00 8b 1d 98 cb 63 04 31 ff 89 de 0f 1f 44 00 00 85 db 75 ae 0f 1f 44 00 00 41 bc 01 00 00 00 e8 d3 a0 a3 fa eb 9f cc 41 56 <41> 55 49 89 f5 41 54 55 48 89 fd 53 0f 1f 44 00 00 65 44 8b 25 25
RSP: 0018:ffffc900092f7b68 EFLAGS: 00000282
RAX: 0000000000000001 RBX: 1ffff9200125ef76 RCX: ffffffff8158f0d8
RDX: 0000000000000001 RSI: ffffffff89bf9f00 RDI: ffffffff89bf9f40
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8d7e9bcf
R10: fffffbfff1afd379 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff8b793ae0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc49173000 CR3: 0000000011ffd000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rcu_lockdep_current_cpu_online kernel/rcu/tree.c:1161 [inline]
 rcu_lockdep_current_cpu_online+0x2d/0x150 kernel/rcu/tree.c:1152
 rcu_read_lock_held_common kernel/rcu/update.c:110 [inline]
 rcu_read_lock_held_common kernel/rcu/update.c:100 [inline]
 rcu_read_lock_sched_held+0x25/0x70 kernel/rcu/update.c:121
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x5d3/0x750 kernel/locking/lockdep.c:5408
 rcu_lock_acquire include/linux/rcupdate.h:259 [inline]
 rcu_read_lock include/linux/rcupdate.h:648 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:404 [inline]
 batadv_nc_worker+0x12d/0xe80 net/batman-adv/network-coding.c:715
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
