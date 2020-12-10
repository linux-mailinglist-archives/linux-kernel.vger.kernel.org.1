Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE3F2D5875
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgLJKoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:44:06 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:53292 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgLJKnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:43:52 -0500
Received: by mail-io1-f69.google.com with SMTP id l20so3480099ioc.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NCPxeUIHWZ3Amx+H0vw2Kvn1FNhNqva+TWl/ZarpQ1I=;
        b=HQKVZzih4EAzuHJiorPoTTTAg7BwxKTskydA2BeH0ZdKS3wTT+q+P9NItMrgJpUiRP
         ruzz11JQ9Lb7wzC3Yh50wTLwAsxzuYdOFEMTAXQ33I23QjPMmzxqT68VUS2PijUIXu7N
         wLUme4aBxzez31q9GFYSYCzUFnw4uw2ptvquT6rg1yMCWSAad9+fhNSleRvcUpHEv8CA
         jpgd5bOVy3iMEUms3uDHjgwyIZdnpu2raIFMS5wRI5L6cpy/jrdXhkc3UOeK+uBzSfOK
         w+V6ZF1UbeUTp1xEmvtfuMZ7vVftdKn6QuqnC5wOQ79t4FDuHcWGC4B7seVgKMxmUaPi
         RlYg==
X-Gm-Message-State: AOAM533DQ+c6ehLFJZzrtavYgGfd5QjL5gJRwHUYznrW3xyKFNMHKUFA
        iTBJKdbjZsZD99+JGqvJmMfhn136Hwu73QqmxxNRXbbEPafz
X-Google-Smtp-Source: ABdhPJyXFGCuNR9u3GrGPx+k2gUvrEXp80aPgl8E4o0wa4u2D2T0ZGqENNBCw0LCawWz/C2Gm+VKTfcaGyQmlxPqCTAKM7nibbn7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:686:: with SMTP id o6mr8696203ils.8.1607596990634;
 Thu, 10 Dec 2020 02:43:10 -0800 (PST)
Date:   Thu, 10 Dec 2020 02:43:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091a3bc05b619d7ed@google.com>
Subject: KASAN: slab-out-of-bounds Read in squashfs_export_iget
From:   syzbot <syzbot+04419e3ff19d2970ea28@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com, elver@google.com,
        glider@google.com, jannh@google.com, linux-kernel@vger.kernel.org,
        phillip@squashfs.org.uk, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a9e26cb5 Add linux-next specific files for 20201208
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1674f80f500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e259434a8eaf0206
dashboard link: https://syzkaller.appspot.com/bug?extid=04419e3ff19d2970ea28
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136a6adf500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10457ccb500000

The issue was bisected to:

commit 555f63cd88404e122e8d31d0f925e430bd3f32d9
Author: Alexander Potapenko <glider@google.com>
Date:   Fri Dec 4 03:19:29 2020 +0000

    mm, kfence: insert KFENCE hooks for SLUB

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1619bb7f500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1519bb7f500000
console output: https://syzkaller.appspot.com/x/log.txt?x=1119bb7f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04419e3ff19d2970ea28@syzkaller.appspotmail.com
Fixes: 555f63cd8840 ("mm, kfence: insert KFENCE hooks for SLUB")

loop0: detected capacity change from 264192 to 0
==================================================================
BUG: KASAN: slab-out-of-bounds in squashfs_inode_lookup fs/squashfs/export.c:44 [inline]
BUG: KASAN: slab-out-of-bounds in squashfs_export_iget+0x274/0x2a0 fs/squashfs/export.c:69
Read of size 8 at addr ffff88801c6f6e08 by task syz-executor839/8488

CPU: 0 PID: 8488 Comm: syz-executor839 Not tainted 5.10.0-rc7-next-20201208-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 squashfs_inode_lookup fs/squashfs/export.c:44 [inline]
 squashfs_export_iget+0x274/0x2a0 fs/squashfs/export.c:69
 squashfs_fh_to_dentry fs/squashfs/export.c:84 [inline]
 squashfs_fh_to_dentry+0x78/0xb0 fs/squashfs/export.c:77
 exportfs_decode_fh_raw+0x127/0x7a0 fs/exportfs/expfs.c:436
 exportfs_decode_fh+0x38/0x90 fs/exportfs/expfs.c:575
 do_handle_to_path fs/fhandle.c:152 [inline]
 handle_to_path fs/fhandle.c:207 [inline]
 do_handle_open+0x2b6/0x7f0 fs/fhandle.c:223
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4443d9
Code: 8d d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd937fcd78 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 00000000004443d9
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000005
RBP: 00000000006cf018 R08: 00007ffd00000015 R09: 00000000004002e0
R10: 00007ffd937fcc20 R11: 0000000000000246 R12: 0000000000401fc0
R13: 0000000000402050 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6500:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:39
 kasan_set_track mm/kasan/common.c:47 [inline]
 set_alloc_info mm/kasan/common.c:405 [inline]
 ____kasan_kmalloc mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc.constprop.0+0xa0/0xd0 mm/kasan/common.c:408
 kmalloc include/linux/slab.h:570 [inline]
 kzalloc include/linux/slab.h:695 [inline]
 lsm_cred_alloc security/security.c:534 [inline]
 security_prepare_creds+0x10e/0x190 security/security.c:1633
 prepare_creds+0x509/0x730 kernel/cred.c:285
 access_override_creds fs/open.c:353 [inline]
 do_faccessat+0x3d7/0x870 fs/open.c:417
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88801c6f6de8
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 24 bytes to the right of
 8-byte region [ffff88801c6f6de8, ffff88801c6f6df0)
The buggy address belongs to the page:
page:0000000061a643f0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801c6f6de8 pfn:0x1c6f6
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 ffffea0000625500 0000000500000005 ffff888010841c80
raw: ffff88801c6f6de8 000000008066005d 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88801c6f6d00: fc fc fc fc fb fc fc fc fc fb fc fc fc fc fb fc
 ffff88801c6f6d80: fc fc fc fb fc fc fc fc fa fc fc fc fc fb fc fc
>ffff88801c6f6e00: fc fc 00 fc fc fc fc fa fc fc fc fc fb fc fc fc
                      ^
 ffff88801c6f6e80: fc 00 fc fc fc fc fa fc fc fc fc fb fc fc fc fc
 ffff88801c6f6f00: 00 fc fc fc fc fa fc fc fc fc fb fc fc fc fc fb
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
