Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4A02D805E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392109AbgLKVEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:04:16 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:53926 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbgLKVDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:03:52 -0500
Received: by mail-il1-f197.google.com with SMTP id q2so8190244ilt.20
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/6F3RXalHgOzVu9rfB8RHBjhKhY3G02Ggw1yXVxJRB4=;
        b=CSou1uWyvJZmBEAVDRYeJebce5YVzY97ZM7Xk9tXbE29RlBst+89CkcXSGu9aZWQxa
         jC7GOeseddWmQPQEZySHOFra4fOuTS6FCvqatVOytj4NUECfoHG61p5K+yMwrS+u2yJb
         3H3btXxv3NXunSHj0doG/K10klv5rEPHEmbAcwwMoFScjHL9HZipazh28CUMcL8tqkfM
         iIuBjnLmAHESGIZZoWfxPPVHVnLOZdNFSF51PmIPKkz7XEIZHtVwdGkgYy2Q+K5DLMyd
         qRoC+Wrn+xBK/4CS+6LG5lwoulN9NZ6Tq2iN8V6/g+1p1Km6a9dpKThpRha/Nc+eQVpR
         n3Ng==
X-Gm-Message-State: AOAM530x7ZhT5iO7sdnO2cFza1AWsDjmx9PLlaDG7t81fi6PGXLkbqJI
        xD2dGhvBbNiAsUd5DzazMKqE3uZ9dQgRdBEhZOoijNWuXb0J
X-Google-Smtp-Source: ABdhPJxqFsmtqhxHB9Xnc82nSiuKEv7r0d/7k52qSXrw+7TBiSuMDc59y7RKHpB+ZvEZhFR+/sqwAqDvs4AKwcgazrEp0m0eVpsD
MIME-Version: 1.0
X-Received: by 2002:a5e:990c:: with SMTP id t12mr17387076ioj.33.1607720591516;
 Fri, 11 Dec 2020 13:03:11 -0800 (PST)
Date:   Fri, 11 Dec 2020 13:03:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c167dd05b6369e69@google.com>
Subject: KASAN: use-after-free Read in disk_part_iter_next
From:   syzbot <syzbot+825f0f9657d4e528046e@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15ac8fdb Add linux-next specific files for 20201207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15d8ad37500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3696b8138207d24d
dashboard link: https://syzkaller.appspot.com/bug?extid=825f0f9657d4e528046e
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1393dcbd500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1074cf17500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+825f0f9657d4e528046e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in bdev_nr_sectors include/linux/genhd.h:264 [inline]
BUG: KASAN: use-after-free in disk_part_iter_next+0x4c7/0x560 block/genhd.c:204
Read of size 8 at addr ffff88814080b9a8 by task syz-executor825/9848

