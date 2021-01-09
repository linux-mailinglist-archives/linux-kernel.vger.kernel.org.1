Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7BD2F047C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 01:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAIX7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 18:59:07 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38697 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAIX7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 18:59:07 -0500
Received: by mail-il1-f197.google.com with SMTP id e10so13804992ils.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 15:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mdoj1Iq8WFCF58lDvGQKBoA3CDog2waFHGWxx+k0e4g=;
        b=EcvM0IyErOd3uFvTqHjnSXEZ/t20r9XOgf5bfbc3H8eBQhUAGOdTJZ3Xs+bzird1uW
         NjPmd5zVWb1nuuvdn92YN3LLfQCc/RxJVfpWptjZSJMylXfiPfSxWVOA4bjq/3/T5o3A
         94+Pgbqxlv/r0OE9eftQZe8p+7zzgxa7EeZpQKrgvu/2UtEv5zEt/vR3cbkDMcJ+fOrx
         bE+wwBLaR8/GSylqzU7tUt9c9WtMsqFMvNJNEe797baVKIw3tJUzUvppE5PLYsBxLLk2
         JdGwpWgMrwGB7ZAvH8LHozmRUvpMWV4QcBsAxac73N9JC8ZD58XHOE7XocUQGlccSfuJ
         Le8w==
X-Gm-Message-State: AOAM531l5d55QbVa/6f2+6Bfyve6jnr+6797/0+/18p2tH3RUHSoWllj
        zyQi8WwSkC2utbu3wQQ0A/iI1ABjwNVOIs3jxq3o/CwO3l4T
X-Google-Smtp-Source: ABdhPJyTtBj7ovEAJ92ljf4f+fivUjRaYpxSpwm5lrDs23bGqlgRm2emWqxtJJS9g8213FIsIc15K9C6rjzDrwsNr6CHnPjMH8ff
MIME-Version: 1.0
X-Received: by 2002:a5d:994c:: with SMTP id v12mr10456141ios.201.1610236706018;
 Sat, 09 Jan 2021 15:58:26 -0800 (PST)
Date:   Sat, 09 Jan 2021 15:58:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dddf3e05b880720d@google.com>
Subject: WARNING in squashfs_read_table
From:   syzbot <syzbot+2ccea6339d368360800d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    83dadd4c Add linux-next specific files for 20210105
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c0532b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca68c01770b963e1
dashboard link: https://syzkaller.appspot.com/bug?extid=2ccea6339d368360800d
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115f4dfb500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1542c43f500000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f77b67500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=140f7b67500000
console output: https://syzkaller.appspot.com/x/log.txt?x=100f7b67500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ccea6339d368360800d@syzkaller.appspotmail.com

loop0: detected capacity change from 8 to 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8456 at mm/page_alloc.c:4977 __alloc_pages_nodemask+0x5f8/0x730 mm/page_alloc.c:5012
Modules linked in:
CPU: 0 PID: 8456 Comm: syz-executor943 Not tainted 5.11.0-rc2-next-20210105-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x5f8/0x730 mm/page_alloc.c:4977
Code: 00 00 0c 00 0f 85 a7 00 00 00 8b 3c 24 4c 89 f2 44 89 e6 c6 44 24 70 00 48 89 6c 24 58 e8 d0 d7 ff ff 49 89 c5 e9 ea fc ff ff <0f> 0b e9 b5 fd ff ff 89 74 24 14 4c 89 4c 24 08 4c 89 74 24 18 e8
RSP: 0018:ffffc9000112fa98 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff92000225f57 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000040cc0
RBP: 0000000000040cc0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81b25651 R11: 0000000000000000 R12: 0000000000000034
R13: 0000000000000034 R14: 0000000000000000 R15: 00000000e24d8401
FS:  00000000019a2880(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559ed1ff3180 CR3: 000000001b421000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages_current+0x18c/0x2a0 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x2e/0xb0 mm/slab_common.c:916
 kmalloc_order_trace+0x14/0x120 mm/slab_common.c:932
 kmalloc include/linux/slab.h:559 [inline]
 squashfs_read_table+0x43/0x1e0 fs/squashfs/cache.c:413
 squashfs_read_xattr_id_table+0x191/0x220 fs/squashfs/xattr_id.c:81
 squashfs_fill_super+0xcfb/0x23b0 fs/squashfs/super.c:225
 get_tree_bdev+0x421/0x740 fs/super.c:1291
 vfs_get_tree+0x89/0x2f0 fs/super.c:1496
 do_new_mount fs/namespace.c:2899 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3230
 do_mount fs/namespace.c:3243 [inline]
 __do_sys_mount fs/namespace.c:3451 [inline]
 __se_sys_mount fs/namespace.c:3428 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3428
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446d1a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffe89cbd7b8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe89cbd810 RCX: 0000000000446d1a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe89cbd7d0
RBP: 00007ffe89cbd7d0 R08: 00007ffe89cbd810 R09: 00007ffe00000015
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
