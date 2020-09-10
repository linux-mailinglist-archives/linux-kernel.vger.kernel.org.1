Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E70826530B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 23:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgIJV16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 17:27:58 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:56678 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbgIJOJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:09:47 -0400
Received: by mail-io1-f77.google.com with SMTP id d21so4363809iow.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ziOw32O95sze9u8CJpe9gs4JHZ+Uz+yoAuTHi7kjDRc=;
        b=b0otvuSIlp8GTicSNvJ3/rtbhHiASwIiBZ7VXZp2YAfanJy/88Zg7XcrYXmIKfYPIa
         SdP9jnw0k/th4WnJtGwml3EO4D5TL/oavzVj2dLeRn4Nz/BZMrq4EMxJDHufh8Tt//SN
         ZQAYljRl6Lf+cg5KrLlwkbIV39du/f4Ij5iDLqC3V5QyzR7MNDYq7WtMsGj3a3dJiA16
         v5lquuaGCKcni66jwxsk0OT66DgAv4YX3sRxCWfK7+yg6HjqHo5rObmIjpTV7WEgsw/O
         BTAuHCMymrabpJKrXnkgzyJrS+46FvLyETbWOL2YRwSOYk5khkpYc+fkwTa8abjKxZPW
         Va2Q==
X-Gm-Message-State: AOAM532BAiT+GvlMvE3oKVZEXXCS3UoRFbK9BBojANPcxAq8w0P3oL7g
        ugxFmj4uNSO6Q9KYjllSBnlPN77LwPbUUd9u1bPKAXabZvuK
X-Google-Smtp-Source: ABdhPJyVzD4q2XfFxYGBcsECrvAnCIle4pAH9rHxhi5nGa57FyzEBPeSM+aE9H+smqh70d6Z1BDkWGKZkB7dEHS9+gKrlZhH7cOl
MIME-Version: 1.0
X-Received: by 2002:a92:15c5:: with SMTP id 66mr7970147ilv.44.1599746964616;
 Thu, 10 Sep 2020 07:09:24 -0700 (PDT)
Date:   Thu, 10 Sep 2020 07:09:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e7c8f05aef61d8d@google.com>
Subject: KASAN: use-after-free Read in ucma_close (2)
From:   syzbot <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    34d4ddd3 Merge tag 'linux-kselftest-5.9-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1002ea2d900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
dashboard link: https://syzkaller.appspot.com/bug?extid=cc6fc752b3819e082d0c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1600e053900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ucma_close+0x2a4/0x310 drivers/infiniband/core/ucma.c:1839
Read of size 4 at addr ffff8880a748b538 by task syz-executor.0/7260

CPU: 0 PID: 7260 Comm: syz-executor.0 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 ucma_close+0x2a4/0x310 drivers/infiniband/core/ucma.c:1839
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
 exit_to_user_mode_prepare+0x1e1/0x200 kernel/entry/common.c:190
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:265
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x416f01
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffd5e376f90 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000416f01
RDX: 0000000000000001 RSI: 0000000000000080 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffd5e377080 R11: 0000000000000293 R12: 0000000001190ed0
R13: 000000000007fa65 R14: ffffffffffffffff R15: 000000000118cfec

Allocated by task 7261:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 kmem_cache_alloc_trace+0x174/0x2c0 mm/slab.c:3550
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 ucma_alloc_ctx+0x4b/0x480 drivers/infiniband/core/ucma.c:212
 ucma_create_id+0x11b/0x590 drivers/infiniband/core/ucma.c:502
 ucma_write+0x288/0x350 drivers/infiniband/core/ucma.c:1768
 vfs_write+0x2b0/0x730 fs/read_write.c:576
 ksys_write+0x1ee/0x250 fs/read_write.c:631
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 7261:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x10e/0x2b0 mm/slab.c:3756
 ucma_free_ctx+0x7f6/0xae0 drivers/infiniband/core/ucma.c:600
 ucma_destroy_id+0x30c/0x460 drivers/infiniband/core/ucma.c:644
 ucma_write+0x288/0x350 drivers/infiniband/core/ucma.c:1768
 vfs_write+0x2b0/0x730 fs/read_write.c:576
 ksys_write+0x1ee/0x250 fs/read_write.c:631
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880a748b400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 312 bytes inside of
 512-byte region [ffff8880a748b400, ffff8880a748b600)
The buggy address belongs to the page:
page:000000002b52c09c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xa748b
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002416c48 ffff8880aa041750 ffff8880aa040600
raw: 0000000000000000 ffff8880a748b000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a748b400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a748b480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880a748b500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff8880a748b580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a748b600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
