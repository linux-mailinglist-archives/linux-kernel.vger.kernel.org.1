Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57516276D37
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgIXJ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:26:39 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:40334 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgIXJ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:26:31 -0400
Received: by mail-io1-f77.google.com with SMTP id f8so1939450iow.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=otfHJ0f9hgCs1ewN99rIs1KuCfluF9LocJ85WkVFjiM=;
        b=ghXtupuu8UAWZZagQR9wS/zqOVs1SX6EqS/U2m+grm5Xcowup7Tf7C447l4tzFxsfN
         IiVldYJKMK0e/3Es7TzxWN9WG6QOM5mlvPoOWcsXAIWTP9+eYAr1/FGMWjoD6Nmv/KIX
         i0k/ttOaKSgsqFwOZAxMb0BOk+PRzLl2LtG1V07yG53I9UtuDDLde3ruseg3NXPhCapB
         2ArEzuvqxOL8cGXbQXwmpvDBigCCVqSbyQ3mT5oP2yMVHKUUMp2F9HuJK1tHpZf6Poaf
         HZmv5eveJw4BbzI6C0Y7MNube/f08Y+htihqKEppT0Kctjbk4wMkdv8iZJbCQU/S7mNV
         CznQ==
X-Gm-Message-State: AOAM531Zcm3dulyAuChL2LtHM7fkDEmUWu1cd/WovHvQR56JqPyqlWMG
        ubvSwYU4D35tKoTS9e/CCLLDjmtQ36YdUR4smsKhhCZoHVPM
X-Google-Smtp-Source: ABdhPJxbl+sY5zjIGOLG8VMjrrK+7uLjersuB+1zMXvStYAV/B2/fDLy5vWemgVjtYhaunTTEKBdCXPIXpTPRkBWhoSs/2GomKQt
MIME-Version: 1.0
X-Received: by 2002:a02:605c:: with SMTP id d28mr2801004jaf.12.1600939589842;
 Thu, 24 Sep 2020 02:26:29 -0700 (PDT)
Date:   Thu, 24 Sep 2020 02:26:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f4fbc05b00bcbd5@google.com>
Subject: KMSAN: uninit-value in udf_get_pblock_spar15
From:   syzbot <syzbot+9991561e714f597095da@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12152c81900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20f149ad694ba4be
dashboard link: https://syzkaller.appspot.com/bug?extid=9991561e714f597095da
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9991561e714f597095da@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in udf_get_pblock_spar15+0x4de/0x6b0 fs/udf/partition.c:138
CPU: 0 PID: 27543 Comm: syz-executor.4 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:219
 udf_get_pblock_spar15+0x4de/0x6b0 fs/udf/partition.c:138
 udf_get_pblock+0x1e9/0x2e0 fs/udf/partition.c:41
 udf_get_lb_pblock fs/udf/udfdecl.h:212 [inline]
 udf_read_ptagged+0x105/0x1d0 fs/udf/misc.c:262
 udf_find_fileset fs/udf/super.c:828 [inline]
 udf_fill_super+0x2238/0x3330 fs/udf/super.c:2262
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
RIP: 0023:0xf7f40549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5539f20 EFLAGS: 00000292 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000f5539f7c RCX: 0000000020000100
RDX: 0000000020000000 RSI: 0000000000000000 RDI: 00000000f5539fbc
RBP: 00000000f5539f7c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:143
 kmsan_internal_alloc_meta_for_pages mm/kmsan/kmsan_shadow.c:268 [inline]
 kmsan_alloc_page+0xc5/0x1a0 mm/kmsan/kmsan_shadow.c:292
 __alloc_pages_nodemask+0xf34/0x1120 mm/page_alloc.c:4927
 alloc_pages_current+0x685/0xb50 mm/mempolicy.c:2275
 alloc_pages include/linux/gfp.h:545 [inline]
 __page_cache_alloc+0xc8/0x310 mm/filemap.c:957
 pagecache_get_page+0xe81/0x1cd0 mm/filemap.c:1710
 find_or_create_page include/linux/pagemap.h:348 [inline]
 grow_dev_page+0x1aa/0xde0 fs/buffer.c:974
 grow_buffers fs/buffer.c:1043 [inline]
 __getblk_slow fs/buffer.c:1070 [inline]
 __getblk_gfp+0x464/0x6a0 fs/buffer.c:1354
 __bread_gfp+0xbc/0x7c0 fs/buffer.c:1399
 udf_tread fs/udf/udf_sb.h:159 [inline]
 udf_read_tagged+0x244/0xd90 fs/udf/misc.c:210
 udf_load_sparable_map fs/udf/super.c:1359 [inline]
 udf_load_logicalvol fs/udf/super.c:1450 [inline]
 udf_process_sequence+0x5593/0x6eb0 fs/udf/super.c:1750
 udf_load_sequence fs/udf/super.c:1795 [inline]
 udf_check_anchor_block+0x50e/0x880 fs/udf/super.c:1835
 udf_scan_anchors+0x27c/0xc60 fs/udf/super.c:1868
 udf_find_anchor fs/udf/super.c:1925 [inline]
 udf_load_vrs+0x33f/0x15b0 fs/udf/super.c:1990
 udf_fill_super+0x1287/0x3330 fs/udf/super.c:2183
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
