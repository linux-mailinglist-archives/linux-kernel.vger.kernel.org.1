Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BAA278DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgIYQMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:12:24 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:54583 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYQMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:12:24 -0400
Received: by mail-io1-f77.google.com with SMTP id q6so2237712iod.21
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=y32m1nJzwKigyWDUgWkDCjgxQTraUD1nhrxbkLtURI0=;
        b=c0jgm3PzO76zlWDQKDgC2SXcU4K1y22kvmPUlOK00Jw080UavD1sNu7yg7/K6hQuXi
         Uzi+r1vFYOPSvaNjm4sLMJfAC+ZxrpMQoIjph+HydhFmko+irR4wIpNCSYp0B3fNVUDc
         z8Vos5CUGsd4C3Z9CWKzDiY4kIiWPD64SlZ/jYgoB5WCqXkjzqI06p3CH/I1c7KGxH+V
         fhpb4VxmbKbIxJSTfzFLTVcv1HJ4L3MAiEsSK93f+0O4WcvTM6o7blBZJeNzsBBypIy0
         71wCPMuwovUsEccWij+c18+GDIanpiS5snKtQ62EhLDF+uz+BvNKQBl9LT5g1ZycDuY0
         d2VQ==
X-Gm-Message-State: AOAM533720EHsYLeHmdC3+75qpae3/1nwaxX2W62Y9U6/lKaGjgsVvb0
        bpk5XBo4ZJgSubs5A08h8Ltut6A+zLkzzI0Dl3tlKgaaa/Qu
X-Google-Smtp-Source: ABdhPJwV3l/4UO4e2KYuzLXHOTYj9F/FG51bkfxYM2gCNgJxiG0q81nX7OHsPFGL6TVfwLuUdA9mKfvRvt1d2UyTjvpV+mhS2VER
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15c5:: with SMTP id f5mr821173iow.42.1601050342432;
 Fri, 25 Sep 2020 09:12:22 -0700 (PDT)
Date:   Fri, 25 Sep 2020 09:12:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eda45205b0259440@google.com>
Subject: KASAN: use-after-free Read in squashfs_get_id
From:   syzbot <syzbot+a296f64433c9cfd55cc8@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    171d4ff7 Merge tag 'mmc-v5.9-rc4-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122ff481900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af502ec9a451c9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=a296f64433c9cfd55cc8
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a296f64433c9cfd55cc8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in squashfs_get_id+0xb9/0x1c0 fs/squashfs/id.c:38
Read of size 8 at addr ffff88809daca0d8 by task syz-executor.1/31404

CPU: 0 PID: 31404 Comm: syz-executor.1 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 print_address_description+0x66/0x620 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 squashfs_get_id+0xb9/0x1c0 fs/squashfs/id.c:38
 squashfs_new_inode fs/squashfs/inode.c:51 [inline]
 squashfs_read_inode+0x155/0x2170 fs/squashfs/inode.c:120
 squashfs_fill_super+0x1478/0x1790 fs/squashfs/super.c:310
 get_tree_bdev+0x3e9/0x5f0 fs/super.c:1342
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x179d/0x29e0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount+0x126/0x180 fs/namespace.c:3390
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x460bca
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 dd 87 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 ba 87 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f17af019a88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f17af019b20 RCX: 0000000000460bca
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f17af019ae0
RBP: 00007f17af019ae0 R08: 00007f17af019b20 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 0000000020000040

Allocated by task 23539:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x100/0x130 mm/kasan/common.c:461
 __do_kmalloc mm/slab.c:3655 [inline]
 __kmalloc+0x205/0x300 mm/slab.c:3664
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 tomoyo_encode2+0x25a/0x560 security/tomoyo/realpath.c:45
 tomoyo_encode security/tomoyo/realpath.c:80 [inline]
 tomoyo_realpath_from_path+0x5d6/0x630 security/tomoyo/realpath.c:288
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x1b6/0x900 security/tomoyo/file.c:771
 security_file_open+0x50/0xc0 security/security.c:1574
 do_dentry_open+0x36b/0x1010 fs/open.c:804
 do_open fs/namei.c:3251 [inline]
 path_openat+0x2794/0x3840 fs/namei.c:3368
 do_filp_open+0x191/0x3a0 fs/namei.c:3395
 do_sys_openat2+0x463/0x830 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_open fs/open.c:1192 [inline]
 __se_sys_open fs/open.c:1188 [inline]
 __x64_sys_open+0x1af/0x1e0 fs/open.c:1188
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 23539:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:56
 kasan_set_free_info+0x17/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xdd/0x110 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x113/0x200 mm/slab.c:3756
 tomoyo_check_open_permission+0x6e2/0x900 security/tomoyo/file.c:786
 security_file_open+0x50/0xc0 security/security.c:1574
 do_dentry_open+0x36b/0x1010 fs/open.c:804
 do_open fs/namei.c:3251 [inline]
 path_openat+0x2794/0x3840 fs/namei.c:3368
 do_filp_open+0x191/0x3a0 fs/namei.c:3395
 do_sys_openat2+0x463/0x830 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_open fs/open.c:1192 [inline]
 __se_sys_open fs/open.c:1188 [inline]
 __x64_sys_open+0x1af/0x1e0 fs/open.c:1188
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88809daca0c0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 24 bytes inside of
 32-byte region [ffff88809daca0c0, ffff88809daca0e0)
The buggy address belongs to the page:
page:00000000f04bb05a refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88809dacafc1 pfn:0x9daca
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00024d0308 ffffea00028b2cc8 ffff8880aa440100
raw: ffff88809dacafc1 ffff88809daca000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88809dac9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88809daca000: fa fb fb fb fc fc fc fc 00 fc fc fc fc fc fc fc
>ffff88809daca080: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                                    ^
 ffff88809daca100: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88809daca180: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
