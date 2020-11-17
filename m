Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332AA2B6912
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgKQPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:50:25 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:36500 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKQPuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:50:24 -0500
Received: by mail-il1-f200.google.com with SMTP id r3so3423492ila.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 07:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WzypLJZ0W2xYd/DBN1bwzFmKnvSvkBGnI333H9DD1bc=;
        b=C4BPJFmNUlUzHtFVmv/U0DvubkSF+utnrPv3qNJCdQ0YrafyolBQ6cKO0QomlkpZm8
         a5aVWW+s/84f/Qyj960NsHkguebOcb2ODTP4kOpvNIeS5W/gD/5+zNJguM5QqF8OaIxh
         r6+GgSGgbnHosUSXq6YZ3UCADyVLpaSlMNrwiZM4EssHncVed3j90qYj3UTY1wCnt+lT
         wLqyY+dOcWL33B6tLQvTIRHnlMf8b49J/a5ZxuMQg/SxGIuQItn8Al5OeDR3hunHxlWa
         jgYjK++0F2Dnjo8HJ6v9Pq3wHbsxySkXWFoKoycIYH9n73hGzrBVtOgSs7lzLRf+GpqV
         NEEA==
X-Gm-Message-State: AOAM530yp5Dupml5Vpsc0UR4F2cgBsCIokodfKLyxXICYrhVgClSq7t0
        yVSYN+YOeWMY9fXK9folCjYDYCF82R/E5yWBxHfaRQOe4GN/
X-Google-Smtp-Source: ABdhPJxbW9ZfI7OpHgiFqjbad0QiPZXOkTbCDfmYQImXCegkaC50b99iNkIO/vFptgl8c2O2t4xjOE1vhvPo3CcHtF6xrwT6KlFg
MIME-Version: 1.0
X-Received: by 2002:a6b:b24b:: with SMTP id b72mr11980411iof.32.1605628222902;
 Tue, 17 Nov 2020 07:50:22 -0800 (PST)
Date:   Tue, 17 Nov 2020 07:50:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de161305b44f737a@google.com>
Subject: KMSAN: uninit-value in post_read_mst_fixup
From:   syzbot <syzbot+c0c75a90b18291d3f84e@syzkaller.appspotmail.com>
To:     anton@tuxera.com, glider@google.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    73d62e81 kmsan: random: prevent boot-time reports in _mix_..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1038fce2500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81c697c46ab63515
dashboard link: https://syzkaller.appspot.com/bug?extid=c0c75a90b18291d3f84e
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0c75a90b18291d3f84e@syzkaller.appspotmail.com

attempt to access beyond end of device
loop1: rw=0, want=2053, limit=137
attempt to access beyond end of device
loop1: rw=0, want=2054, limit=137
=====================================================
BUG: KMSAN: uninit-value in post_read_mst_fixup+0x606/0xba0 fs/ntfs/mst.c:39
CPU: 0 PID: 12872 Comm: syz-executor.1 Not tainted 5.10.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 post_read_mst_fixup+0x606/0xba0 fs/ntfs/mst.c:39
 ntfs_end_buffer_async_read+0xbf0/0x14f0 fs/ntfs/aops.c:133
 end_bio_bh_io_sync+0x174/0x230 fs/buffer.c:3005
 bio_endio+0x838/0x9c0 block/bio.c:1452
 submit_bio_checks+0x4ad/0x2230 block/blk-core.c:921
 submit_bio_noacct+0x60/0x1fd0 block/blk-core.c:1044
 submit_bio+0x526/0xa60 block/blk-core.c:1129
 submit_bh_wbc+0xdc0/0xe70 fs/buffer.c:3054
 submit_bh+0x97/0xc0 fs/buffer.c:3060
 ntfs_read_block fs/ntfs/aops.c:345 [inline]
 ntfs_readpage+0x3905/0x3d70 fs/ntfs/aops.c:435
 do_read_cache_page+0x1842/0x1d30 mm/filemap.c:2999
 read_cache_page+0xf3/0x110 mm/filemap.c:3098
 read_mapping_page include/linux/pagemap.h:500 [inline]
 ntfs_map_page fs/ntfs/aops.h:75 [inline]
 check_mft_mirror+0x7d1/0x3130 fs/ntfs/super.c:1109
 load_system_files fs/ntfs/super.c:1772 [inline]
 ntfs_fill_super+0x44e2/0xacd0 fs/ntfs/super.c:2893
 mount_bdev+0x619/0x900 fs/super.c:1419
 ntfs_mount+0xc9/0xe0 fs/ntfs/super.c:3050
 legacy_get_tree+0x163/0x2e0 fs/fs_context.c:592
 vfs_get_tree+0xd8/0x5d0 fs/super.c:1549
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x3d71/0x5d50 fs/namespace.c:3205
 do_mount fs/namespace.c:3218 [inline]
 __do_sys_mount fs/namespace.c:3426 [inline]
 __se_sys_mount+0x90c/0xa00 fs/namespace.c:3403
 __ia32_sys_mount+0x62/0x80 fs/namespace.c:3403
 do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
 __do_fast_syscall_32+0x102/0x160 arch/x86/entry/common.c:139
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7faf549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f55a8f20 EFLAGS: 00000292 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000f55a8f7c RCX: 0000000020000100
RDX: 0000000020000000 RSI: 0000000000000000 RDI: 00000000f55a8fbc
RBP: 00000000f55a8f7c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd3/0x1f0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x84e/0xfb0 mm/page_alloc.c:4989
 alloc_pages_current+0x79b/0xb40 mm/mempolicy.c:2271
 alloc_pages include/linux/gfp.h:547 [inline]
 __page_cache_alloc mm/filemap.c:977 [inline]
 do_read_cache_page+0x3e2/0x1d30 mm/filemap.c:2983
 read_cache_page+0xf3/0x110 mm/filemap.c:3098
 read_mapping_page include/linux/pagemap.h:500 [inline]
 ntfs_map_page fs/ntfs/aops.h:75 [inline]
 check_mft_mirror+0x7d1/0x3130 fs/ntfs/super.c:1109
 load_system_files fs/ntfs/super.c:1772 [inline]
 ntfs_fill_super+0x44e2/0xacd0 fs/ntfs/super.c:2893
 mount_bdev+0x619/0x900 fs/super.c:1419
 ntfs_mount+0xc9/0xe0 fs/ntfs/super.c:3050
 legacy_get_tree+0x163/0x2e0 fs/fs_context.c:592
 vfs_get_tree+0xd8/0x5d0 fs/super.c:1549
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x3d71/0x5d50 fs/namespace.c:3205
 do_mount fs/namespace.c:3218 [inline]
 __do_sys_mount fs/namespace.c:3426 [inline]
 __se_sys_mount+0x90c/0xa00 fs/namespace.c:3403
 __ia32_sys_mount+0x62/0x80 fs/namespace.c:3403
 do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
 __do_fast_syscall_32+0x102/0x160 arch/x86/entry/common.c:139
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
