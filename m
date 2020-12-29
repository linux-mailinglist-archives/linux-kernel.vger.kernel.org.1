Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA662E7026
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgL2LtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:49:01 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:43353 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgL2Ls7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:48:59 -0500
Received: by mail-il1-f198.google.com with SMTP id p6so12592079ils.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 03:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JOZgCXpkUZswDNwQmwX9dSjR3h4q3CZh2nUlh1kJOFc=;
        b=OgqwpHA5fZYKp+iNx7NO9oBgDSPxcAp6USUu6RSrVZcv4MAHYcX125JJh6cw3s5dvk
         +qAh1JOJ3Z//iF9RdwKcboPq/27N7X4bjAIIf66dVCv8w5Bc+1vmLD4Ioxr6wykp8Zdu
         EFOQW0XfU6sO9GJPujlBB+Wz9lqG0Rjws0zLNCPpmlgD0ttaiAv+Sbh9x0viyQuATrCs
         wZhT4s2wEeikOW1zMYUwjMJ6rvp5P+MvntM+CvpZ/rNisef8fbOOwPr3CZG2yg0HBEuP
         jrN6BZGDlw1rYOOef0eCF2n5dM4l86Pk0HWjX6ASXkrpKiyYheQojdL7oPrtzkStA76c
         +WSg==
X-Gm-Message-State: AOAM531Cq4uPy5CCayBTF8802Fd+05s8MuBFLXePCaWCmKjOvdEYCeGk
        SxZ8lPhtpYXsIpO8GzQ1OtrlYzAjZwqfKAacIuzKporAq1b5
X-Google-Smtp-Source: ABdhPJzWAQgvIRQpeLp8MuL127xUxAfsC/IjBTyiLyMS8SJBETz2IwLwtlOu9Fqdg3X2+93wJPb++3vwvcQhVuNwm314KbplHJNB
MIME-Version: 1.0
X-Received: by 2002:a6b:c9cb:: with SMTP id z194mr39516938iof.110.1609242498310;
 Tue, 29 Dec 2020 03:48:18 -0800 (PST)
Date:   Tue, 29 Dec 2020 03:48:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078275b05b798f7df@google.com>
Subject: INFO: task hung in usbdev_open (2)
From:   syzbot <syzbot+b73659f5bb96fac34820@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5c8fe583 Linux 5.11-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ecd077500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6998cf893b79850
dashboard link: https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b73659f5bb96fac34820@syzkaller.appspotmail.com

INFO: task syz-executor.1:24596 blocked for more than 143 seconds.
      Not tainted 5.11.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:28136 pid:24596 ppid:  8491 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4313 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5064
 schedule+0xcf/0x270 kernel/sched/core.c:5143
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:5202
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x81a/0x1110 kernel/locking/mutex.c:1103
 device_lock include/linux/device.h:725 [inline]
 usbdev_open+0x19d/0x930 drivers/usb/core/devio.c:1029
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x11b0 fs/open.c:817
 do_open fs/namei.c:3254 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3371
 do_filp_open+0x17e/0x3c0 fs/namei.c:3398
 do_sys_openat2+0x16d/0x420 fs/open.c:1172
 do_sys_open fs/open.c:1188 [inline]
 __do_sys_open fs/open.c:1196 [inline]
 __se_sys_open fs/open.c:1192 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1192
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x417d91
RSP: 002b:00007f6b4f064810 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 0000000000417d91
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00007f6b4f064840
RBP: 000000000119bfc0 R08: 000000000000000f R09: 2330302f6273752f
R10: 00007f6b4f0659d0 R11: 0000000000000293 R12: 000000000119bf8c
R13: 00007ffcee50333f R14: 00007f6b4f0659c0 R15: 000000000119bf8c

Showing all locks held in the system:
2 locks held by kworker/u4:4/164:
 #0: ffff8880b9f34c58 (&rq->lock){-.-.}-{2:2}, at: newidle_balance+0x789/0xe50 kernel/sched/fair.c:10642
 #1: ffffc900015afda8 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15f0 kernel/workqueue.c:2250
1 lock held by khungtaskd/1660:
 #0: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6254
1 lock held by in:imklog/8320:
 #0: ffff8880153ced70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:949
2 locks held by rs:main Q:Reg/8325:
5 locks held by kworker/0:16/16221:
 #0: ffff888014df2538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888014df2538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888014df2538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888014df2538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888014df2538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888014df2538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x15f0 kernel/workqueue.c:2246
 #1: ffffc900166bfda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15f0 kernel/workqueue.c:2250
 #2: ffff888144c5e218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:725 [inline]
 #2: ffff888144c5e218 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c5/0x42d0 drivers/usb/core/hub.c:5537
 #3: ffff8880640a6578 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3030 [inline]
 #3: ffff8880640a6578 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5154 [inline]
 #3: ffff8880640a6578 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 #3: ffff8880640a6578 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5509 [inline]
 #3: ffff8880640a6578 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x216c/0x42d0 drivers/usb/core/hub.c:5591
 #4: ffff888144b57768 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_init+0x1b2/0x2dd0 drivers/usb/core/hub.c:4582
1 lock held by syz-executor.1/24596:
 #0: ffff888144c5e218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:725 [inline]
 #0: ffff888144c5e218 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x19d/0x930 drivers/usb/core/devio.c:1029

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1660 Comm: khungtaskd Not tainted 5.11.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd43/0xfa0 kernel/hung_task.c:294
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 164 Comm: kworker/u4:4 Not tainted 5.11.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:84 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:101 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:127 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:158 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:176 [inline]
RIP: 0010:check_memory_region+0xde/0x180 mm/kasan/generic.c:185
Code: 74 f2 48 89 c2 b8 01 00 00 00 48 85 d2 75 56 5b 5d 41 5c c3 48 85 d2 74 5e 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 50 80 38 00 <74> f2 eb d4 41 bc 08 00 00 00 48 89 ea 45 29 dc 4d 8d 1c 2c eb 0c
RSP: 0018:ffffc900015afa38 EFLAGS: 00000046
RAX: fffffbfff1d7ab0d RBX: fffffbfff1d7ab0e RCX: ffffffff81582ac7
RDX: fffffbfff1d7ab0e RSI: 0000000000000008 RDI: ffffffff8ebd5868
RBP: fffffbfff1d7ab0d R08: 0000000000000000 R09: ffffffff8ebd586f
R10: fffffbfff1d7ab0d R11: 0000000000000000 R12: 000000000000067c
R13: 0000000000000004 R14: dffffc0000000000 R15: ffff888011704108
FS:  0000000000000000(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f934008f010 CR3: 0000000010ed3000 CR4: 0000000000350ef0
Call Trace:
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 hlock_class kernel/locking/lockdep.c:198 [inline]
 check_wait_context kernel/locking/lockdep.c:4531 [inline]
 __lock_acquire+0x707/0x5500 kernel/locking/lockdep.c:4782
 lock_acquire kernel/locking/lockdep.c:5437 [inline]
 lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
 rcu_lock_acquire include/linux/rcupdate.h:253 [inline]
 rcu_read_lock include/linux/rcupdate.h:642 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:404 [inline]
 batadv_nc_worker+0x12d/0xe50 net/batman-adv/network-coding.c:715
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
