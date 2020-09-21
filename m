Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21945272131
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIUKdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:33:19 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:56016 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgIUKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:33:18 -0400
Received: by mail-io1-f80.google.com with SMTP id t187so9500613iof.22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TkUyzMkYz/c8/5hvltm5ed1HTbPYyQWLlHEIooENSiE=;
        b=f9y7r5nGfHtitbPeMkpTdRfBCjcbHJsNNyHC9ayWByuZEUuk79ydoUzAbp5xKiaw4J
         ftS/uWBjrIOQyAbjgKcCcGkW9g2rS6/40EUxFa3xQwSLMenl8s8kYamNGYnyb7T1emO6
         XGSkcmm4UoP7fI+rqrItnZGp0VcHEdgWjGBuEJX9JkyAsrTt1bOeBesnYKVdEl2RIfMq
         ztGuEV4j69VsBf2Mwu6x6pi8vu+ErsUazX5Om9rxNE4ABk01vLaPkwhlSgjBrjTokdgw
         AWRHGJ3yJzxqCgckIA4DwdDMattBqcsvG+7w5iy8VjAKJiGLuD9AkDNrv4OzBq7PRyyX
         trOw==
X-Gm-Message-State: AOAM531K/icRuGf2NPStibGm7+QwDFW/isFsql0tC4s37o2pGAgMeemX
        3LolLnznMnCUD8YedvyhtfsONAZGOqxb9QSwC91wK1bj11BT
X-Google-Smtp-Source: ABdhPJzGXxUiEInu/JMkAk+OuWugeCE3xYd/24sugKd3CrVst9ArkjXt3vF9NV/C7llboeCyQhrjsnxTHC26ZDvbvOUVzh9WjZxy
MIME-Version: 1.0
X-Received: by 2002:a02:ccae:: with SMTP id t14mr32262614jap.63.1600684397439;
 Mon, 21 Sep 2020 03:33:17 -0700 (PDT)
Date:   Mon, 21 Sep 2020 03:33:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e82e1a05afd0605d@google.com>
Subject: KASAN: use-after-free Read in afs_deactivate_cell (2)
From:   syzbot <syzbot+a5e4946b04d6ca8fa5f3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ec729b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d39f8ae68f9dcd5
dashboard link: https://syzkaller.appspot.com/bug?extid=a5e4946b04d6ca8fa5f3
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a5e4946b04d6ca8fa5f3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __hlist_del include/linux/list.h:826 [inline]
BUG: KASAN: use-after-free in hlist_del_rcu include/linux/rculist.h:487 [inline]
BUG: KASAN: use-after-free in afs_deactivate_cell+0x165/0x1a0 fs/afs/cell.c:647
Read of size 8 at addr ffff888090699880 by task kworker/0:3/7433

CPU: 0 PID: 7433 Comm: kworker/0:3 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: afs afs_manage_cell
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 __hlist_del include/linux/list.h:826 [inline]
 hlist_del_rcu include/linux/rculist.h:487 [inline]
 afs_deactivate_cell+0x165/0x1a0 fs/afs/cell.c:647
 afs_manage_cell+0x326/0x11c0 fs/afs/cell.c:721
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 process_scheduled_works kernel/workqueue.c:2331 [inline]
 worker_thread+0x82b/0x1120 kernel/workqueue.c:2417
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 19085:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 kmem_cache_alloc_trace+0x174/0x300 mm/slab.c:3550
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 afs_alloc_cell fs/afs/cell.c:151 [inline]
 afs_lookup_cell+0x5c8/0x1440 fs/afs/cell.c:262
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

Freed by task 9:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x10e/0x2b0 mm/slab.c:3756
 rcu_do_batch kernel/rcu/tree.c:2428 [inline]
 rcu_core+0x5ca/0x1130 kernel/rcu/tree.c:2656
 __do_softirq+0x1f8/0xb23 kernel/softirq.c:298

Last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2894 [inline]
 call_rcu+0x15e/0x7c0 kernel/rcu/tree.c:2968
 afs_manage_cell+0x250/0x11c0 fs/afs/cell.c:751
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the object at ffff888090699800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 128 bytes inside of
 1024-byte region [ffff888090699800, ffff888090699c00)
The buggy address belongs to the page:
page:00000000d3e3a7d0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x90699
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002558fc8 ffffea0001240988 ffff8880aa040700
raw: 0000000000000000 ffff888090699000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888090699780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888090699800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888090699880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888090699900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888090699980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
