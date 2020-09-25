Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891F7278B32
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgIYOsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:48:17 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:49285 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgIYOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:48:17 -0400
Received: by mail-il1-f206.google.com with SMTP id o18so2116492ilm.16
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NLbhA0MNzQWyjiwK8rit/u8dEHMQgc8u5ck6yfbA7AA=;
        b=BUPKlM3gDDHGmGNWADHiqtaI6QTnqQh08jEvj0AzUJhp39LcEHHWwnm5Y8/W+idl+4
         WZqMW1EPCsBz+lKXJe5SL54is4iLZVXPkceb7BWCVf6BdtEP8VyG6Snfw5xI0nIZTJzc
         CLxud+o0wPLYbdizP1OMtiu5uoAEsGUzJOnn693N/WgrjMc1bxb0q3xakU/+DyeWkNcX
         vMsg5LS+YuVncqZwNcAdc2rrbeFv9fMmSB538jm6nznDyYtlCh37YffaxCFVE1nU5gpt
         EwLw4zKrveJVaeZzBPeaL+0L4lYpF+oQt9VZlOt82uaWQr7MTAi2WekrEXvUXxbXm3lM
         DR9Q==
X-Gm-Message-State: AOAM531Bm9cWNs0tsRrSoIFY5564uQY36RVS6f9XrAqhpkYalL3c7byI
        KaiqK+jJd5J3KhlIDcaBA9AfCcpDtMKt5N7WOxtVQcGhYxnJ
X-Google-Smtp-Source: ABdhPJxCAVtUEORAWMFHBbnDJxmxpWqpMy38Av1h6iGbuKb/PvR3vffkuHlS3TT1S/Oqn/zrASYUnxuZ+QShogEqxoqRMcg0+9+J
MIME-Version: 1.0
X-Received: by 2002:a92:4982:: with SMTP id k2mr499127ilg.240.1601045296401;
 Fri, 25 Sep 2020 07:48:16 -0700 (PDT)
Date:   Fri, 25 Sep 2020 07:48:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002954fa05b02468d7@google.com>
Subject: KASAN: slab-out-of-bounds Read in squashfs_get_id
From:   syzbot <syzbot+8e28bba73ed1772a6802@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1597ead3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af502ec9a451c9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=8e28bba73ed1772a6802
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172ff481900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c3e6c5900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e28bba73ed1772a6802@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in squashfs_get_id+0xb9/0x1c0 fs/squashfs/id.c:38
Read of size 8 at addr ffff8880a9684b98 by task syz-executor329/6836

CPU: 1 PID: 6836 Comm: syz-executor329 Not tainted 5.9.0-rc6-syzkaller #0
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
RIP: 0033:0x446d1a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffd7dd4f8b8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd7dd4f910 RCX: 0000000000446d1a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd7dd4f8d0
RBP: 00007ffd7dd4f8d0 R08: 00007ffd7dd4f910 R09: 00007ffd00000015
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003

Allocated by task 3913:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x100/0x130 mm/kasan/common.c:461
 kmalloc_node include/linux/slab.h:577 [inline]
 __vmalloc_area_node mm/vmalloc.c:2429 [inline]
 __vmalloc_node_range+0x2c7/0x870 mm/vmalloc.c:2511
 module_alloc+0x7e/0x90 arch/x86/kernel/module.c:75
 bpf_jit_binary_alloc+0x123/0x230 kernel/bpf/core.c:871
 bpf_int_jit_compile+0x7995/0x8920 arch/x86/net/bpf_jit_comp.c:1911
 bpf_prog_select_runtime+0x76d/0xa60 kernel/bpf/core.c:1807
 bpf_migrate_filter net/core/filter.c:1290 [inline]
 bpf_prepare_filter+0xec2/0x1140 net/core/filter.c:1338
 bpf_prog_create_from_user+0x2ad/0x3e0 net/core/filter.c:1432
 seccomp_prepare_filter kernel/seccomp.c:567 [inline]
 seccomp_prepare_user_filter kernel/seccomp.c:604 [inline]
 seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
 do_seccomp+0x852/0x20b0 kernel/seccomp.c:1661
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880a9684b80
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 24 bytes inside of
 32-byte region [ffff8880a9684b80, ffff8880a9684ba0)
The buggy address belongs to the page:
page:00000000f697ca3d refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880a9684fc1 pfn:0xa9684
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002a5d5c8 ffffea0002a98588 ffff8880aa440100
raw: ffff8880a9684fc1 ffff8880a9684000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a9684a80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880a9684b00: 00 fc fc fc fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880a9684b80: 00 fc fc fc fc fc fc fc fa fb fb fb fc fc fc fc
                            ^
 ffff8880a9684c00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880a9684c80: 00 00 01 fc fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
