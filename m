Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB07282F35
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 06:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgJEEKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 00:10:19 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50670 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJEEKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 00:10:19 -0400
Received: by mail-io1-f72.google.com with SMTP id b16so3998698iod.17
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 21:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=H3G64YbKC8mNIOfTTy/79JF2zYlL9T8S0wffFmb4i/U=;
        b=gXoGaMUiSr6EXaZWTms4SflsJExE7pIo4skFAnFSZqGxQHsY67cAA25SNNvG2oNJSH
         zPlnrQTdAYQ4fmWXEEfQHqb9TglIhKCI2rNDnHF9j1jyk786xl/o0VAYvinz+DIYl/4B
         EFuHi7CUm3KyvzYs7+Qt99tF49Gl2szunDMQCXYNcLe8uek6NI9kKkZwCoeJzvpu/y5p
         NMlWMP1pUs0GLbb66PlPveTTCnOWHa1wE517MH3BxIdyzfzEKqXbrtxSdnY2I0YWIk2Z
         odemJNeJ0zilqFBAk0UNWVflNYS6Tmdv9OCOMSb66KeXZE37WLOomQnrR6ixyVu6VYqv
         6qlQ==
X-Gm-Message-State: AOAM5313cIoAcXEqVYpEA3BEXI0uoE1BN/+9xLzIvstNVAGAnPYCiIwX
        YqlUSDkzd4xPJigf8kDThU0zCqjj5JNPj/phSzrqxw+QVm05
X-Google-Smtp-Source: ABdhPJzL3OuRg4GAfMldHFiSCflq+Y53Qxs7Hshr4Y/tzN4JjC7Pz8Ky7B7G8kZYvw3n8nqD2xTpQYdTHFKt8uPwVtG8YYuSPj9j
MIME-Version: 1.0
X-Received: by 2002:a02:602f:: with SMTP id i47mr11166344jac.30.1601871017428;
 Sun, 04 Oct 2020 21:10:17 -0700 (PDT)
Date:   Sun, 04 Oct 2020 21:10:17 -0700
In-Reply-To: <00000000000044f9f005affa7fb1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f84cce05b0e4a83e@google.com>
Subject: Re: INFO: task can't die in request_wait_answer
From:   syzbot <syzbot+ea48ca29949b1820e745@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    2172e358 Add linux-next specific files for 20201002
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1596c7a3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70698f530a7e856f
dashboard link: https://syzkaller.appspot.com/bug?extid=ea48ca29949b1820e745
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e1c8e7900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a166af900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea48ca29949b1820e745@syzkaller.appspotmail.com

INFO: task syz-executor220:7040 can't die for more than 143 seconds.
task:syz-executor220 state:D stack:28792 pid: 7040 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7040 blocked for more than 143 seconds.
      Not tainted 5.9.0-rc7-next-20201002-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor220 state:D stack:28792 pid: 7040 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7044 can't die for more than 143 seconds.
task:syz-executor220 state:D stack:28752 pid: 7044 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7044 blocked for more than 144 seconds.
      Not tainted 5.9.0-rc7-next-20201002-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor220 state:D stack:28752 pid: 7044 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7066 can't die for more than 144 seconds.
task:syz-executor220 state:D stack:29048 pid: 7066 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7066 blocked for more than 144 seconds.
      Not tainted 5.9.0-rc7-next-20201002-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor220 state:D stack:29048 pid: 7066 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7071 can't die for more than 144 seconds.
task:syz-executor220 state:D stack:29048 pid: 7071 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7071 blocked for more than 145 seconds.
      Not tainted 5.9.0-rc7-next-20201002-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor220 state:D stack:29048 pid: 7071 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7087 can't die for more than 145 seconds.
task:syz-executor220 state:D stack:29048 pid: 7087 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7087 blocked for more than 145 seconds.
      Not tainted 5.9.0-rc7-next-20201002-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor220 state:D stack:29048 pid: 7087 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7097 can't die for more than 145 seconds.
