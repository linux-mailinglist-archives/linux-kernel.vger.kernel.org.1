Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27562F48CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbhAMKh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:37:59 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:51655 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbhAMKh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:37:57 -0500
Received: by mail-io1-f71.google.com with SMTP id h206so2101749iof.18
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=i/EcVgfezVHb7BD88A2qZDk1G4kp5LnCKOL7ub6BJfA=;
        b=CMPfNxi7exCPJUxy4e3JVPwhcZircABEJ+4OxCKxbrZo1jKiKMHO3ccU7+66cx+cAI
         JAZL8cQ+GkuI5IlluK/pUW6zTOgRdhj6/xVpXOx63gSl/BS4RpOF4ETgwRMua7r3ho+4
         MoT5Klj+L6KA6ReVaL+ylhNACq6efL5XMoFjlXxjmc7b0a/DakofA0rqS+0xKr0AuJ4I
         pu96u3ePCDvuOP2UvKfI/kRWXg1dpNvd4ZdU1gPOUp6jZK1KIqsIb6lqYRmLQSnFnnoO
         tjKPeji2l0W4INT6n4hq9XckzF7WrCiVvWzdX+I01wH/mZMHrHMHnW+dzzB8WZ0EIfBH
         GuiQ==
X-Gm-Message-State: AOAM532mbg5SoxYTyY6DzorXN4b52UE7U47jvxTAveXk/z9FOuU5dCFt
        WuTpRB9YMUox25JNO8YA1Vx1mvWwdctta/ioR6Xm9c6NR7qH
X-Google-Smtp-Source: ABdhPJzbu6E0ZRxcwezW9DGyQS8SgYoozUgxvdrfqkJg8A8vf8F990wEBQF3Drl7Kh3q0hhNc8P4plijm89gqZjTgkVY8fVqLKua
MIME-Version: 1.0
X-Received: by 2002:a02:8482:: with SMTP id f2mr1801739jai.93.1610534236066;
 Wed, 13 Jan 2021 02:37:16 -0800 (PST)
Date:   Wed, 13 Jan 2021 02:37:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a196b05b8c5b94a@google.com>
Subject: KASAN: vmalloc-out-of-bounds Write in lzo_uncompress
From:   syzbot <syzbot+6fba78f99b9afd4b5634@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hch@lst.de,
        linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
        pliard@google.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a0d54b4f Merge tag 'trace-v5.11-rc2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11afe9eb500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c066f800cf2824be
dashboard link: https://syzkaller.appspot.com/bug?extid=6fba78f99b9afd4b5634
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143237db500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17eff0af500000

The issue was bisected to:

commit 93e72b3c612adcaca13d874fcc86c53e6c8da541
Author: Philippe Liard <pliard@google.com>
Date:   Tue Jun 2 04:45:23 2020 +0000

    squashfs: migrate from ll_rw_block usage to BIO

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1704fbfb500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1484fbfb500000
console output: https://syzkaller.appspot.com/x/log.txt?x=1084fbfb500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6fba78f99b9afd4b5634@syzkaller.appspotmail.com
Fixes: 93e72b3c612a ("squashfs: migrate from ll_rw_block usage to BIO")

loop0: detected capacity change from 98 to 0
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in memcpy include/linux/string.h:447 [inline]
BUG: KASAN: vmalloc-out-of-bounds in lzo_uncompress+0x44c/0x620 fs/squashfs/lzo_wrapper.c:80
Write of size 4096 at addr ffffc90000ea1e75 by task syz-executor001/8476

CPU: 0 PID: 8476 Comm: syz-executor001 Not tainted 5.11.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5/0x2c6 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 check_memory_region_inline mm/kasan/generic.c:179 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:185
 memcpy+0x39/0x60 mm/kasan/shadow.c:65
 memcpy include/linux/string.h:447 [inline]
 lzo_uncompress+0x44c/0x620 fs/squashfs/lzo_wrapper.c:80
 squashfs_decompress+0xcc/0x160 fs/squashfs/decompressor_single.c:70
 squashfs_read_data+0x1f8/0xe30 fs/squashfs/block.c:214
 squashfs_cache_get+0x4a9/0xd50 fs/squashfs/cache.c:110
 squashfs_read_metadata+0x134/0x460 fs/squashfs/cache.c:344
 squashfs_read_inode+0x182/0x1b40 fs/squashfs/inode.c:115
 squashfs_fill_super+0x1140/0x23b0 fs/squashfs/super.c:310
 get_tree_bdev+0x440/0x760 fs/super.c:1291
 vfs_get_tree+0x89/0x2f0 fs/super.c:1496
 do_new_mount fs/namespace.c:2878 [inline]
 path_mount+0x13ad/0x20c0 fs/namespace.c:3208
 do_mount fs/namespace.c:3221 [inline]
 __do_sys_mount fs/namespace.c:3429 [inline]
 __se_sys_mount fs/namespace.c:3406 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3406
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446d2a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffc49d40db8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc49d40e10 RCX: 0000000000446d2a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffc49d40dd0
RBP: 00007ffc49d40dd0 R08: 00007ffc49d40e10 R09: 00007ffc00000015
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003


Memory state around the buggy address:
 ffffc90000ea1f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90000ea1f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90000ea2000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90000ea2080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000ea2100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
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
