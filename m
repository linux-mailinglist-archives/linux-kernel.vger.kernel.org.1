Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B533272129
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIUKcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:32:14 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:54089 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIUKcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:32:14 -0400
Received: by mail-io1-f77.google.com with SMTP id x1so5062501iov.20
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cQX96J9qqq0I4ZcQ2wpNDY4O1mcXmGsldktxAv2BKY4=;
        b=Dm63An/Ac4wlfJ1EbTM1JjFfpjqzB1UhrEMS4hOLmPzlxrI8E1dIUJXFeeUeHASGVb
         MLZmcCiFljeOuh2rKuYv9tJWuPQ46aZhmbVCIpxe5LSF8Lx9bEIrR3UMY5firDZW50+V
         6ojykYxZPBA8xhmLtwZrNsDM/WZd9FkVB5U57WCNmBIA4KSFr/g+vdbXGYRosLYtnqkj
         uuShfStYifb8OhWKpYNUHv0IOwddo7KD9WsrIhdMTDSttCHysHIV5hpOiDhXvDrpjaMa
         RhalLDg6QNMuqytt1RwHckrVwoF56i8Lsw/s83xC6gOpsJD+j+lFuLhI6IPyZF6tcxDV
         o/qQ==
X-Gm-Message-State: AOAM530CuRgdPQ0Y1KPyvDtZ8iHqx6DhV6FxgdqN9Rlp4blRgHkh+ayq
        bs4a0K9F7EHsqrGxRkSlPbuo3ts1B+RgvdY3beFnGmE1ZXG8
X-Google-Smtp-Source: ABdhPJwZGDkYtDveG4ToSODHqNh3e9sRJvLIeLj+PrvwmKuYkLKGLJ5Bg98Mh9u4P22SFYRIH2tk4bFD+Ztlg1KJ22bwQaJ6mnrP
MIME-Version: 1.0
X-Received: by 2002:a6b:f909:: with SMTP id j9mr36251767iog.184.1600684333125;
 Mon, 21 Sep 2020 03:32:13 -0700 (PDT)
Date:   Mon, 21 Sep 2020 03:32:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012d56705afd05d8b@google.com>
Subject: KASAN: use-after-free Read in afs_manage_cell
From:   syzbot <syzbot+18d51774588492bf3f69@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b652d2a5 Add linux-next specific files for 20200918
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10fbecad900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cf0782933432b43
dashboard link: https://syzkaller.appspot.com/bug?extid=18d51774588492bf3f69
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18d51774588492bf3f69@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in afs_activate_cell fs/afs/cell.c:622 [inline]
BUG: KASAN: use-after-free in afs_manage_cell+0xf9d/0x11c0 fs/afs/cell.c:697
Read of size 8 at addr ffff888096141a20 by task kworker/1:6/20450

CPU: 1 PID: 20450 Comm: kworker/1:6 Not tainted 5.9.0-rc5-next-20200918-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: afs afs_manage_cell
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 afs_activate_cell fs/afs/cell.c:622 [inline]
 afs_manage_cell+0xf9d/0x11c0 fs/afs/cell.c:697
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2269
 process_scheduled_works kernel/workqueue.c:2331 [inline]
 worker_thread+0x82b/0x1120 kernel/workqueue.c:2417
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Allocated by task 5410:
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
 path_mount+0x1266/0x1e70 fs/namespace.c:3216
 do_mount fs/namespace.c:3229 [inline]
 __do_sys_mount fs/namespace.c:3437 [inline]
 __se_sys_mount fs/namespace.c:3414 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3414
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 6900:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3416 [inline]
 kfree+0x10e/0x2a0 mm/slab.c:3754
 rcu_do_batch kernel/rcu/tree.c:2482 [inline]
 rcu_core+0x621/0x11d0 kernel/rcu/tree.c:2717
 __do_softirq+0x203/0xab6 kernel/softirq.c:298

Last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2959 [inline]
 call_rcu+0x15e/0x7d0 kernel/rcu/tree.c:3033
 afs_manage_cell+0x250/0x11c0 fs/afs/cell.c:751
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

The buggy address belongs to the object at ffff888096141800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 544 bytes inside of
 1024-byte region [ffff888096141800, ffff888096141c00)
The buggy address belongs to the page:
page:0000000010db85d7 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x96141
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00024a9e48 ffffea000088a308 ffff8880aa040700
raw: 0000000000000000 ffff888096141000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888096141900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888096141980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888096141a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888096141a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888096141b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
