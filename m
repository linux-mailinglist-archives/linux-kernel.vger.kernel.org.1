Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB07B271EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgIUJYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:24:22 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:33562 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgIUJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:24:22 -0400
Received: by mail-il1-f206.google.com with SMTP id e73so9173126ill.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qiTKQwL3XM6zXgcpix7+ZdXj4HvcCZ7q2UN4c9ZsRak=;
        b=gMGeBlBD6MfG0yh9VhKblw7h5AHiTBTrGZdqCgYq9DZLojE6GblL8DYiHIu80M1i/s
         TrBi4Ll0Y1kmN3yQzb1V4flyKHGAk0UkU0G52wcMt9+aSKgdLgoGn/5MK+xRiMg6eSTS
         9n+4JNGkYmtG2o8J4hRMd6phhPBpfnikiGI7ma+eLFF0lTCqzsQNYDE06Vk0wZgdLhwO
         xb4zTxae2KPQpYMD+zW6uO7TRf1SDeEYyWrWFxDQD6Cj/fTJsPYc0MKkjrR8ilkIkxTE
         NGYBlmGSJE/C2ox4SGj5SxkT4c7y/aXSbs+uYg6+WYo2hyfyszR5AFOiVgkl7UPunLIO
         3rVA==
X-Gm-Message-State: AOAM532ouSSoWxpeByLieONSexdl/e5vg1PunoXbX1Xvj4/KTf3lGHeS
        BW5nAaaN/e/MyNlPwG2sdZqt5IZfmjiRcisHe0ywRymy5TyC
X-Google-Smtp-Source: ABdhPJwUGvlP8dJdK+QsaVHy0n+nKeR9AnUmGVu1IQ7OE19PZ86JjchDouymoRyTM34EXa+Bj3RbN4CO5G5Rka6NZP7BzLNNb1HA
MIME-Version: 1.0
X-Received: by 2002:a5d:870c:: with SMTP id u12mr37098029iom.129.1600680261024;
 Mon, 21 Sep 2020 02:24:21 -0700 (PDT)
Date:   Mon, 21 Sep 2020 02:24:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b805d05afcf6ab8@google.com>
Subject: KASAN: use-after-free Read in lbmIODone
From:   syzbot <syzbot+5d2008bd1f1b722ba94e@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ba4f184e Linux 5.9-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173946c5900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f4c828c9e3cef97
dashboard link: https://syzkaller.appspot.com/bug?extid=5d2008bd1f1b722ba94e
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d2008bd1f1b722ba94e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in lbmIODone+0xcd4/0xf60 fs/jfs/jfs_logmgr.c:2193
Read of size 4 at addr ffff88808b37ab08 by task ksoftirqd/1/16

CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 lbmIODone+0xcd4/0xf60 fs/jfs/jfs_logmgr.c:2193
 bio_endio+0x3cf/0x7f0 block/bio.c:1449
 req_bio_endio block/blk-core.c:259 [inline]
 blk_update_request+0x68f/0x1500 block/blk-core.c:1577
 blk_mq_end_request+0x4c/0x510 block/blk-mq.c:562
 lo_complete_rq+0x20d/0x2d0 drivers/block/loop.c:500
 blk_done_softirq+0x33c/0x4d0 block/blk-mq.c:586
 __do_softirq+0x1f8/0xb23 kernel/softirq.c:298
 run_ksoftirqd kernel/softirq.c:652 [inline]
 run_ksoftirqd+0xcf/0x170 kernel/softirq.c:644
 smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 29777:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 kmem_cache_alloc_trace+0x174/0x300 mm/slab.c:3550
 kmalloc include/linux/slab.h:554 [inline]
 lbmLogInit fs/jfs/jfs_logmgr.c:1829 [inline]
 lmLogInit+0x30b/0x1400 fs/jfs/jfs_logmgr.c:1278
 open_inline_log fs/jfs/jfs_logmgr.c:1183 [inline]
 lmLogOpen+0x726/0x11f0 fs/jfs/jfs_logmgr.c:1077
 jfs_mount_rw+0x286/0x4b0 fs/jfs/jfs_mount.c:259
 jfs_fill_super+0x860/0xbc0 fs/jfs/super.c:571
 mount_bdev+0x32e/0x3f0 fs/super.c:1417
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 6891:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x10e/0x2b0 mm/slab.c:3756
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1872 [inline]
 lmLogShutdown+0x2c6/0x580 fs/jfs/jfs_logmgr.c:1691
 lmLogClose+0x4ae/0x620 fs/jfs/jfs_logmgr.c:1467
 jfs_umount+0x26f/0x320 fs/jfs/jfs_umount.c:116
 jfs_put_super+0x61/0x140 fs/jfs/super.c:194
 generic_shutdown_super+0x144/0x370 fs/super.c:464
 kill_block_super+0x97/0xf0 fs/super.c:1444
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 deactivate_super+0xad/0xd0 fs/super.c:366
 cleanup_mnt+0x3a3/0x530 fs/namespace.c:1118
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:165 [inline]
 exit_to_user_mode_prepare+0x1e1/0x200 kernel/entry/common.c:192
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:267
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88808b37ab00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 8 bytes inside of
 192-byte region [ffff88808b37ab00, ffff88808b37abc0)
The buggy address belongs to the page:
page:00000000dc0ca20a refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88808b37ac00 pfn:0x8b37a
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002a56b48 ffffea00025a3088 ffff8880aa040000
raw: ffff88808b37ac00 ffff88808b37a000 000000010000000a 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88808b37aa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88808b37aa80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88808b37ab00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88808b37ab80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88808b37ac00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
