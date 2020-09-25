Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D663127835E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgIYI5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:57:17 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:46165 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:57:17 -0400
Received: by mail-io1-f79.google.com with SMTP id j8so1364343iof.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OqcmLpdXy+hASix4NnCNuf33xA9NJKVh8iYoEeczfKM=;
        b=JNPEJziSLWl63quczKUCd9OdR1DYSismEwP76m+yHd1P7qJjhjYy+ugXK45qAY7AY6
         oqBm2gl93fq9hAfjGElxKnknEWnO0pPhz5Ilxbt9FhEaHBg16MxmQ1MjHKMzZC1yuo0P
         pGvUuPpJKJiOBWInMK1nNg0ad+iItqDCEqrqzIx9XU/j1Z2i9dzmszXL+8cMACiGxn3Z
         niaDsJ6X1q1Lp1eoz98cRSQy4oaKxFnIFxQH/tKYXSRKCEMlRULiWxRaUYzHrmvU0w5S
         R8C0+hW5G/A2rm9GSAqR9xf/0zPcTgKC21UV/B1EFMLc6nvZxVX1X8rpz/dkwTEnnjDT
         uc8A==
X-Gm-Message-State: AOAM5320DGpGwDeGdDTgVe83cnQPkgbQMFdunWMcCx0EdcfTS40Z13sZ
        ZexNTzwKV73+RaVuKJ4+pDMy0dhN2iajmKa/u6Gb4roNtRTt
X-Google-Smtp-Source: ABdhPJzqO3jRueqWHyhWMBum48eXT3lVJMOTEJzpiOi+/+cVqP/HTUFVPgZjrDn5gvWox2ifCRBejKn/7CgC568RW+UR1dDlz4wM
MIME-Version: 1.0
X-Received: by 2002:a5e:9419:: with SMTP id q25mr2438115ioj.205.1601024236397;
 Fri, 25 Sep 2020 01:57:16 -0700 (PDT)
Date:   Fri, 25 Sep 2020 01:57:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e32a8b05b01f808a@google.com>
Subject: KASAN: use-after-free Read in fscache_alloc_cookie
From:   syzbot <syzbot+2d0585e5efcd43d113c2@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    171d4ff7 Merge tag 'mmc-v5.9-rc4-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d457b5900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f4c828c9e3cef97
dashboard link: https://syzkaller.appspot.com/bug?extid=2d0585e5efcd43d113c2
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a33ad3900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d0585e5efcd43d113c2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in memcpy include/linux/string.h:406 [inline]
BUG: KASAN: use-after-free in fscache_set_key fs/fscache/cookie.c:93 [inline]
BUG: KASAN: use-after-free in fscache_alloc_cookie+0xff/0x730 fs/fscache/cookie.c:153
Read of size 10 at addr ffff8880a6c28200 by task kworker/1:6/8760

CPU: 1 PID: 8760 Comm: kworker/1:6 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: afs afs_manage_cell
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 memcpy+0x20/0x60 mm/kasan/common.c:105
 memcpy include/linux/string.h:406 [inline]
 fscache_set_key fs/fscache/cookie.c:93 [inline]
 fscache_alloc_cookie+0xff/0x730 fs/fscache/cookie.c:153
 __fscache_acquire_cookie+0x16c/0x610 fs/fscache/cookie.c:288
 fscache_acquire_cookie include/linux/fscache.h:334 [inline]
 afs_activate_cell fs/afs/cell.c:609 [inline]
 afs_manage_cell+0x4fa/0x11c0 fs/afs/cell.c:697
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 10197:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 __do_kmalloc mm/slab.c:3655 [inline]
 __kmalloc+0x1b0/0x360 mm/slab.c:3664
 kmalloc include/linux/slab.h:559 [inline]
 afs_alloc_cell fs/afs/cell.c:157 [inline]
 afs_lookup_cell+0x5e9/0x1440 fs/afs/cell.c:262
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

Freed by task 16:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x10e/0x2b0 mm/slab.c:3756
 afs_cell_destroy+0x1b0/0x240 fs/afs/cell.c:500
 rcu_do_batch kernel/rcu/tree.c:2428 [inline]
 rcu_core+0x5ca/0x1130 kernel/rcu/tree.c:2656
 __do_softirq+0x1f8/0xb23 kernel/softirq.c:298

The buggy address belongs to the object at ffff8880a6c28200
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 32-byte region [ffff8880a6c28200, ffff8880a6c28220)
The buggy address belongs to the page:
page:00000000c2f50dc7 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880a6c28fc1 pfn:0xa6c28
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00028969c8 ffffea00025ca748 ffff8880aa040100
raw: ffff8880a6c28fc1 ffff8880a6c28000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a6c28100: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880a6c28180: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880a6c28200: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                   ^
 ffff8880a6c28280: 00 00 00 00 fc fc fc fc 00 fc fc fc fc fc fc fc
 ffff8880a6c28300: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
