Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7827E3A2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgI3IZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:25:16 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:41038 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgI3IZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:25:16 -0400
Received: by mail-io1-f69.google.com with SMTP id j4so637135iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FPXUzl973I63TiBfgp/TLm6uHm90yiaAfpH0saHOdrM=;
        b=maS2HHDbSdDucn75w1LPxw1hqiI5gABz4tS5qRwOlqCnKJ2kRkJR9/gBJug2UkUKTd
         MLdjDef7ZLQgGV34dwiACvCsQHR5yKi30r+EXmUJgmpkvoQnxvctpGHLfdH8/7H/vVQO
         WEKOxzgWudHlXIJavsCTzAXx7/qGFurK4YhWEPMk5rcLD4F8ztr5Q/a9wBA+Ks/YF2F6
         +oJqiGSagfsTMnKpSK3C41cH/myb8wT1uP064rM3+FkdpRxeguvBNvu9rKTsrn2nlEuv
         0pnu6XmmnmW5x4IVDiPr8eNwnas+QCgPEpO9CNq24w4ZKVEmcwfjPFrt/rmWN8v3u3El
         2JDg==
X-Gm-Message-State: AOAM530zOWfY/jnBqdvxNYVm1VUyw7GPizgZ9VOpOK36eGMMWY1vhKGe
        2BlQBOhcmb6QAdLix9iC2FwGk3ruF1zqbcDagYXVK6qPwrz4
X-Google-Smtp-Source: ABdhPJybXZRuniN+DpByAMYZzCduSfdzFcBIBByBiDvtoTdgQiEdsWXW0pNgfOUlhPWhFK461aUSdKZz/ozEQm1CyxqTt7v6pFPe
MIME-Version: 1.0
X-Received: by 2002:a6b:9089:: with SMTP id s131mr913591iod.195.1601454315325;
 Wed, 30 Sep 2020 01:25:15 -0700 (PDT)
Date:   Wed, 30 Sep 2020 01:25:15 -0700
In-Reply-To: <000000000000e82e1a05afd0605d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096cfce05b083a3a9@google.com>
Subject: Re: KASAN: use-after-free Read in afs_deactivate_cell (2)
From:   syzbot <syzbot+a5e4946b04d6ca8fa5f3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    49e7e3e9 Add linux-next specific files for 20200929
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12fbf387900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b823d07e241e7aee
dashboard link: https://syzkaller.appspot.com/bug?extid=a5e4946b04d6ca8fa5f3
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173c446d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ba5be3900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a5e4946b04d6ca8fa5f3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __hlist_del include/linux/list.h:826 [inline]
BUG: KASAN: use-after-free in hlist_del_rcu include/linux/rculist.h:514 [inline]
BUG: KASAN: use-after-free in afs_deactivate_cell+0x165/0x1a0 fs/afs/cell.c:647
Read of size 8 at addr ffff888093021080 by task kworker/0:3/2653

CPU: 0 PID: 2653 Comm: kworker/0:3 Not tainted 5.9.0-rc7-next-20200929-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: afs afs_manage_cell
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 __hlist_del include/linux/list.h:826 [inline]
 hlist_del_rcu include/linux/rculist.h:514 [inline]
 afs_deactivate_cell+0x165/0x1a0 fs/afs/cell.c:647
 afs_manage_cell+0x326/0x11c0 fs/afs/cell.c:721
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Allocated by task 7905:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 kmem_cache_alloc_trace+0x1a0/0x480 mm/slab.c:3552
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 afs_alloc_cell fs/afs/cell.c:151 [inline]
 afs_lookup_cell+0x5b8/0x1450 fs/afs/cell.c:262
 afs_parse_source fs/afs/super.c:290 [inline]
 afs_parse_param+0x404/0x8c0 fs/afs/super.c:326
 vfs_parse_fs_param fs/fs_context.c:117 [inline]
 vfs_parse_fs_param+0x203/0x550 fs/fs_context.c:98
 vfs_parse_fs_string+0xe6/0x150 fs/fs_context.c:161
 generic_parse_monolithic+0x16f/0x1f0 fs/fs_context.c:201
 do_new_mount fs/namespace.c:2892 [inline]
 path_mount+0x1266/0x1e70 fs/namespace.c:3227
 __do_sys_mount fs/namespace.c:3438 [inline]
 __se_sys_mount fs/namespace.c:3411 [inline]
 __x64_sys_mount+0x278/0x2f0 fs/namespace.c:3411
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 2653:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3420 [inline]
 kfree+0x10e/0x2a0 mm/slab.c:3758
 rcu_do_batch kernel/rcu/tree.c:2481 [inline]
 rcu_core+0x645/0x1240 kernel/rcu/tree.c:2715
 __do_softirq+0x203/0xab6 kernel/softirq.c:298

Last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2957 [inline]
 call_rcu+0x15e/0x7d0 kernel/rcu/tree.c:3030
 afs_manage_cell+0x250/0x11c0 fs/afs/cell.c:751
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

The buggy address belongs to the object at ffff888093021000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 128 bytes inside of
 1024-byte region [ffff888093021000, ffff888093021400)
The buggy address belongs to the page:
page:00000000fb0f011a refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x93021
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002992c48 ffffea000249fd08 ffff8880aa040700
raw: 0000000000000000 ffff888093021000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888093020f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888093021000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888093021080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888093021100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888093021180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

