Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3690E276DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgIXJk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:40:26 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:48187 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgIXJkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:40:23 -0400
Received: by mail-io1-f79.google.com with SMTP id u3so1940880iow.15
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bRDUlDLKnQM6nygJwVbG9UZUDw5LJ6+SKhb+BRPv494=;
        b=J4vrMyljeQnFMm/gdIJX/sxd6RiFvi94gsjbEKQsb5m0TK2zmbohlNcUJIFJzgSJ/v
         Qj88JvJbi15Mxgh/vZ3Q/axc5vgz8zfJ0QkQ2UnbJA93hjXRvVJf2W7pVb3Cs7i1Vrjn
         WrIhCNE2t0NhuCqgvlSKlh9kmv07P4yjJKB7Ueshq/kxmkc7jBRq3q8VvZYwGCkvBGv1
         0+JTGOpIl7hj+hLrcTFUgNalijfMXjjt8KL2eh8BSCRHdrfzu+HFOJj9VfMTyZNpdKqA
         3y9MrVgVA2n7qs2JvNzUHi/hnzbDCFvKiNPuOGjLeCw6RA/AjCk9fMoqD0ffh7ywznmF
         kXxQ==
X-Gm-Message-State: AOAM531qV7gyIIeM8vLB5NG1eW6cNnDAfZwNDfjf7URTOQMKYOorQl2H
        tzizDuZqkKCz8lCjpJPPqiveaKTqt/NZDOU2ha/ia5R3tdE0
X-Google-Smtp-Source: ABdhPJyFXRwDpVrd/z78MNqdvFWqMwzqmAdHvEH5WQzLT6iBM7+asIZhqLBBkxSlkrFmlsM/HR9VS5FUbA0+f2DFwdm297jytijj
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2a45:: with SMTP id k5mr2612312iov.1.1600940422163;
 Thu, 24 Sep 2020 02:40:22 -0700 (PDT)
Date:   Thu, 24 Sep 2020 02:40:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b775d05b00bfdee@google.com>
Subject: KASAN: use-after-free Write in afs_deactivate_cell
From:   syzbot <syzbot+1ecc2f9d3387f1d79d42@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e6499702 Add linux-next specific files for 20200922
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=129f3cc3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe45fda2f2c0a56a
dashboard link: https://syzkaller.appspot.com/bug?extid=1ecc2f9d3387f1d79d42
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ecc2f9d3387f1d79d42@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __hlist_del include/linux/list.h:831 [inline]
BUG: KASAN: use-after-free in hlist_del_rcu include/linux/rculist.h:514 [inline]
BUG: KASAN: use-after-free in afs_deactivate_cell+0x19a/0x1a0 fs/afs/cell.c:647
Write of size 8 at addr ffff8880979a2088 by task kworker/0:8/11772

CPU: 0 PID: 11772 Comm: kworker/0:8 Not tainted 5.9.0-rc6-next-20200922-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: afs afs_manage_cell
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 __hlist_del include/linux/list.h:831 [inline]
 hlist_del_rcu include/linux/rculist.h:514 [inline]
 afs_deactivate_cell+0x19a/0x1a0 fs/afs/cell.c:647
 afs_manage_cell+0x326/0x11c0 fs/afs/cell.c:721
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Allocated by task 15153:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 kmem_cache_alloc_trace+0x1a0/0x480 mm/slab.c:3548
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
 do_mount fs/namespace.c:3240 [inline]
 __do_sys_mount fs/namespace.c:3448 [inline]
 __se_sys_mount fs/namespace.c:3425 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3425
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 3147:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3416 [inline]
 kfree+0x10e/0x2a0 mm/slab.c:3754
 rcu_do_batch kernel/rcu/tree.c:2484 [inline]
 rcu_core+0x621/0x11d0 kernel/rcu/tree.c:2719
 __do_softirq+0x203/0xab6 kernel/softirq.c:298

Last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2961 [inline]
 call_rcu+0x15e/0x7d0 kernel/rcu/tree.c:3035
 afs_manage_cell+0x250/0x11c0 fs/afs/cell.c:751
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Second to last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2961 [inline]
 call_rcu+0x15e/0x7d0 kernel/rcu/tree.c:3035
 in6_dev_finish_destroy+0x143/0x1b0 net/ipv6/addrconf_core.c:264
 in6_dev_put include/net/addrconf.h:379 [inline]
 addrconf_ifdown.isra.0+0x12af/0x1590 net/ipv6/addrconf.c:3848
 addrconf_notify+0x55c/0x2310 net/ipv6/addrconf.c:3627
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2034
 call_netdevice_notifiers_extack net/core/dev.c:2046 [inline]
 call_netdevice_notifiers net/core/dev.c:2060 [inline]
 rollback_registered_many+0x97f/0x1550 net/core/dev.c:9331
 unregister_netdevice_many.part.0+0x1a/0x2f0 net/core/dev.c:10484
 unregister_netdevice_many net/core/dev.c:10483 [inline]
 default_device_exit_batch+0x30c/0x3d0 net/core/dev.c:10967
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:189
 cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:603
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

The buggy address belongs to the object at ffff8880979a2000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 136 bytes inside of
 1024-byte region [ffff8880979a2000, ffff8880979a2400)
The buggy address belongs to the page:
page:0000000003e82d85 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x979a2
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000279b408 ffffea000251f108 ffff8880aa040700
raw: 0000000000000000 ffff8880979a2000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880979a1f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880979a2000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880979a2080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff8880979a2100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880979a2180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
