Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49CF27A8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgI1HhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:37:22 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:46126 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgI1HhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:37:18 -0400
Received: by mail-io1-f79.google.com with SMTP id j8so118868iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=34Ah2FBKBlb/Ry08URjFZa+8xnbU6pAEjvgS1SnlDts=;
        b=ISzSt2JKBK5IXAPKO/zF8ZnyfHf50mjGDSob4qWog3/BOrCgi3zeQckmxdNnufP9Qk
         RNV1+hNLqU4B1x6EL3XzhQR/QNxS9jLTNrKP+Z54xs2Y6Q2FUeAbtN9Ye0XG6N2ygmVK
         /m2tZp75t7MJxz470sn6x5rQGHgTjrp44KGR2Af6V2kNkUhsNZEVYDfrTFECXnhrC5MB
         eKjI72Mwe5JJxsmjDDcD5nRxaNLjS3R2GfVcXR114NTNkeDELX+8y+rKZD/8YaGaobz8
         MVhBDNDyePPj3VkR5yd4/aUi8gSJxzACS8uZN5lmoakBMyXrVomrGncX0g7nbIRAJF4z
         fLYg==
X-Gm-Message-State: AOAM531SglNQq3+WSGllaY0ixFJPOXPPBo/XG26QKkEw+JNQUT//FmUD
        JjcbEX80MZQUVBKUl/JJ+Jkmzrf7TqGoP772OvFadhQMb9wD
X-Google-Smtp-Source: ABdhPJwGTiMIuvd8MW9tpENYCizEv5e6p8/no51heLAjos6ZCCh41QZwFEnK4TTBVP3nI7V9kJyRHUbchZyeoY3gzNd8hq08qsIF
MIME-Version: 1.0
X-Received: by 2002:a92:6a0a:: with SMTP id f10mr120305ilc.186.1601278636978;
 Mon, 28 Sep 2020 00:37:16 -0700 (PDT)
Date:   Mon, 28 Sep 2020 00:37:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057f8db05b05abc47@google.com>
Subject: KASAN: use-after-free Read in __proc_create
From:   syzbot <syzbot+0e0db88e1eb44a91ae8d@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c7ec322 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1375b14b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6184b75aa6d48d66
dashboard link: https://syzkaller.appspot.com/bug?extid=0e0db88e1eb44a91ae8d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e0db88e1eb44a91ae8d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in strlen+0x4c/0x60 lib/string.c:544
Read of size 1 at addr ffff8880a29662c0 by task kworker/1:1/23

CPU: 1 PID: 23 Comm: kworker/1:1 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: afs afs_manage_cell
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 print_address_description+0x66/0x620 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 strlen+0x4c/0x60 lib/string.c:544
 __proc_create+0x28d/0xb60 fs/proc/generic.c:399
 proc_mkdir_data+0x84/0x160 fs/proc/generic.c:482
 proc_net_mkdir include/linux/proc_fs.h:201 [inline]
 afs_proc_cell_setup+0xaf/0x180 fs/afs/proc.c:620
 afs_activate_cell fs/afs/cell.c:615 [inline]
 afs_manage_cell+0x7db/0x1540 fs/afs/cell.c:697
 process_one_work+0x789/0xfc0 kernel/workqueue.c:2269
 process_scheduled_works kernel/workqueue.c:2331 [inline]
 worker_thread+0xde4/0x1460 kernel/workqueue.c:2417
 kthread+0x37e/0x3a0 drivers/block/aoe/aoecmd.c:1234
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 8801:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x100/0x130 mm/kasan/common.c:461
 __do_kmalloc mm/slab.c:3655 [inline]
 __kmalloc+0x205/0x300 mm/slab.c:3664
 kmalloc include/linux/slab.h:559 [inline]
 afs_alloc_cell fs/afs/cell.c:157 [inline]
 afs_lookup_cell+0x4d2/0x14d0 fs/afs/cell.c:262
 afs_parse_source fs/afs/super.c:290 [inline]
 afs_parse_param+0x526/0x790 fs/afs/super.c:326
 vfs_parse_fs_param+0x1e5/0x460 fs/fs_context.c:117
 vfs_parse_fs_string fs/fs_context.c:161 [inline]
 generic_parse_monolithic+0x230/0x350 fs/fs_context.c:201
 do_new_mount fs/namespace.c:2871 [inline]
 path_mount+0x176c/0x29e0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount+0x126/0x180 fs/namespace.c:3390
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 8668:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:56
 kasan_set_free_info+0x17/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xdd/0x110 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x113/0x200 mm/slab.c:3756
 afs_cell_destroy+0x16b/0x240 fs/afs/cell.c:500
 rcu_do_batch kernel/rcu/tree.c:2430 [inline]
 rcu_core+0x79b/0x1130 kernel/rcu/tree.c:2658
 __do_softirq+0x256/0x6d5 kernel/softirq.c:298

The buggy address belongs to the object at ffff8880a29662c0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 32-byte region [ffff8880a29662c0, ffff8880a29662e0)
The buggy address belongs to the page:
page:00000000f15c0556 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880a2966fc1 pfn:0xa2966
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00028f7d48 ffffea0002a22248 ffff8880aa440100
raw: ffff8880a2966fc1 ffff8880a2966000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a2966180: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880a2966200: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880a2966280: 00 00 03 fc fc fc fc fc fa fb fb fb fc fc fc fc
                                           ^
 ffff8880a2966300: 00 07 fc fc fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880a2966380: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
