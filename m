Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BAA25E4F7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 03:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgIEBjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 21:39:20 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:33749 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgIEBjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 21:39:16 -0400
Received: by mail-il1-f208.google.com with SMTP id c11so6073122ilm.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 18:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4zGsNFYijbWGzsZhU1J2Ij+Non7iDftOX9OBQSATNjw=;
        b=KG0RSfzhbcIjDdHPFQoC15qvKNZrLPT47hlWGes3f2YNqR37Re/N1d/J/Ksej06AOi
         H/pM/BBIGDKMdRGV6mjrBriz39P8OwVGBA0rusVabOB36kjkDOfeYQe8WVkwfC/9ckEE
         0Vfe4XjX9DFG7UMAxUFNWpory8oG1SIFQhKY1LKBBa0DHts9x2HPgGI3P+KlWFyDiH7f
         FMmcKSJuQNHyHaolXI0TFiYhhxQVDuWs9EW6Nr5LSJUwCBBJxSDia9LUABYtLzFp57b7
         oRfP/uRoAxWoPLb2A8/UtQbbo6lv9NSdxGkMekRZS5+R9eykB8WomBauRGJYG9Ba0ms9
         xODA==
X-Gm-Message-State: AOAM5316xyn1L8Bu5dpN8sxZ/+LdgKH1N5UXuTjshfpIf9nBtD1NnrP+
        MNRe+fWf5jr+O9Z+pQxEsvcZZCu+mC9v5W733YmkgP0pw/yE
X-Google-Smtp-Source: ABdhPJykchBCYUJMnHs5L3IrokzmukDu/FGAElYzyqz3EdDZ13oktZVGwwu+CIdGyCbYji6vs6VGa+bRnOHPjQq5uhQ/g1hFSIzI
MIME-Version: 1.0
X-Received: by 2002:a02:ab85:: with SMTP id t5mr10602473jan.51.1599269955116;
 Fri, 04 Sep 2020 18:39:15 -0700 (PDT)
Date:   Fri, 04 Sep 2020 18:39:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009323e705ae870d48@google.com>
Subject: KASAN: use-after-free Read in delete_partition
From:   syzbot <syzbot+b8639c8dcb5ec4483d4f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, jack@suse.cz,
        johannes.thumshirn@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f75aef39 Linux 5.9-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130c72f5900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=b8639c8dcb5ec4483d4f
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c43c79900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173dfa1e900000

The issue was bisected to:

commit cddae808aeb77e5c29d22a8e0dfbdaed413f9e04
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Apr 14 07:28:54 2020 +0000

    block: pass a hd_struct to delete_partition

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14696476900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16696476900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12696476900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8639c8dcb5ec4483d4f@syzkaller.appspotmail.com
Fixes: cddae808aeb7 ("block: pass a hd_struct to delete_partition")

==================================================================
BUG: KASAN: use-after-free in kobject_put+0x220/0x270 lib/kobject.c:748
Read of size 1 at addr ffff8880978c7a3c by task syz-executor581/7048

CPU: 1 PID: 7048 Comm: syz-executor581 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 kobject_put+0x220/0x270 lib/kobject.c:748
 delete_partition+0x134/0x220 block/partitions/core.c:324
 bdev_del_partition+0x18b/0x1d0 block/partitions/core.c:549
 blkpg_do_ioctl+0x2d6/0x330 block/ioctl.c:33
 blkpg_ioctl block/ioctl.c:69 [inline]
 blkdev_ioctl+0x58a/0x700 block/ioctl.c:589
 block_ioctl+0xf9/0x140 fs/block_dev.c:1871
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446959
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 06 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fcab8868d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446959
RDX: 0000000020000000 RSI: 0000000000001269 RDI: 0000000000000005
RBP: 00000000006dbc30 R08: 00007fcab8869700 R09: 0000000000000000
R10: 00007fcab8869700 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 00000000000000a9 R14: 00b747111e42e3ec R15: 02ba2b7a04b8ac00

Allocated by task 7050:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 kmem_cache_alloc_trace+0x174/0x2c0 mm/slab.c:3550
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 kobject_create lib/kobject.c:783 [inline]
 kobject_create_and_add+0x42/0xb0 lib/kobject.c:809
 add_partition+0x989/0xd80 block/partitions/core.c:443
 bdev_add_partition+0xb6/0x130 block/partitions/core.c:518
 blkpg_do_ioctl+0x2be/0x330 block/ioctl.c:52
 blkpg_ioctl block/ioctl.c:69 [inline]
 blkdev_ioctl+0x58a/0x700 block/ioctl.c:589
 block_ioctl+0xf9/0x140 fs/block_dev.c:1871
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 7049:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x10e/0x2b0 mm/slab.c:3756
 kobject_cleanup lib/kobject.c:704 [inline]
 kobject_release lib/kobject.c:735 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x171/0x270 lib/kobject.c:752
 delete_partition+0x134/0x220 block/partitions/core.c:324
 bdev_del_partition+0x18b/0x1d0 block/partitions/core.c:549
 blkpg_do_ioctl+0x2d6/0x330 block/ioctl.c:33
 blkpg_ioctl block/ioctl.c:69 [inline]
 blkdev_ioctl+0x58a/0x700 block/ioctl.c:589
 block_ioctl+0xf9/0x140 fs/block_dev.c:1871
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880978c7a00
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 60 bytes inside of
 64-byte region [ffff8880978c7a00, ffff8880978c7a40)
The buggy address belongs to the page:
page:00000000d9b3b008 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x978c7
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00027750c8 ffff8880aa041350 ffff8880aa040200
raw: 0000000000000000 ffff8880978c7000 0000000100000020 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880978c7900: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff8880978c7980: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff8880978c7a00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                        ^
 ffff8880978c7a80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff8880978c7b00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
