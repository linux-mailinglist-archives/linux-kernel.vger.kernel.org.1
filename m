Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA2B278456
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgIYJsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:48:25 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:41750 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgIYJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:48:25 -0400
Received: by mail-il1-f205.google.com with SMTP id a16so1410761ilh.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=akepFshVI5R+mDlwcYOxFWUOHFVZvQS2BgOitw8HPXA=;
        b=qwo85zmBCu2BJ68pqYL5VXk/Vv1DdSwG1DV59jyxvBRgBtkmQPNigDZ1XC0gFm+i3G
         UksKKeXW4kK/rSqzmj1j54hWjssMjBX+wgV/pC/KhRfBeNZnrLV9XivoguhOoRYNcxTu
         xc1sJyvkR29e8/BxxAGw6eYwIX9lOcTMxI2nD8ZT1G5Px4DYDJK/UNXAeQeRwllLqTDc
         XMoLCiXoy98MuQXEv5OG6JaVPlTYFJKSTFuDegaF5NaTvs4peoEmZFskqsOyoVbVnQFR
         /4AIGGCFLHUeiPgc+Y+THkjBnPtGu+KhhG9uUFnQnSPAVxU1rVYBo+yK5RnF3YqN5vku
         6N7Q==
X-Gm-Message-State: AOAM5320b2OqPZ9Rtoux3RdNlF1tTWlOYn2DVyIdecpdncIWW8uyi0mA
        rSZQaftkGosSLuNkl+zl+NiGt3PSFUYPPqDs3etplZVdwf2t
X-Google-Smtp-Source: ABdhPJyd+8fiUjXycNa+xjviGHqACF7mSVnxCkQr63M0xUVUXdwkO4/kbmJgpMe1EvkU6WjF6qBMc0NaY7SsXYCtHqEGNiYb/gok
MIME-Version: 1.0
X-Received: by 2002:a92:d08a:: with SMTP id h10mr2510042ilh.109.1601027303722;
 Fri, 25 Sep 2020 02:48:23 -0700 (PDT)
Date:   Fri, 25 Sep 2020 02:48:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6d7fd05b02037ef@google.com>
Subject: general protection fault in gfs2_withdraw
From:   syzbot <syzbot+50a8a9cf8127f2c6f5df@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ba4f184e Linux 5.9-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a0ccad900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f192552d75898a1
dashboard link: https://syzkaller.appspot.com/bug?extid=50a8a9cf8127f2c6f5df
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50a8a9cf8127f2c6f5df@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: fatal: invalid metadata block
  bh = 2072 (magic number)
  function = gfs2_meta_indirect_buffer, file = fs/gfs2/meta_io.c, line = 417
gfs2: fsid=syz:syz.0: about to withdraw this file system
general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 0 PID: 27118 Comm: syz-executor.0 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:signal_our_withdraw fs/gfs2/util.c:97 [inline]
RIP: 0010:gfs2_withdraw.cold+0xff/0xc0e fs/gfs2/util.c:294
Code: 00 48 c1 e0 2a 80 3c 02 00 0f 85 19 02 00 00 4c 8b bb a0 08 00 00 b8 ff ff 37 00 48 c1 e0 2a 49 8d 7f 70 48 89 fa 48 c1 ea 03 <80> 3c 02 00 74 05 e8 67 6d 68 fe 4d 8b 7f 70 b8 ff ff 37 00 48 c1
RSP: 0018:ffffc900018b73b8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888059d70000 RCX: ffffc90002639000
RDX: 000000000000000e RSI: ffffffff834e9fdf RDI: 0000000000000070
RBP: ffff888059d7026d R08: 0000000000000038 R09: ffff88802ce318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888059d70050
R13: ffff888059d702f0 R14: ffffffff88cc1320 R15: 0000000000000000
FS:  00007f348fd73700(0000) GS:ffff88802ce00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000b60004 CR3: 000000004a089000 CR4: 0000000000350ef0
DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 gfs2_meta_check_ii+0x68/0xa0 fs/gfs2/util.c:450
 gfs2_metatype_check_i fs/gfs2/util.h:126 [inline]
 gfs2_meta_indirect_buffer+0x3a3/0x3f0 fs/gfs2/meta_io.c:417
 gfs2_meta_inode_buffer fs/gfs2/meta_io.h:70 [inline]
 gfs2_inode_refresh+0x95/0xdf0 fs/gfs2/glops.c:438
 inode_go_lock+0x309/0x49f fs/gfs2/glops.c:468
 do_promote+0x4a0/0xc10 fs/gfs2/glock.c:390
 finish_xmote+0x4ed/0xf40 fs/gfs2/glock.c:560
 do_xmote+0x812/0xba0 fs/gfs2/glock.c:686
 run_queue+0x323/0x680 fs/gfs2/glock.c:751
 gfs2_glock_nq+0x716/0x11b0 fs/gfs2/glock.c:1410
 gfs2_glock_nq_init fs/gfs2/glock.h:238 [inline]
 gfs2_lookupi+0x314/0x630 fs/gfs2/inode.c:317
 gfs2_lookup_simple+0x99/0xe0 fs/gfs2/inode.c:268
 init_journal fs/gfs2/ops_fstype.c:620 [inline]
 init_inodes+0x367/0x1f40 fs/gfs2/ops_fstype.c:756
 gfs2_fill_super+0x195e/0x254a fs/gfs2/ops_fstype.c:1125
 get_tree_bdev+0x421/0x740 fs/super.c:1342
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1201
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e5ea
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 6d 9e fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 4a 9e fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f348fd72aa8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f348fd72b40 RCX: 000000000045e5ea
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f348fd72b00
RBP: 00007f348fd72b00 R08: 00007f348fd72b40 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 0000000020047a20
Modules linked in:
---[ end trace a1967e7d2c26629b ]---
RIP: 0010:signal_our_withdraw fs/gfs2/util.c:97 [inline]
RIP: 0010:gfs2_withdraw.cold+0xff/0xc0e fs/gfs2/util.c:294
Code: 00 48 c1 e0 2a 80 3c 02 00 0f 85 19 02 00 00 4c 8b bb a0 08 00 00 b8 ff ff 37 00 48 c1 e0 2a 49 8d 7f 70 48 89 fa 48 c1 ea 03 <80> 3c 02 00 74 05 e8 67 6d 68 fe 4d 8b 7f 70 b8 ff ff 37 00 48 c1
RSP: 0018:ffffc900018b73b8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888059d70000 RCX: ffffc90002639000
RDX: 000000000000000e RSI: ffffffff834e9fdf RDI: 0000000000000070
RBP: ffff888059d7026d R08: 0000000000000038 R09: ffff88802ce318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888059d70050
R13: ffff888059d702f0 R14: ffffffff88cc1320 R15: 0000000000000000
FS:  00007f348fd73700(0000) GS:ffff88802cf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000256f020 CR3: 000000004a089000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
