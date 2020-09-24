Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5F5276D53
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgIXJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:27:08 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:49376 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgIXJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:26:28 -0400
Received: by mail-il1-f208.google.com with SMTP id o18so1492525ilm.16
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6nhw05kENyrcmkH+ZCGEP6W/Yqq24s9GB6jG5Qb6FjA=;
        b=L0sTnwYjiIKiWBo6XTcZr+OIW7x5/CiDz+yfNi7/0OXRTb82lxQJfZipOgo1gQRqH8
         GNm5f40rrYGkmeCrHPWS/qC2up/rd0s4ULEt/8gCSOulps53Qa4ocRsQzcVAxSwn3VcC
         l7w/RPogP5jqXJIv54q0ZQkKxs5LIY8rghHxkiL4lByRfZXsNTrgsbkhzl7Sb5hL/v/o
         0wMxNIekBbUKYUvfdpI29S4bGLxBwIYHpUgRXLbSZWn2Y/jl+hYmDQML3qAbZUcSoWwP
         TB65c8IS5teN56T3Is1eJTsNY/Clfq9bGNOLh+51RyXEi+gKkDr4ph2W5dQfliA4oIaw
         YKyA==
X-Gm-Message-State: AOAM5304rmYTveHNXyNPrlWZJEonkQEcKqhimxR3U6ZzMbGtzlu/3+6J
        NYSBnjOqGqgkg1vYkgkKu+cNePM9gZfdZiRHq3PBR/MXfEds
X-Google-Smtp-Source: ABdhPJymrSndtpmu1AOE1ZertT54sBgT+Lt7U7idVLu8IhmD0hLuNcXfiOYV88fQM8eK14CfWJn4Lv6J7gs3uTCwm+/fgZCw3gYu
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1607:: with SMTP id x7mr2788339jas.109.1600939587073;
 Thu, 24 Sep 2020 02:26:27 -0700 (PDT)
Date:   Thu, 24 Sep 2020 02:26:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000650d4005b00bcb0c@google.com>
Subject: general protection fault in strncasecmp
From:   syzbot <syzbot+459a5dce0b4cb70fd076@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    98477740 Merge branch 'rcu/urgent' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b4d887900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f4c828c9e3cef97
dashboard link: https://syzkaller.appspot.com/bug?extid=459a5dce0b4cb70fd076
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125d46c5900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c58f8b900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+459a5dce0b4cb70fd076@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xf27d208691691fdb: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0x93e924348b48fed8-0x93e924348b48fedf]
CPU: 1 PID: 10071 Comm: syz-executor152 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:strncasecmp lib/string.c:52 [inline]
RIP: 0010:strncasecmp+0x5f/0x240 lib/string.c:43
Code: 00 40 38 ce 0f 85 ec 01 00 00 4c 39 e2 0f 84 11 01 00 00 4c 89 fe 4c 89 e7 49 83 c4 01 48 89 f8 48 89 f9 48 c1 e8 03 83 e1 07 <42> 0f b6 04 28 38 c8 7f 08 84 c0 0f 85 0f 01 00 00 41 0f b6 6c 24
RSP: 0018:ffffc9000ba7f958 EFLAGS: 00010202
RAX: 127d248691691fdb RBX: dffffc0000000000 RCX: 0000000000000001
RDX: 93e924348b48fee3 RSI: ffff8880a1a65401 RDI: 93e924348b48fed9
RBP: 0000000000000009 R08: 000000000000002e R09: 0000000000000025
R10: 0000000000000000 R11: 0000000000000005 R12: 93e924348b48feda
R13: dffffc0000000000 R14: 00000000000000e7 R15: ffffffff82ddbcd0
FS:  00007fd01e732700(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004cdb30 CR3: 00000000929cd000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 afs_lookup_cell_rcu+0x313/0x720 fs/afs/cell.c:88
 afs_lookup_cell+0x2ee/0x1440 fs/afs/cell.c:249
 afs_parse_source fs/afs/super.c:290 [inline]
 afs_parse_param+0x404/0x8c0 fs/afs/super.c:326
 vfs_parse_fs_param fs/fs_context.c:117 [inline]
 vfs_parse_fs_param+0x203/0x550 fs/fs_context.c:98
 vfs_parse_fs_string+0xe6/0x150 fs/fs_context.c:161
 generic_parse_monolithic+0x16f/0x1f0 fs/fs_context.c:201
 do_new_mount fs/namespace.c:2871 [inline]
 path_mount+0x133f/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44d57a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 bd 9f fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 9a 9f fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fd01e731c48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fd01e731c90 RCX: 000000000044d57a
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 0000000000000000
RBP: 0000000000000000 R08: 00007fd01e731c90 R09: 00007fd01e732700
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd01e7326d0
R13: 00007ffd130bca8f R14: 00007fd01e7329c0 R15: 0000000000000000
Modules linked in:
---[ end trace d103c481405d6a99 ]---
RIP: 0010:strncasecmp lib/string.c:52 [inline]
RIP: 0010:strncasecmp+0x5f/0x240 lib/string.c:43
Code: 00 40 38 ce 0f 85 ec 01 00 00 4c 39 e2 0f 84 11 01 00 00 4c 89 fe 4c 89 e7 49 83 c4 01 48 89 f8 48 89 f9 48 c1 e8 03 83 e1 07 <42> 0f b6 04 28 38 c8 7f 08 84 c0 0f 85 0f 01 00 00 41 0f b6 6c 24
RSP: 0018:ffffc9000ba7f958 EFLAGS: 00010202
RAX: 127d248691691fdb RBX: dffffc0000000000 RCX: 0000000000000001
RDX: 93e924348b48fee3 RSI: ffff8880a1a65401 RDI: 93e924348b48fed9
RBP: 0000000000000009 R08: 000000000000002e R09: 0000000000000025
R10: 0000000000000000 R11: 0000000000000005 R12: 93e924348b48feda
R13: dffffc0000000000 R14: 00000000000000e7 R15: ffffffff82ddbcd0
FS:  00007fd01e732700(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb63ee2c000 CR3: 00000000929cd000 CR4: 00000000001506e0
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
