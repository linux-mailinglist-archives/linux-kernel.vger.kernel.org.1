Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD6028E037
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgJNMBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 08:01:41 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49703 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgJNMBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:01:25 -0400
Received: by mail-il1-f197.google.com with SMTP id h13so2164442ils.16
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 05:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XzIJ5uKUEljoZuh4aWSdQb8JjpeAstk+mgfzq2A+Xs0=;
        b=fRmBLk4pU29WQa0ZnkIft9SbG933fV8dH7oWQ+hyVQ89WUqV+WpsbsTTk7FDa455tm
         hC2X0rQB446IHHOcgeZkXgsxlS7MrU2XutVVnmxGei0vbUqth0RGRaScNp4ZJ62ZOk1B
         W6Fke9C8TkxXmVim+dfPad9SOW42vbIgOzHU//979f3ecrApnu4rCSqWHpq12rA6OkwF
         t1rSdSHCh+UjRJ2va8Atw7ihHEGfRP1K4EgdYNO+dMkVTev9rRM0uK3cmiypf9pKpbZy
         SrfPHK2ykk6mKXwIgRE1NvvzbiRw4JmB2RCqwEe6dhIVmmijq3k6HP3tO1DYz7HLaiFV
         8fKw==
X-Gm-Message-State: AOAM532D0WLOl5P5R0YOo8V+Uh08CmwKWwZjRhigsNAoFO5QaHUR2wj5
        R/bmdhYgJ6LaJlI17pGRsfKul+YKz3YKUKEDKjO7d6VDTtgX
X-Google-Smtp-Source: ABdhPJxeIZ39kr+kkCtq4j2rrCHoB/O6r+uHAL/pZCSwh8qfjY66vIHgJ4K+7ZhXmsrx/8Ag6HqDgWLhniVhTJe5RWUhBXU+y13h
MIME-Version: 1.0
X-Received: by 2002:a92:b503:: with SMTP id f3mr3617266ile.23.1602676884343;
 Wed, 14 Oct 2020 05:01:24 -0700 (PDT)
Date:   Wed, 14 Oct 2020 05:01:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061911f05b1a04adb@google.com>
Subject: INFO: trying to register non-static key in calculate_sigpending (2)
From:   syzbot <syzbot+8197be5a9c103a92a095@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, christian@brauner.io, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        oleg@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    da690031 Merge branch 'i2c/for-current' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10924af0500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
dashboard link: https://syzkaller.appspot.com/bug?extid=8197be5a9c103a92a095
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8197be5a9c103a92a095@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 28294 Comm: systemd-udevd Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 register_lock_class+0xf06/0x1520 kernel/locking/lockdep.c:893
 __lock_acquire+0xfd/0x2ae0 kernel/locking/lockdep.c:4320
 lock_acquire+0x148/0x720 kernel/locking/lockdep.c:5029
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
 _raw_spin_lock_irq+0xa6/0xc0 kernel/locking/spinlock.c:167
 spin_lock_irq include/linux/spinlock.h:379 [inline]
 calculate_sigpending+0x4b/0x80 kernel/signal.c:196
 ret_from_fork+0x8/0x30 arch/x86/entry/entry_64.S:279
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 28294 Comm: systemd-udevd Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__list_add_valid+0x27/0xc0 lib/list_debug.c:23
Code: cc cc cc 41 57 41 56 41 55 41 54 53 49 89 d6 49 89 f4 49 89 ff 49 bd 00 00 00 00 00 fc ff df 48 8d 5a 08 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 da 45 f2 fd 48 8b 13 4c 39 e2 75
RSP: 0018:ffffc90002637c60 EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000000008 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffff888000135508 RDI: ffff888093d37030
RBP: ffff8880001354c8 R08: dffffc0000000000 R09: fffff520004c6f86
R10: fffff520004c6f86 R11: 0000000000000000 R12: ffff888000135508
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888093d37030
FS:  00007fd162f298c0(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd161da9f60 CR3: 00000000a0a66000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_add include/linux/list.h:67 [inline]
 list_add include/linux/list.h:86 [inline]
 __add_wait_queue include/linux/wait.h:171 [inline]
 add_wait_queue+0x77/0x130 kernel/sched/wait.c:24
 ep_ptable_queue_proc+0x1a0/0x380 fs/eventpoll.c:1322
 poll_wait include/linux/poll.h:51 [inline]
 signalfd_poll+0xb5/0x190 fs/signalfd.c:66
 vfs_poll include/linux/poll.h:90 [inline]
 ep_item_poll fs/eventpoll.c:885 [inline]
 ep_insert fs/eventpoll.c:1551 [inline]
 do_epoll_ctl+0x1a2f/0x3680 fs/eventpoll.c:2228
 __do_sys_epoll_ctl fs/eventpoll.c:2281 [inline]
 __se_sys_epoll_ctl fs/eventpoll.c:2272 [inline]
 __x64_sys_epoll_ctl+0xfe/0x130 fs/eventpoll.c:2272
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fd161daa2aa
Code: 48 8b 0d f1 fb 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 e9 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d be fb 2a 00 f7 d8 64 89 01 48
RSP: 002b:00007fff5f0a8608 EFLAGS: 00000202 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 00007fff5f0a8700 RCX: 00007fd161daa2aa
RDX: 0000000000000003 RSI: 0000000000000001 RDI: 0000000000000004
RBP: 000055723c6ff028 R08: 0000000000000020 R09: 0000000000000018
R10: 00007fff5f0a86a8 R11: 0000000000000202 R12: 000055723c6ff010
R13: 000055723c713b00 R14: 0000000000000003 R15: 000000000000000e
Modules linked in:
---[ end trace 292889b8b04a67ad ]---
RIP: 0010:__list_add_valid+0x27/0xc0 lib/list_debug.c:23
Code: cc cc cc 41 57 41 56 41 55 41 54 53 49 89 d6 49 89 f4 49 89 ff 49 bd 00 00 00 00 00 fc ff df 48 8d 5a 08 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 da 45 f2 fd 48 8b 13 4c 39 e2 75
RSP: 0018:ffffc90002637c60 EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000000008 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffff888000135508 RDI: ffff888093d37030
RBP: ffff8880001354c8 R08: dffffc0000000000 R09: fffff520004c6f86
R10: fffff520004c6f86 R11: 0000000000000000 R12: ffff888000135508
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888093d37030
FS:  00007fd162f298c0(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd161da9f60 CR3: 00000000a0a66000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
