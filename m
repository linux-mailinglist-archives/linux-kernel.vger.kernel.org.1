Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAFB2E2F64
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 00:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgLZXZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 18:25:56 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:35815 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgLZXZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 18:25:55 -0500
Received: by mail-il1-f198.google.com with SMTP id p6so6480565ilb.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 15:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LrThqGyzo8a3PO2YCcfqnTJ8Bb0QQNPRdMXQq4MJFWI=;
        b=YIgK3Tija9uj4xPNLyW+JucPy+y9ql4fnySVpzQ+G7aGc1TdDSvoiF/dRjiNAVCbZI
         7zFt9RbK/QOeg2IgOmHoTq1UVRCHqrZ2Lm35e7BtHdJT/Pi1cgQy/saH8Gwu/pd7NrT4
         fKwfIVsSLv53t7hSZFr91XGZlCO3lCTBKNPyz/ryHDZq+gWszmhdhuiMiygI331tD1sA
         PvWeNpLKc6pYGq7niqgKnyM4aV7gej/p/Bze59dDpBcZfC7zjag8cx2IxyfnCQDGk9Ks
         AMmF/P1JwLaAt6rfRwcp59OYRBqjLA1wvC7tUnQxqCxJSgMIMNFUYS0KmIVKrwvqZ4dL
         IK1Q==
X-Gm-Message-State: AOAM53258gpfmyCvGe8bWcbDVxPV8IbOJMFr4flvw2FkVP3I2xtqEQyz
        iHiu3te9jOO3kR7yLf+HFol8Rfr/HxCuXzKGa0qekpury+8r
X-Google-Smtp-Source: ABdhPJyfHunifRnlwEvrbHQ/szo7gADF0UT73pnWKcuVDpE+hgLpNrglWwPjdcoGo9szIePWMFY55GqOKzKdRI38f7ntfTBg7INr
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c48:: with SMTP id x8mr32477673iov.24.1609025114130;
 Sat, 26 Dec 2020 15:25:14 -0800 (PST)
Date:   Sat, 26 Dec 2020 15:25:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ccf1b05b7665adc@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in call_rcu
From:   syzbot <syzbot+9d3ede723bdc58553f13@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        vvs@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    614cb589 Merge tag 'acpi-5.11-rc1-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a82a50d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf519e1e96191576
dashboard link: https://syzkaller.appspot.com/bug?extid=9d3ede723bdc58553f13
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11830e93500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d92057500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d3ede723bdc58553f13@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 2d993067 P4D 2d993067 PUD 19a3c067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3852 Comm: kworker/1:2 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events free_ipc
RIP: 0010:kasan_record_aux_stack+0x77/0xb0 mm/kasan/generic.c:341
Code: 48 f7 fe 8b 47 24 49 89 f0 48 29 d3 8d 70 ff 41 0f af f0 48 01 ce 48 39 f3 48 0f 46 f3 e8 81 e9 ff ff bf 00 08 00 00 48 89 c3 <8b> 40 08 89 43 0c e8 1e e6 ff ff 89 43 08 5b c3 48 8b 50 08 48 c7
RSP: 0018:ffffc90002e6fae8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888039800000
RDX: 0000000000000078 RSI: ffff888039800000 RDI: 0000000000000800
RBP: ffffffff837ef3a0 R08: 0000000000400000 R09: 000000000000002e
R10: ffffffff8132b7ea R11: 000000000000003f R12: 0000000000035b40
R13: ffff888039800088 R14: ffffc90002e6fc08 R15: 0000000000000200
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000011841000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __call_rcu kernel/rcu/tree.c:2965 [inline]
 call_rcu+0xbb/0x710 kernel/rcu/tree.c:3038
 ipc_rcu_putref+0x83/0xb0 ipc/util.c:505
 freeary+0x139c/0x1b30 ipc/sem.c:1188
 free_ipcs+0x98/0x1e0 ipc/namespace.c:112
 sem_exit_ns+0x1b/0x40 ipc/sem.c:260
 free_ipc_ns ipc/namespace.c:124 [inline]
 free_ipc+0xf8/0x200 ipc/namespace.c:141
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Modules linked in:
CR2: 0000000000000008
---[ end trace 28dc093e61d44dc2 ]---
RIP: 0010:kasan_record_aux_stack+0x77/0xb0 mm/kasan/generic.c:341
Code: 48 f7 fe 8b 47 24 49 89 f0 48 29 d3 8d 70 ff 41 0f af f0 48 01 ce 48 39 f3 48 0f 46 f3 e8 81 e9 ff ff bf 00 08 00 00 48 89 c3 <8b> 40 08 89 43 0c e8 1e e6 ff ff 89 43 08 5b c3 48 8b 50 08 48 c7
RSP: 0018:ffffc90002e6fae8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888039800000
RDX: 0000000000000078 RSI: ffff888039800000 RDI: 0000000000000800
RBP: ffffffff837ef3a0 R08: 0000000000400000 R09: 000000000000002e
R10: ffffffff8132b7ea R11: 000000000000003f R12: 0000000000035b40
R13: ffff888039800088 R14: ffffc90002e6fc08 R15: 0000000000000200
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000011841000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
