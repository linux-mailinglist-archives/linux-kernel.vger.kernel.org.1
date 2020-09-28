Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ABB27A92B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgI1H6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:58:21 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:39732 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgI1H6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:58:21 -0400
Received: by mail-il1-f206.google.com with SMTP id r10so139814ilq.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lY3N4Y6bpJMRLAo1+GwN8vkahAthLO7e45DJgein+jQ=;
        b=D8dhQ2hCZBf4v1DnpslnFE08LeDWYQmipDnWUWRr4vbRj76MgxQhS2pCH8U8TZdE97
         phAVWn9wvechdfBBV8jlWrbUKhN3Iamtfq/VCPnlHmqZpLB7PlY/pupZuNa6mcJnJ9QX
         Lyj5sC1p4kDt9Lv9jLKsk2nsczqMwGxjmYRJMj59qRdGbS0Zu9DIEEd1gGUf/cjY4thF
         jNhsP9vj5/mWHANxHXDaqeJZGXai5D1kDcBMRd43uVokDHqZG7djbHgPBgAguGj0uFV+
         68B0HG6LwWOYDSZ8tsMQmc1l2m7CY3Xab9gb3XOmYPx0HExsH9VMeaJWrxTnM/Q5oy1u
         9R5w==
X-Gm-Message-State: AOAM531uwJ1BSU4MQ+dOE3lYQ1H1hZTdevXzwvkyuMsOSGRwhd4hW1Yr
        g6jyQDQP8rJVFkvNYdVI9RsCYIO4WuvktbeEJ4XWBLXgRY4n
X-Google-Smtp-Source: ABdhPJwrCvdyX4WTsOeMkucEz9yKhYQXxac2ymdN3cU6jy3qQzdrMww1AR+T0QlqeAyME7jO6c+nQYhvBLXqFP3LiyHaC7Mytu/p
MIME-Version: 1.0
X-Received: by 2002:a02:a615:: with SMTP id c21mr221098jam.106.1601279900289;
 Mon, 28 Sep 2020 00:58:20 -0700 (PDT)
Date:   Mon, 28 Sep 2020 00:58:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a48f9005b05b07c0@google.com>
Subject: BUG: unable to handle kernel paging request in wait_consider_task (2)
From:   syzbot <syzbot+966b8067ab848c33efca@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian@brauner.io,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92ab97ad Merge tag 'sh-for-5.9-part2' of git://git.libc.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d29c03900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ffe85b197a57c180
dashboard link: https://syzkaller.appspot.com/bug?extid=966b8067ab848c33efca
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+966b8067ab848c33efca@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffffffffff6c
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 9c90067 P4D 9c90067 PUD 9c92067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6884 Comm: syz-executor.0 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:wait_consider_task+0xae/0x3b70 kernel/exit.c:1269
Code: 8f 74 04 00 00 48 89 c8 48 89 4c 24 10 48 c1 e8 03 0f b6 14 28 48 89 c8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 4b 1d 00 00 <45> 8b a7 74 04 00 00 bf 10 00 00 00 44 89 e6 e8 ae e6 2e 00 41 83
RSP: 0018:ffffc900054b7b20 EFLAGS: 00010246
RAX: 0000000000000007 RBX: 0000000000000000 RCX: ffffffffffffff6c
RDX: 0000000000000000 RSI: ffffffff81475532 RDI: ffffc900054b7d20
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffffff89c09083
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900054b7d20
R13: ffff888063e72140 R14: 0000000000000000 R15: fffffffffffffaf8
FS:  000000000233f940(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffff6c CR3: 0000000063e39000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_wait_thread kernel/exit.c:1378 [inline]
 do_wait+0x376/0xa00 kernel/exit.c:1449
 kernel_wait4+0x14c/0x260 kernel/exit.c:1621
 __do_sys_wait4+0x13f/0x150 kernel/exit.c:1649
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x41723b
Code: 54 55 41 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 1b f9 ff ff 45 31 d2 41 89 c0 49 63 d4 48 89 ee 48 63 fb b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 19 44 89 c7 89 44 24 0c e8 51 f9 ff ff 8b 44
RSP: 002b:000000000169fd80 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 000000000041723b
RDX: 0000000040000001 RSI: 000000000169fde0 RDI: ffffffffffffffff
RBP: 000000000169fde0 R08: 0000000000000000 R09: 000000000233f940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000040000001
R13: 000000000169fde0 R14: 000000000011f778 R15: 000000000169fdf0
Modules linked in:
CR2: ffffffffffffff6c
---[ end trace d3ca074c7a3abcdb ]---
RIP: 0010:wait_consider_task+0xae/0x3b70 kernel/exit.c:1269
Code: 8f 74 04 00 00 48 89 c8 48 89 4c 24 10 48 c1 e8 03 0f b6 14 28 48 89 c8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 4b 1d 00 00 <45> 8b a7 74 04 00 00 bf 10 00 00 00 44 89 e6 e8 ae e6 2e 00 41 83
RSP: 0018:ffffc900054b7b20 EFLAGS: 00010246
RAX: 0000000000000007 RBX: 0000000000000000 RCX: ffffffffffffff6c
RDX: 0000000000000000 RSI: ffffffff81475532 RDI: ffffc900054b7d20
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffffff89c09083
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900054b7d20
R13: ffff888063e72140 R14: 0000000000000000 R15: fffffffffffffaf8
FS:  000000000233f940(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffff6c CR3: 0000000063e39000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
