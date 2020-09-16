Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E641D26BFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIPIw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:52:27 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:56876 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgIPIwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:52:16 -0400
Received: by mail-il1-f205.google.com with SMTP id d16so4951972ila.23
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OAgHdfruAsJTAzI/yEtv7cbrvBwi3BZoIR3ZG5AWboI=;
        b=s2rneXLeJ5/QYF6zUyajIkShvCzCmUk72AVS12kQXj0wcOsMKtFw0i5cO7IcUownhL
         3XETPxui/Mlz+RgtKr66BmKNfLYiwfiEH8DAAFMKApPzurinBBvjPPclxUGtO/knVNeE
         67nM9NajIzGRczFoZPGK2BJa3/qV5/gcwixX3/Xh7OTEwE3wCGN49Hvk38BlMgBz1axw
         mrrGLQglRXDU4J2o73vXw/subgbKqBhMwRE+z4RRoglRQa0XZkq2HpzIzgmmhyeMgwU6
         VTKwx/GKKJ12TMC/y2YDDjmkd5vzhY8cVgC5BGQl7FZuNatzgAjeOfoQLs0jbWxyo8Az
         Yl8w==
X-Gm-Message-State: AOAM533GIxr6n2NHg3kP9xgz30RDh4cHJ+m2ZUGQFke867KoVLyQpDeK
        osFAwVJBWZTehIneZWjMYmyQiobHeE37/JDmAuamuGDl/lge
X-Google-Smtp-Source: ABdhPJybi33fnYDhPpy1hgm6tGJPZWj2up8fptu/ycC2uOLcPm7JHWzNCbVFispExmFNXjDBFlBJnTO4KfR3OAjmEhlI62xukdeK
MIME-Version: 1.0
X-Received: by 2002:a5e:881a:: with SMTP id l26mr18125877ioj.51.1600246335528;
 Wed, 16 Sep 2020 01:52:15 -0700 (PDT)
Date:   Wed, 16 Sep 2020 01:52:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061eb3905af6a6253@google.com>
Subject: possible deadlock in pty_flush_buffer
From:   syzbot <syzbot+42469d6bea0bd00144ad@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fc4f28bb Merge tag 'for-5.9-rc5-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bb8555900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c61f6bd349c981f3
dashboard link: https://syzkaller.appspot.com/bug?extid=42469d6bea0bd00144ad
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+42469d6bea0bd00144ad@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.9.0-rc5-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/1625 is trying to acquire lock:
ffff88805c7f2580 (&tty->read_wait){....}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:122

but task is already holding lock:
ffff8880976c93b8 (&tty->ctrl_lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:379 [inline]
ffff8880976c93b8 (&tty->ctrl_lock){....}-{2:2}, at: pty_flush_buffer+0xaf/0x160 drivers/tty/pty.c:233

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&tty->ctrl_lock){....}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x94/0xce kernel/locking/spinlock.c:159
       __proc_set_tty+0x2c/0x610 drivers/tty/tty_jobctrl.c:98
       proc_set_tty drivers/tty/tty_jobctrl.c:121 [inline]
       tiocsctty drivers/tty/tty_jobctrl.c:384 [inline]
       tty_jobctrl_ioctl+0x43c/0x1010 drivers/tty/tty_jobctrl.c:546
       tty_ioctl+0x565/0x15f0 drivers/tty/tty_io.c:2651
       vfs_ioctl fs/ioctl.c:48 [inline]
       __do_sys_ioctl fs/ioctl.c:753 [inline]
       __se_sys_ioctl fs/ioctl.c:739 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&sighand->siglock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x94/0xce kernel/locking/spinlock.c:159
       __lock_task_sighand+0x106/0x2d0 kernel/signal.c:1390
       lock_task_sighand include/linux/sched/signal.h:687 [inline]
       task_work_add+0x1d7/0x290 kernel/task_work.c:51
       io_req_task_work_add fs/io_uring.c:1766 [inline]
       __io_async_wake+0x47b/0x9f0 fs/io_uring.c:4611
       __wake_up_common+0x147/0x650 kernel/sched/wait.c:93
       __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:123
       tty_ldisc_lock+0x40/0xb0 drivers/tty/tty_ldisc.c:336
       tty_set_ldisc+0x8e/0x670 drivers/tty/tty_ldisc.c:563
       tiocsetd drivers/tty/tty_io.c:2333 [inline]
       tty_ioctl+0xadf/0x15f0 drivers/tty/tty_io.c:2593
       tty_compat_ioctl+0x295/0x410 drivers/tty/tty_io.c:2818
       __do_compat_sys_ioctl+0x1d3/0x230 fs/ioctl.c:842
       do_syscall_32_irqs_on arch/x86/entry/common.c:78 [inline]
       __do_fast_syscall_32+0x60/0x90 arch/x86/entry/common.c:137
       do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
       entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

