Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550202C6CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 22:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgK0VBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 16:01:08 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:38981 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbgK0U5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:57:23 -0500
Received: by mail-io1-f69.google.com with SMTP id n9so4129649iog.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 12:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8ABhmawZsJQ/Q6hAT8jVecCqEM2Zj8FpIVjuOpRMYRU=;
        b=N5yZUtnV19xoKQ67qVFORSfGnMT6qRwy9TJzZiwOSAra4D0MmPwgwUjTY/F9O9p+Gz
         qoPycozCeg6MFR8+UOkboymsfogPFrLGujeoWDi4hoeH5TnsnOLpqE5FXlkGtaZ2pAJw
         iB2WqHZaxeiOUaLMAe0GSKuXbekYhcdlHCauZC7DfoMStUcFymYusNkOGZQssGAK3eir
         14uEWVGkZikJpAvsLrYMkj2CTDPQMWSgTQ40/TZbdJJxdlXBNnMKyK4IFc5dNxvA/RQz
         wUxxVImja2u2vb4TLJqRc1TQS3P3UokTFzsaq/ZfW4qScuSHUTCkJjOp0ZAuC6gTTOn4
         xUeQ==
X-Gm-Message-State: AOAM532/XxuOw9ZxUeChxkDcoLVqc7XRJdtaitLLiGWNdhcejQe8qnGZ
        G2xCqh01UW8azWu+OG/yhnxhPngg3LqfGtV6tLcY2m/siWWM
X-Google-Smtp-Source: ABdhPJyeaI9XvcUv/QjdnPGbvln8IuIXJQlYmtl2JKmpYcVeMqmmtR88sutdkZnWKJEZmC4/CZ9KggvVYtytduqv9QK0WBNlx9qx
MIME-Version: 1.0
X-Received: by 2002:a92:d489:: with SMTP id p9mr8170884ilg.123.1606510637461;
 Fri, 27 Nov 2020 12:57:17 -0800 (PST)
Date:   Fri, 27 Nov 2020 12:57:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dfb7eb05b51ce7d2@google.com>
Subject: KASAN: use-after-free Read in ntfs_iget
From:   syzbot <syzbot+c584225dabdea2f71969@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    418baf2c Linux 5.10-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130eb535500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a31e7421a3bb7a0f
dashboard link: https://syzkaller.appspot.com/bug?extid=c584225dabdea2f71969
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f310ed500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dd7eb9500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c584225dabdea2f71969@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ntfs_read_locked_inode+0x49dc/0x58b0 fs/ntfs/inode.c:645
Read of size 8 at addr ffff8880374ee6cd by task syz-executor401/8528

CPU: 1 PID: 8528 Comm: syz-executor401 Not tainted 5.10.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 ntfs_read_locked_inode+0x49dc/0x58b0 fs/ntfs/inode.c:645
 ntfs_iget+0x12d/0x180 fs/ntfs/inode.c:177
 load_and_init_attrdef fs/ntfs/super.c:1589 [inline]
 load_system_files fs/ntfs/super.c:1817 [inline]
 ntfs_fill_super+0x255c/0x8560 fs/ntfs/super.c:2893
 mount_bdev+0x32e/0x3f0 fs/super.c:1419
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1549
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x13ad/0x20c0 fs/namespace.c:3205
 do_mount fs/namespace.c:3218 [inline]
 __do_sys_mount fs/namespace.c:3426 [inline]
 __se_sys_mount fs/namespace.c:3403 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3403
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44954a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 7d a3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 5a a3 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffe2910bd28 EFLAGS: 00000287 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe2910bd80 RCX: 000000000044954a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe2910bd40
RBP: 00007ffe2910bd40 R08: 00007ffe2910bd80 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000287 R12: 00000000000000ac
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003

The buggy address belongs to the page:
page:00000000dbe06e8c refcount:1 mapcount:0 mapping:0000000069d82f88 index:0x200 pfn:0x374ee
aops:shmem_aops ino:40b dentry name:"memfd:syzkaller"
flags: 0xfff0000008001e(referenced|uptodate|dirty|lru|swapbacked)
raw: 00fff0000008001e ffffea0000ca4a08 ffffea0000d8de88 ffff8880287936a8
raw: 0000000000000200 0000000000000000 00000001ffffffff ffff888010e00000
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff888010e00000

Memory state around the buggy address:
 ffff8880374ee580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880374ee600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880374ee680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                                              ^
 ffff8880374ee700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880374ee780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
