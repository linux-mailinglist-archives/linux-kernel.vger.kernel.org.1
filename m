Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287F12EAB5F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbhAENB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:01:59 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:48576 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAENB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:01:58 -0500
Received: by mail-il1-f200.google.com with SMTP id f4so30520241ilu.15
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 05:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/MLmxfO00kG8Vz2FD5GixYYD/MCQqiaRhG+GjRUx0dw=;
        b=NKeBUpjELtnpCe3XJeJKup/AwXsCTY7eQjiY/DVj8F5vmbvIvWByBsCgT0WGTNjMQb
         LugSziSKMWHm74ZbE8B9/CEeHSjabLuS91RFsAuCYLvz2GxaI8AN+W9tLGo6AwCstw3a
         PVQmndkRDbSyGghHseQN9YDPmJob7COR245wAedNVGeW4AyyW/8mvOSwSGmNIMj/QGqw
         m7p6oG10gO+uqIFkLbxVjsBL72DscFkbu8UA1UbePFYaoK7rGBNZ/6ZOQA3g07ixauuQ
         USmyb2c89QjNj3oBLvwsHPiT6EE8TV2ei2GBdnIf6B34obqRhxzHA/KV5usimCK4ZxT4
         R3SA==
X-Gm-Message-State: AOAM531O1E5diG1orULol7JXzqUY4NsSaW4I2isZW1t9W6BBpke11eK9
        ltMYwkpe3SMgyAhj3E4ST0DOZcJk8t8bLrTwcjkEizgAq6oE
X-Google-Smtp-Source: ABdhPJzpMzaz8sKKDn0AV8QoU1thqcOD4lAoiN7+cFrTHp8FA1YDc4R7RpHY4Ve/jJo2U4M6liMyQtKT9aa9OeRvcPrcqqGz2qHx
MIME-Version: 1.0
X-Received: by 2002:a6b:920b:: with SMTP id u11mr62715438iod.191.1609851677004;
 Tue, 05 Jan 2021 05:01:17 -0800 (PST)
Date:   Tue, 05 Jan 2021 05:01:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059589a05b826cdad@google.com>
Subject: UBSAN: shift-out-of-bounds in diReadSpecial
From:   syzbot <syzbot+d0d8d1bfd19a85de7703@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    614cb589 Merge tag 'acpi-5.11-rc1-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e4ffbd500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf519e1e96191576
dashboard link: https://syzkaller.appspot.com/bug?extid=d0d8d1bfd19a85de7703
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d0d8d1bfd19a85de7703@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_imap.c:445:7
shift exponent -19 is negative
CPU: 0 PID: 11254 Comm: syz-executor.2 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 diReadSpecial.cold+0x1b/0x3e fs/jfs/jfs_imap.c:445
 jfs_mount+0x83/0x3d0 fs/jfs/jfs_mount.c:86
 jfs_fill_super+0x5b1/0xbc0 fs/jfs/super.c:562
 mount_bdev+0x34d/0x410 fs/super.c:1366
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1496
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x13ad/0x20c0 fs/namespace.c:3205
 do_mount fs/namespace.c:3218 [inline]
 __do_sys_mount fs/namespace.c:3426 [inline]
 __se_sys_mount fs/namespace.c:3403 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3403
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x460b9a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 ad 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 8a 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f2ed35f4a78 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f2ed35f4b10 RCX: 0000000000460b9a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f2ed35f4ad0
RBP: 00007f2ed35f4ad0 R08: 00007f2ed35f4b10 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 000000002006d200
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