-> #0 (&tty->read_wait){....}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:2496 [inline]
       check_prevs_add kernel/locking/lockdep.c:2601 [inline]
       validate_chain kernel/locking/lockdep.c:3218 [inline]
       __lock_acquire+0x29bb/0x5570 kernel/locking/lockdep.c:4426
       lock_acquire+0x1f3/0xae0 kernel/locking/lockdep.c:5006
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x94/0xce kernel/locking/spinlock.c:159
       __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:122
       pty_flush_buffer+0x124/0x160 drivers/tty/pty.c:235
       tty_driver_flush_buffer drivers/tty/tty_ioctl.c:95 [inline]
       __tty_perform_flush+0x13f/0x210 drivers/tty/tty_ioctl.c:871
       n_tty_ioctl_helper+0x1c7/0x3a0 drivers/tty/tty_ioctl.c:937
       n_tty_ioctl+0x56/0x370 drivers/tty/n_tty.c:2466
       tty_ioctl+0x10c5/0x15f0 drivers/tty/tty_io.c:2665
       tty_compat_ioctl+0x2d4/0x410 drivers/tty/tty_io.c:2834
       __do_compat_sys_ioctl+0x1d3/0x230 fs/ioctl.c:842
       do_syscall_32_irqs_on arch/x86/entry/common.c:78 [inline]
       __do_fast_syscall_32+0x60/0x90 arch/x86/entry/common.c:137
       do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
       entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

other info that might help us debug this:

Chain exists of:
  &tty->read_wait --> &sighand->siglock --> &tty->ctrl_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tty->ctrl_lock);
                               lock(&sighand->siglock);
                               lock(&tty->ctrl_lock);
  lock(&tty->read_wait);

 *** DEADLOCK ***

2 locks held by syz-executor.4/1625:
 #0: ffff8880976c9098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:267
 #1: ffff8880976c93b8 (&tty->ctrl_lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:379 [inline]
 #1: ffff8880976c93b8 (&tty->ctrl_lock){....}-{2:2}, at: pty_flush_buffer+0xaf/0x160 drivers/tty/pty.c:233

stack backtrace:
CPU: 0 PID: 1625 Comm: syz-executor.4 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 check_noncircular+0x324/0x3e0 kernel/locking/lockdep.c:1827
 check_prev_add kernel/locking/lockdep.c:2496 [inline]
 check_prevs_add kernel/locking/lockdep.c:2601 [inline]
 validate_chain kernel/locking/lockdep.c:3218 [inline]
 __lock_acquire+0x29bb/0x5570 kernel/locking/lockdep.c:4426
 lock_acquire+0x1f3/0xae0 kernel/locking/lockdep.c:5006
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x94/0xce kernel/locking/spinlock.c:159
 __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:122
 pty_flush_buffer+0x124/0x160 drivers/tty/pty.c:235
 tty_driver_flush_buffer drivers/tty/tty_ioctl.c:95 [inline]
 __tty_perform_flush+0x13f/0x210 drivers/tty/tty_ioctl.c:871
 n_tty_ioctl_helper+0x1c7/0x3a0 drivers/tty/tty_ioctl.c:937
 n_tty_ioctl+0x56/0x370 drivers/tty/n_tty.c:2466
 tty_ioctl+0x10c5/0x15f0 drivers/tty/tty_io.c:2665
 tty_compat_ioctl+0x2d4/0x410 drivers/tty/tty_io.c:2834
 __do_compat_sys_ioctl+0x1d3/0x230 fs/ioctl.c:842
 do_syscall_32_irqs_on arch/x86/entry/common.c:78 [inline]
 __do_fast_syscall_32+0x60/0x90 arch/x86/entry/common.c:137
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f52549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f554c0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000000540b
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
