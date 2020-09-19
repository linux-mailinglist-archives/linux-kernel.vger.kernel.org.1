Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28720270F03
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 17:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgISPaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 11:30:21 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:40892 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgISPaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 11:30:21 -0400
Received: by mail-il1-f198.google.com with SMTP id g188so7215520ilh.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 08:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=D4+7jk2RQylbKFHcrada+X46KPBZCO1gaZmvvVtlxHk=;
        b=Jw79ev/JMh+NC98aoeUwh6Q8yZI6UexxTk1agOvzL+Q0LXf1jlkLBWNfK7KSyihNzt
         hbSEKxoUiEmh7FroosUJvugeDIXH4/d5mBLwYabdpFHBoVzDoUfbOTmNwQePmUZ/crxL
         A9Y62SjL5U2+WuGDHrsiDhnnaAZ/UAOkTXtKcyniYEfXtF1pqQAx7F1cqY561o85zoye
         ynhl2pmsCAqDXY5U1pD+npzeRl0g4TwYSFj5IcnDhLHC0LJh6j47GQJ8CYHxAZCGvp/+
         l8teLw2DaruVKGbAzQ2HFFDSfHKBunbRXcj3FoUDEtQtW28xaltq5GuOXRd/bKavQSwd
         75GQ==
X-Gm-Message-State: AOAM530y5EAHJOJSrK2m6iCPTtlCiF8m21HApW1opDHeyGh0qcvBbxVa
        PQranQeZ3B4wOBsz5zhUQKxw6pKel446oD4p89/w8VFIsVEq
X-Google-Smtp-Source: ABdhPJyfDXDvTZ3Mlz1Oc44FuZ81W0ygXIbE6z3JVXP2CMdJ7a6IAEnl+EthMG6+LNRgfed/tyrAeM50VSAujcRVJIKhAO9V9tcy
MIME-Version: 1.0
X-Received: by 2002:a05:6638:248d:: with SMTP id x13mr35209410jat.39.1600529418725;
 Sat, 19 Sep 2020 08:30:18 -0700 (PDT)
Date:   Sat, 19 Sep 2020 08:30:18 -0700
In-Reply-To: <001a113eba282f2ffc0568b76123@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074af4c05afac4b76@google.com>
Subject: Re: kernel BUG at fs/reiserfs/journal.c:LINE!
From:   syzbot <syzbot+6820505ae5978f4f8f2f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        axboe@kernel.dk, baijiaju1990@gmail.com, colin.king@canonical.com,
        dhowells@redhat.com, gregkh@linuxfoundation.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        rdunlap@infradead.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yanaijie@huawei.com,
        zhengbin13@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    eb5f95f1 Merge tag 's390-5.9-6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127b7809900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ffe85b197a57c180
dashboard link: https://syzkaller.appspot.com/bug?extid=6820505ae5978f4f8f2f
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a825d9900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a5c8d3900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1426e997200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1226e997200000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6820505ae5978f4f8f2f@syzkaller.appspotmail.com

REISERFS (device loop0): journal params: device loop0, size 512, journal first block 18, max trans len 256, max batch 225, max commit age 0, max trans age 30
REISERFS (device loop0): checking transaction log (loop0)
REISERFS warning (device loop0): vs-13075 reiserfs_read_locked_inode: dead inode read from disk [1 2 0x0 SD]. This is likely to be race with knfsd. Ignore
REISERFS (device loop0): Using rupasov hash to sort names
------------[ cut here ]------------
kernel BUG at fs/reiserfs/journal.c:3630!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6906 Comm: syz-executor291 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:check_journal_end fs/reiserfs/journal.c:3630 [inline]
RIP: 0010:do_journal_end+0x3698/0x48d0 fs/reiserfs/journal.c:4026
Code: fe 0a ff ff e9 51 f9 ff ff e8 94 e0 76 ff 0f 0b e8 8d e0 76 ff 0f 0b e8 86 e0 76 ff 0f 0b e8 7f e0 76 ff 0f 0b e8 78 e0 76 ff <0f> 0b e8 71 e0 76 ff 0f 0b e8 6a e0 76 ff 48 8b 44 24 08 48 8b 54
RSP: 0018:ffffc90005607a00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000570b000 RCX: ffffffff81ff2e9a
RDX: ffff8880a86485c0 RSI: ffffffff81ff5f48 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffc9000570b05b
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000570b058
R13: ffffc90005607c38 R14: 0000000000000000 R15: ffff8880a7d5a000
FS:  00007f8113e05700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9853cc7000 CR3: 00000000a6d1f000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 journal_end+0x277/0x320 fs/reiserfs/journal.c:3400
 reiserfs_fill_super+0x20e9/0x2deb fs/reiserfs/super.c:2168
 mount_bdev+0x32e/0x3f0 fs/super.c:1417
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44d45a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 5d a1 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 3a a1 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f8113e04bf8 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 000000000044d45a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f8113e04c10
RBP: 00007f8113e04c10 R08: 00007f8113e04c50 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000006
R13: 00007f8113e04c50 R14: 00007f8113e056d0 R15: 0000000000000005
Modules linked in:
---[ end trace 170160bcfcf2edcc ]---
RIP: 0010:check_journal_end fs/reiserfs/journal.c:3630 [inline]
RIP: 0010:do_journal_end+0x3698/0x48d0 fs/reiserfs/journal.c:4026
Code: fe 0a ff ff e9 51 f9 ff ff e8 94 e0 76 ff 0f 0b e8 8d e0 76 ff 0f 0b e8 86 e0 76 ff 0f 0b e8 7f e0 76 ff 0f 0b e8 78 e0 76 ff <0f> 0b e8 71 e0 76 ff 0f 0b e8 6a e0 76 ff 48 8b 44 24 08 48 8b 54
RSP: 0018:ffffc90005607a00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000570b000 RCX: ffffffff81ff2e9a
RDX: ffff8880a86485c0 RSI: ffffffff81ff5f48 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffc9000570b05b
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000570b058
R13: ffffc90005607c38 R14: 0000000000000000 R15: ffff8880a7d5a000
FS:  00007f8113e05700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9853c57000 CR3: 00000000a6d1f000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