CPU: 1 PID: 9848 Comm: syz-executor825 Not tainted 5.10.0-rc6-next-20201207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 bdev_nr_sectors include/linux/genhd.h:264 [inline]
 disk_part_iter_next+0x4c7/0x560 block/genhd.c:204
 partition_overlaps+0x96/0x200 block/partitions/core.c:425
 bdev_add_partition+0x66/0x130 block/partitions/core.c:444
 blkpg_do_ioctl+0x2d0/0x340 block/ioctl.c:43
 blkpg_ioctl block/ioctl.c:60 [inline]
 blkdev_ioctl+0x577/0x6d0 block/ioctl.c:541
 block_ioctl+0xf9/0x140 fs/block_dev.c:1649
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x447ff9
Code: dd ca fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 ab ca fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff3c27c398 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000447ff9
RDX: 0000000020000240 RSI: 0000000000001269 RDI: 0000000000000003
RBP: 00000000000148cc R08: 0000000200000000 R09: 0000000200000000
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000404fc0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9811:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:39
 kasan_set_track mm/kasan/common.c:47 [inline]
 set_alloc_info mm/kasan/common.c:405 [inline]
 ____kasan_kmalloc mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc.constprop.0+0xa0/0xd0 mm/kasan/common.c:408
 kasan_slab_alloc include/linux/kasan.h:205 [inline]
 slab_post_alloc_hook mm/slab.h:518 [inline]
 slab_alloc_node mm/slub.c:2903 [inline]
 slab_alloc mm/slub.c:2911 [inline]
 kmem_cache_alloc+0x155/0x380 mm/slub.c:2916
 bdev_alloc_inode+0x18/0x40 fs/block_dev.c:777
 alloc_inode+0x61/0x230 fs/inode.c:233
 new_inode_pseudo fs/inode.c:927 [inline]
 new_inode+0x27/0x2f0 fs/inode.c:956
 bdev_alloc+0x20/0x340 fs/block_dev.c:864
 add_partition+0x1ad/0x8e0 block/partitions/core.c:345
 bdev_add_partition+0xb6/0x130 block/partitions/core.c:449
 blkpg_do_ioctl+0x2d0/0x340 block/ioctl.c:43
 blkpg_ioctl block/ioctl.c:60 [inline]
 blkdev_ioctl+0x577/0x6d0 block/ioctl.c:541
 block_ioctl+0xf9/0x140 fs/block_dev.c:1649
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 17:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:39
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:47
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:355
 ____kasan_slab_free.part.0+0xe1/0x110 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:188 [inline]
 slab_free_hook mm/slub.c:1548 [inline]
 slab_free_freelist_hook+0x82/0x1d0 mm/slub.c:1586
 slab_free mm/slub.c:3157 [inline]
 kmem_cache_free+0x82/0x360 mm/slub.c:3173
 i_callback+0x3f/0x70 fs/inode.c:222
 rcu_do_batch kernel/rcu/tree.c:2502 [inline]
 rcu_core+0x735/0x1020 kernel/rcu/tree.c:2737
 __do_softirq+0x2b7/0xa76 kernel/softirq.c:343

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:39
 kasan_record_aux_stack+0xdc/0x100 mm/kasan/generic.c:343
 __call_rcu kernel/rcu/tree.c:2987 [inline]
 call_rcu+0xbb/0x810 kernel/rcu/tree.c:3062
 destroy_inode+0x129/0x1b0 fs/inode.c:288
 iput_final fs/inode.c:1651 [inline]
 iput.part.0+0x41e/0x840 fs/inode.c:1677
 iput+0x58/0x70 fs/inode.c:1667
 disk_part_iter_exit block/genhd.c:232 [inline]
 disk_part_iter_next+0x9a/0x560 block/genhd.c:200
 blk_drop_partitions+0x10a/0x180 block/partitions/core.c:541
 bdev_disk_changed+0x238/0x430 fs/block_dev.c:1228
 loop_reread_partitions+0x29/0x50 drivers/block/loop.c:655
 loop_set_status+0x735/0x1040 drivers/block/loop.c:1416
 loop_set_status64 drivers/block/loop.c:1536 [inline]
 lo_ioctl+0x900/0x1720 drivers/block/loop.c:1704
 blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:576
 block_ioctl+0xf9/0x140 fs/block_dev.c:1649
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Second to last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:39
 kasan_record_aux_stack+0xdc/0x100 mm/kasan/generic.c:343
 __call_rcu kernel/rcu/tree.c:2987 [inline]
 call_rcu+0xbb/0x810 kernel/rcu/tree.c:3062
 destroy_inode+0x129/0x1b0 fs/inode.c:288
 iput_final fs/inode.c:1651 [inline]
 iput.part.0+0x41e/0x840 fs/inode.c:1677
 iput+0x58/0x70 fs/inode.c:1667
 disk_release+0x191/0x240 block/genhd.c:1212
 device_release+0x9f/0x240 drivers/base/core.c:1804
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3033
 put_disk+0x44/0x60 block/genhd.c:1414
 do_floppy_init drivers/block/floppy.c:4826 [inline]
 floppy_async_init+0x2004/0x2033 drivers/block/floppy.c:4834
 async_run_entry_fn+0xf3/0x730 kernel/async.c:123
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

The buggy address belongs to the object at ffff88814080b980
 which belongs to the cache bdev_cache of size 2808
The buggy address is located 40 bytes inside of
 2808-byte region [ffff88814080b980, ffff88814080c478)
The buggy address belongs to the page:
page:0000000095b89171 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x140808
head:0000000095b89171 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x57ff00000010200(slab|head)
raw: 057ff00000010200 0000000000000000 0000000100000001 ffff8880109c0b40
raw: 0000000000000000 00000000800b000b 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88814080b880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
 ffff88814080b900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88814080b980: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88814080ba00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88814080ba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
