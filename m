Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5ED277FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 07:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgIYFSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 01:18:23 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:50829 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgIYFSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 01:18:22 -0400
Received: by mail-io1-f77.google.com with SMTP id b16so1071136iod.17
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 22:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Nkdq82SWYfvyCdrqiXTwJ+t8jc+pfzlYSaNzXtx7DF4=;
        b=k6kRETiisKV+kdhTdkbUO/WuKxApzE6pcXR5zBRUB3mLpLZ6sMhbSdoDDQkfVZcDuo
         PRVhYw3+LgB1HkLhIITWbdq26emyiWgVlfgpQzUwRRGr+cJisJhYoF6+7i56xh0AsrSU
         bnBJPbBWBQXY6N8s5CUPyYHbCPlDW+sNf3pOd43iMbp+QLKElUEHon3KDWFH0sX5c1cF
         s8dI7VgSgh6iukar+hQDYWWGNe3VQL1q3go37k6Zc0mvaM5k/D4djQr2izuEjGwYYaLP
         k33gxXALyIB623S4wjAFLVSMmj6VGi4ZnXyC65zjaIe5biXQj5+ALeN+zTIgCHITq/zx
         Hikg==
X-Gm-Message-State: AOAM533HXgVgSbeiC95boIzcSYvJZfdX0H/jQzUpe0bdZ5l88dC3+cmD
        HtI8e1Vem5j8M332W4+eLlZok2ICesufV8fjn3cCiV1ZRn4D
X-Google-Smtp-Source: ABdhPJzrVieSGhc67iYNPk5VQT5rcSPSbMce+KtoMb3z5EWN13qLul6OfWQoQMKSHWkF4SMUZiw9GC826vd3XVzpQTKJOPenk4N4
MIME-Version: 1.0
X-Received: by 2002:a05:6602:22d3:: with SMTP id e19mr1934292ioe.197.1601011101094;
 Thu, 24 Sep 2020 22:18:21 -0700 (PDT)
Date:   Thu, 24 Sep 2020 22:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6599a05b01c71ed@google.com>
Subject: KMSAN: uninit-value in udf_evict_inode
From:   syzbot <syzbot+91f02b28f9bb5f5f1341@syzkaller.appspotmail.com>
To:     glider@google.com, jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c5a13b33 kmsan: clang-format core
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=142cf809900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20f149ad694ba4be
dashboard link: https://syzkaller.appspot.com/bug?extid=91f02b28f9bb5f5f1341
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91f02b28f9bb5f5f1341@syzkaller.appspotmail.com