task:syz-executor220 state:D stack:28912 pid: 7097 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7097 blocked for more than 146 seconds.
      Not tainted 5.9.0-rc7-next-20201002-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor220 state:D stack:28912 pid: 7097 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7110 can't die for more than 146 seconds.
task:syz-executor220 state:D stack:29048 pid: 7110 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7110 blocked for more than 146 seconds.
      Not tainted 5.9.0-rc7-next-20201002-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor220 state:D stack:29048 pid: 7110 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7111 can't die for more than 147 seconds.
task:syz-executor220 state:D stack:29048 pid: 7111 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7111 blocked for more than 147 seconds.
      Not tainted 5.9.0-rc7-next-20201002-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor220 state:D stack:29048 pid: 7111 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7128 can't die for more than 147 seconds.
task:syz-executor220 state:D stack:29048 pid: 7128 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7128 blocked for more than 147 seconds.
      Not tainted 5.9.0-rc7-next-20201002-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor220 state:D stack:29048 pid: 7128 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7136 can't die for more than 148 seconds.
task:syz-executor220 state:D stack:29048 pid: 7136 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7136 blocked for more than 148 seconds.
      Not tainted 5.9.0-rc7-next-20201002-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor220 state:D stack:29048 pid: 7136 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7149 can't die for more than 148 seconds.
task:syz-executor220 state:D stack:28912 pid: 7149 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7164 can't die for more than 148 seconds.
task:syz-executor220 state:D stack:28912 pid: 7164 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7165 can't die for more than 149 seconds.
task:syz-executor220 state:D stack:29048 pid: 7165 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7178 can't die for more than 149 seconds.
task:syz-executor220 state:D stack:28912 pid: 7178 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7192 can't die for more than 149 seconds.
task:syz-executor220 state:D stack:28912 pid: 7192 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7199 can't die for more than 149 seconds.
task:syz-executor220 state:D stack:29048 pid: 7199 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7215 can't die for more than 150 seconds.
task:syz-executor220 state:D stack:29048 pid: 7215 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7224 can't die for more than 150 seconds.
task:syz-executor220 state:D stack:29048 pid: 7224 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7237 can't die for more than 150 seconds.
task:syz-executor220 state:D stack:29048 pid: 7237 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7241 can't die for more than 150 seconds.
task:syz-executor220 state:D stack:28912 pid: 7241 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7253 can't die for more than 151 seconds.
task:syz-executor220 state:D stack:29048 pid: 7253 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7267 can't die for more than 151 seconds.
task:syz-executor220 state:D stack:29048 pid: 7267 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7270 can't die for more than 151 seconds.
task:syz-executor220 state:D stack:28912 pid: 7270 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7281 can't die for more than 152 seconds.
task:syz-executor220 state:D stack:28912 pid: 7281 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7293 can't die for more than 152 seconds.
task:syz-executor220 state:D stack:28912 pid: 7293 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7310 can't die for more than 152 seconds.
task:syz-executor220 state:D stack:28648 pid: 7310 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7314 can't die for more than 152 seconds.
task:syz-executor220 state:D stack:29048 pid: 7314 ppid:  6888 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7342 can't die for more than 153 seconds.
task:syz-executor220 state:D stack:29048 pid: 7342 ppid:  6887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_do_getattr+0x226/0xc40 fs/fuse/dir.c:952
 fuse_update_get_attr fs/fuse/dir.c:988 [inline]
 fuse_getattr+0x37f/0x430 fs/fuse/dir.c:1723
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3148 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c99
Code: Bad RIP value.
RSP: 002b:00007fafe2cfedb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446c99
RDX: 0000000000446c99 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff48a82c7f R14: 00007fafe2cff9c0 R15: 0000000000000000
INFO: task syz-executor220:7349 can't die for more than 153 seconds.
task:syz-executor220 state:D stack:29048 pid: 7349 ppid:  6888 flags:0x00004004

