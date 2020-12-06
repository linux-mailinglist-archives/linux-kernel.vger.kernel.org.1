Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98CC2D006F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 05:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgLFEKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 23:10:33 -0500
Received: from mail-pj1-f72.google.com ([209.85.216.72]:60260 "EHLO
        mail-pj1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLFEKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 23:10:15 -0500
Received: by mail-pj1-f72.google.com with SMTP id bj5so5244247pjb.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 20:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BQQ7NlEGSp8tGI+irB5HszobDEIZUQC2Ff3/3OJUlzA=;
        b=luGEBmYAcDNCSrQ4aMz9N2pG8nN5uaIOheAuguJrC6yglMoks2e25w7RysddcuGc8Q
         4E3m09Ms2vnb7sMl4qkD2DpW5VCP7PByIlQYV5cuCDEkQzwH43Z46GGGKaw3DMcdMo4y
         dwh50n96NjWzwGoJYaBHTLiQNtBGpz3BqFpPIEhDH+ZNs/1HcDBjP7rziz4y4UhHuCP3
         gxtl3ccoj2QOvB2MXcG4/hGpbe+Jo4cygEe3sd1m7qtyXhsMgsU8/BBPkRpuuZ8ppsy6
         /HmYcfmJSiOj3lm/o++1+EDYfTHJfDByjs4Fm5ROzAuHI51aqWApD3PQ+j3RRedeTloR
         +JJQ==
X-Gm-Message-State: AOAM533XaaG4EblVCcGzh/5lmOjOyLOCw77JVDPn5gsJoc9hAabag7gk
        mVSf50ZNs9e8Oh4Z0+siosaNcX8UggS4srsy7pDQHvVxOHwk
X-Google-Smtp-Source: ABdhPJzPTb+N/3cvNvMhVzW9I/Vi8HAKUqmgsacmpWjvnAOtdiY1MuH/6LOhJt+2KiPhxgawRzJXT0zaQd8+X0XguulCIxyTysI/
MIME-Version: 1.0
X-Received: by 2002:a92:d151:: with SMTP id t17mr13340211ilg.108.1607223849436;
 Sat, 05 Dec 2020 19:04:09 -0800 (PST)
Date:   Sat, 05 Dec 2020 19:04:09 -0800
In-Reply-To: <000000000000eda45205b0259440@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ecd8805b5c2f6ae@google.com>
Subject: Re: KASAN: use-after-free Read in squashfs_get_id
From:   syzbot <syzbot+a296f64433c9cfd55cc8@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b3298500 Merge tag 'for-5.10/dm-fixes' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1003173d500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3a044ccf5b03ac4
dashboard link: https://syzkaller.appspot.com/bug?extid=a296f64433c9cfd55cc8
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ace3f7500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f0d2ef500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a296f64433c9cfd55cc8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in squashfs_get_id+0x1ae/0x1d0 fs/squashfs/id.c:38
Read of size 8 at addr ffff88801e52f0d8 by task syz-executor067/8471

CPU: 1 PID: 8471 Comm: syz-executor067 Not tainted 5.10.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 squashfs_get_id+0x1ae/0x1d0 fs/squashfs/id.c:38
 squashfs_new_inode fs/squashfs/inode.c:51 [inline]
 squashfs_read_inode+0x1b4/0x1b40 fs/squashfs/inode.c:120
 squashfs_fill_super+0x1140/0x23b0 fs/squashfs/super.c:310
 get_tree_bdev+0x421/0x740 fs/super.c:1344
 vfs_get_tree+0x89/0x2f0 fs/super.c:1549
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x13ad/0x20c0 fs/namespace.c:3205
 do_mount fs/namespace.c:3218 [inline]
 __do_sys_mount fs/namespace.c:3426 [inline]
 __se_sys_mount fs/namespace.c:3403 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3403
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446d1a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffc9fb56f38 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc9fb56f90 RCX: 0000000000446d1a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffc9fb56f50
RBP: 00007ffc9fb56f50 R08: 00007ffc9fb56f90 R09: 00007ffc00000015
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003

Allocated by task 8471:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 __do_kmalloc mm/slab.c:3657 [inline]
 __kmalloc+0x23d/0x490 mm/slab.c:3666
 kmalloc_array include/linux/slab.h:592 [inline]
 kcalloc include/linux/slab.h:603 [inline]
 squashfs_read_table+0xbb/0x1e0 fs/squashfs/cache.c:417
 squashfs_read_id_index_table+0xab/0x120 fs/squashfs/id.c:77
 squashfs_fill_super+0xdd0/0x23b0 fs/squashfs/super.c:238
 get_tree_bdev+0x421/0x740 fs/super.c:1344
 vfs_get_tree+0x89/0x2f0 fs/super.c:1549
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x13ad/0x20c0 fs/namespace.c:3205
 do_mount fs/namespace.c:3218 [inline]
 __do_sys_mount fs/namespace.c:3426 [inline]
 __se_sys_mount fs/namespace.c:3403 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3403
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 8471:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3420 [inline]
 kfree+0xe8/0x240 mm/slab.c:3758
 squashfs_read_table+0x189/0x1e0 fs/squashfs/cache.c:435
 squashfs_read_id_index_table+0xab/0x120 fs/squashfs/id.c:77
 squashfs_fill_super+0xdd0/0x23b0 fs/squashfs/super.c:238
 get_tree_bdev+0x421/0x740 fs/super.c:1344
 vfs_get_tree+0x89/0x2f0 fs/super.c:1549
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x13ad/0x20c0 fs/namespace.c:3205
 do_mount fs/namespace.c:3218 [inline]
 __do_sys_mount fs/namespace.c:3426 [inline]
 __se_sys_mount fs/namespace.c:3403 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3403
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88801e52f0c0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 24 bytes inside of
 32-byte region [ffff88801e52f0c0, ffff88801e52f0e0)
The buggy address belongs to the page:
page:000000009f69cbb3 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801e52ffc1 pfn:0x1e52f
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 ffffea000053f4c8 ffff888010041250 ffff888010040100
raw: ffff88801e52ffc1 ffff88801e52f000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88801e52ef80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801e52f000: 00 fc fc fc fc fc fc fc 00 fc fc fc fc fc fc fc
>ffff88801e52f080: fb fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                                    ^
 ffff88801e52f100: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88801e52f180: fb fb fb fb fc fc fc fc 00 fc fc fc fc fc fc fc
==================================================================