UDF-fs: warning (device loop3): udf_load_vrs: No anchor found
UDF-fs: Scanning with blocksize 512 failed
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2020/09/19 18:44 (1000)
UDF-fs: error (device loop3): udf_read_inode: (ino 1328) failed !bh
=====================================================
BUG: KMSAN: uninit-value in udf_evict_inode+0x382/0x7d0 fs/udf/inode.c:150
CPU: 0 PID: 13956 Comm: syz-executor.3 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:219
 udf_evict_inode+0x382/0x7d0 fs/udf/inode.c:150
 evict+0x4d3/0xec0 fs/inode.c:576
 iput_final fs/inode.c:1652 [inline]
 iput+0xc7b/0xf50 fs/inode.c:1678
 iget_failed+0x2cb/0x390 fs/bad_inode.c:242
 __udf_iget+0x111d/0x4650 fs/udf/inode.c:1914
 udf_iget fs/udf/udfdecl.h:147 [inline]
 udf_fill_super+0x2fa3/0x3330 fs/udf/super.c:2284
 mount_bdev+0x622/0x910 fs/super.c:1417
 udf_mount+0xc9/0xe0 fs/udf/super.c:127
 legacy_get_tree+0x163/0x2e0 fs/fs_context.c:592
 vfs_get_tree+0xd8/0x5d0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x3d1a/0x5d40 fs/namespace.c:3192
 do_mount+0x1c6/0x220 fs/namespace.c:3205
 __do_compat_sys_mount fs/compat.c:122 [inline]
 __se_compat_sys_mount+0x7b5/0xaa0 fs/compat.c:89
 __ia32_compat_sys_mount+0x62/0x80 fs/compat.c:89
 do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
 __do_fast_syscall_32+0x129/0x180 arch/x86/entry/common.c:139
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f94549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f558df20 EFLAGS: 00000292 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000f558df7c RCX: 0000000020000100
RDX: 0000000020000000 RSI: 0000000000000000 RDI: 00000000f558dfbc
RBP: 00000000f558df7c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:143 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:311
 __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:169
 udf_alloc_inode+0x2ab/0x2d0 fs/udf/super.c:154
 alloc_inode fs/inode.c:232 [inline]
 iget_locked+0x37a/0x13f0 fs/inode.c:1193
 __udf_iget+0x152/0x4650 fs/udf/inode.c:1902
 udf_iget fs/udf/udfdecl.h:147 [inline]
 udf_fill_super+0x2fa3/0x3330 fs/udf/super.c:2284
 mount_bdev+0x622/0x910 fs/super.c:1417
 udf_mount+0xc9/0xe0 fs/udf/super.c:127
 legacy_get_tree+0x163/0x2e0 fs/fs_context.c:592
 vfs_get_tree+0xd8/0x5d0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x3d1a/0x5d40 fs/namespace.c:3192
 do_mount+0x1c6/0x220 fs/namespace.c:3205
 __do_compat_sys_mount fs/compat.c:122 [inline]
 __se_compat_sys_mount+0x7b5/0xaa0 fs/compat.c:89
 __ia32_compat_sys_mount+0x62/0x80 fs/compat.c:89
 do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
 __do_fast_syscall_32+0x129/0x180 arch/x86/entry/common.c:139
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:143
 kmsan_internal_alloc_meta_for_pages mm/kmsan/kmsan_shadow.c:268 [inline]
 kmsan_alloc_page+0xc5/0x1a0 mm/kmsan/kmsan_shadow.c:292
 __alloc_pages_nodemask+0xf34/0x1120 mm/page_alloc.c:4927
 alloc_pages_current+0x685/0xb50 mm/mempolicy.c:2275
 alloc_pages include/linux/gfp.h:545 [inline]
 alloc_slab_page mm/slub.c:1634 [inline]
 allocate_slab+0x2fe/0x1180 mm/slub.c:1777
 new_slab mm/slub.c:1838 [inline]
 new_slab_objects mm/slub.c:2595 [inline]
 ___slab_alloc+0xd65/0x1940 mm/slub.c:2756
 __slab_alloc mm/slub.c:2796 [inline]
 slab_alloc_node mm/slub.c:2871 [inline]
 slab_alloc mm/slub.c:2916 [inline]
 kmem_cache_alloc+0x9fe/0xc80 mm/slub.c:2921
 udf_alloc_inode+0x60/0x2d0 fs/udf/super.c:144
 alloc_inode fs/inode.c:232 [inline]
 iget_locked+0x37a/0x13f0 fs/inode.c:1193
 __udf_iget+0x152/0x4650 fs/udf/inode.c:1902
 udf_iget fs/udf/udfdecl.h:147 [inline]
 udf_fill_super+0x2fa3/0x3330 fs/udf/super.c:2284
 mount_bdev+0x622/0x910 fs/super.c:1417
 udf_mount+0xc9/0xe0 fs/udf/super.c:127
 legacy_get_tree+0x163/0x2e0 fs/fs_context.c:592
 vfs_get_tree+0xd8/0x5d0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x3d1a/0x5d40 fs/namespace.c:3192
 do_mount+0x1c6/0x220 fs/namespace.c:3205
 __do_compat_sys_mount fs/compat.c:122 [inline]
 __se_compat_sys_mount+0x7b5/0xaa0 fs/compat.c:89
 __ia32_compat_sys_mount+0x62/0x80 fs/compat.c:89
 do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
 __do_fast_syscall_32+0x129/0x180 arch/x86/entry/common.c:139
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
