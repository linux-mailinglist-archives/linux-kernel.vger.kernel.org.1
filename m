Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A60279B4F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgIZRVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:21:16 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:39408 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZRVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:21:15 -0400
Received: by mail-io1-f69.google.com with SMTP id y16so4221822ioy.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 10:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uQx7/WJNirjfW85gL89QcVygbz7js2vGaNbY3FUQdGA=;
        b=kaJtJ+CdTbIpxMDTF34wQceM/jPHqLFpICZ1MsuQbg6QZrzG6/OwRskpaKPKVzxBUq
         bJvhQuctUbhDgmdcgdDQpukfqEGr2mzTO9EzRBue9eXzHFtb8Dvq/4N4kZVwSZiJNBZC
         +3Kfx+jNXUb5XzROwq8ai74T4Li9QA2LXuz7T8Seyf40/JgHhxj121lswI/UzRp49Ba/
         myzz/h+3Uxs8N9sElO4hclgOOjB15P+vkHJNltg4BR3bUo9vLv/v8h3xaOfxVJJB0LH5
         hzJw+EbD/MRGTjotG9kHavoT100EGJpqvbl0//W8Ka/uLvIyPXQ1M8octzrJ6nPRr9Ih
         AesQ==
X-Gm-Message-State: AOAM5317mfuaMnTpNUK5tzb/fJcyuX9qCpidZTgrgHRmRpVyIhOZxH/F
        6mfk5PnViq+4bFua5jO1R1BB0xTN02zNgKrivqncx9teXwO/
X-Google-Smtp-Source: ABdhPJz1q1LDPov92IU55Iz9IfVs1ANnuiyonRY+qc+4i1wr20iJB14DTgg+6UrsBGAoVpti8VxTRapxGlkTQf1KNGSiJaJJv3Xx
MIME-Version: 1.0
X-Received: by 2002:a92:c690:: with SMTP id o16mr4114102ilg.215.1601140874534;
 Sat, 26 Sep 2020 10:21:14 -0700 (PDT)
Date:   Sat, 26 Sep 2020 10:21:14 -0700
In-Reply-To: <000000000000b6d7fd05b02037ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000fe7c205b03aa9e9@google.com>
Subject: Re: general protection fault in gfs2_withdraw
From:   syzbot <syzbot+50a8a9cf8127f2c6f5df@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    7c7ec322 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f2ff27900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6184b75aa6d48d66
dashboard link: https://syzkaller.appspot.com/bug?extid=50a8a9cf8127f2c6f5df
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160fb773900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1104f109900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50a8a9cf8127f2c6f5df@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: fatal: invalid metadata block
  bh = 2072 (magic number)
  function = gfs2_meta_indirect_buffer, file = fs/gfs2/meta_io.c, line = 417
gfs2: fsid=syz:syz.0: about to withdraw this file system
general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 0 PID: 6842 Comm: syz-executor264 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:signal_our_withdraw fs/gfs2/util.c:97 [inline]
RIP: 0010:gfs2_withdraw+0x2b0/0xe20 fs/gfs2/util.c:294
Code: e8 03 48 89 44 24 38 42 80 3c 38 00 74 08 48 89 ef e8 34 f7 69 fe 48 89 6c 24 20 48 8b 6d 00 48 83 c5 70 48 89 e8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 ef e8 11 f7 69 fe 48 8b 45 00 48 89 44
RSP: 0018:ffffc900057474f0 EFLAGS: 00010202
RAX: 000000000000000e RBX: ffff8880a71e0000 RCX: 98268db4dfe86a00
RDX: ffff888092bb6100 RSI: 0000000000000000 RDI: ffff8880a71e0430
RBP: 0000000000000070 R08: ffffffff834ad50c R09: ffffed1015d041c3
R10: ffffed1015d041c3 R11: 0000000000000000 R12: 1ffff11014e3c04d
R13: ffff8880a71e0050 R14: ffff8880a71e026c R15: dffffc0000000000
FS:  000000000233b880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f74f826d6c0 CR3: 00000000a04cc000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 gfs2_meta_check_ii+0x70/0x80 fs/gfs2/util.c:450
 gfs2_metatype_check_i fs/gfs2/util.h:126 [inline]
 gfs2_meta_indirect_buffer+0x29f/0x380 fs/gfs2/meta_io.c:417
 gfs2_meta_inode_buffer fs/gfs2/meta_io.h:70 [inline]
 gfs2_inode_refresh+0x65/0xc00 fs/gfs2/glops.c:438
 inode_go_lock+0x12c/0x480 fs/gfs2/glops.c:468
 do_promote+0x4db/0xcd0 fs/gfs2/glock.c:390
 finish_xmote+0x907/0x1350 fs/gfs2/glock.c:560
 do_xmote+0xadb/0x14c0 fs/gfs2/glock.c:686
 gfs2_glock_nq+0xac3/0x14d0 fs/gfs2/glock.c:1410
 gfs2_glock_nq_init fs/gfs2/glock.h:238 [inline]
 gfs2_lookupi+0x36f/0x4f0 fs/gfs2/inode.c:317
 gfs2_lookup_simple+0xa4/0x100 fs/gfs2/inode.c:268
 init_journal+0x132/0x1970 fs/gfs2/ops_fstype.c:620
 init_inodes fs/gfs2/ops_fstype.c:756 [inline]
 gfs2_fill_super+0x2717/0x3fe0 fs/gfs2/ops_fstype.c:1125
 get_tree_bdev+0x3e9/0x5f0 fs/super.c:1342
 gfs2_get_tree+0x4c/0x1f0 fs/gfs2/ops_fstype.c:1201
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x179d/0x29e0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount+0x126/0x180 fs/namespace.c:3390
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x458e1a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffc76f65c88 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc76f65ce0 RCX: 0000000000458e1a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffc76f65ca0
RBP: 00007ffc76f65ca0 R08: 00007ffc76f65ce0 R09: 00007ffc00000015
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000809
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
Modules linked in:
---[ end trace 1e62174917573e95 ]---
RIP: 0010:signal_our_withdraw fs/gfs2/util.c:97 [inline]
RIP: 0010:gfs2_withdraw+0x2b0/0xe20 fs/gfs2/util.c:294
Code: e8 03 48 89 44 24 38 42 80 3c 38 00 74 08 48 89 ef e8 34 f7 69 fe 48 89 6c 24 20 48 8b 6d 00 48 83 c5 70 48 89 e8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 ef e8 11 f7 69 fe 48 8b 45 00 48 89 44
RSP: 0018:ffffc900057474f0 EFLAGS: 00010202
RAX: 000000000000000e RBX: ffff8880a71e0000 RCX: 98268db4dfe86a00
RDX: ffff888092bb6100 RSI: 0000000000000000 RDI: ffff8880a71e0430
RBP: 0000000000000070 R08: ffffffff834ad50c R09: ffffed1015d041c3
R10: ffffed1015d041c3 R11: 0000000000000000 R12: 1ffff11014e3c04d
R13: ffff8880a71e0050 R14: ffff8880a71e026c R15: dffffc0000000000
FS:  000000000233b880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f74f826d6c0 CR3: 00000000a04cc000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

