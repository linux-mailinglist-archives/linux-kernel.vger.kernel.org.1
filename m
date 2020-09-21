Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48C3271F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIUJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:51:24 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:33471 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgIUJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:51:23 -0400
Received: by mail-io1-f79.google.com with SMTP id l22so9499262iol.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OrL68wKtZhSvX7AYiOaW0u6dSNafflp/Hd2TF8qq/OY=;
        b=m4PAAOSewzdE2V2XfxVDZwvuFk6fQxV/uIL7T/4XA3FVWXtVIjf+k3P9uFZdQv9tTe
         raAhR6qWNTzm098Sc/l7TUGkF8YieSebpsUkwKQpnMIHoXIDV/f+GiIQi5R8UYXGyAH3
         s5erDaeijwww0NvNPSNI5PlGKNiwsjOJesP46X0lUJGhj1nPo81ynTeb1+iSbH3Q/ijz
         EeeYojYUx5GE8nhv4XJeiSVCjubQd85ZrauaFIFO6PdyjtcGxhNBXhKHyb+hlHfZ9Wj/
         nNVsjLa9eA8FFwpmICnd4S+naZzP6F1l0o6Hfa2brkouqkW2EkEQpNTmmOrifZC29NRG
         h7Jw==
X-Gm-Message-State: AOAM5304ZYMw+2K0Fj07WxX2IQJ3R6zkS08IGsgOlihMcgKFW88mNpV7
        6euRUeK0nEhkBwH1VvelwMV3IBCNbfsyCOiiCjAt8Hxl4D0e
X-Google-Smtp-Source: ABdhPJw2+O8RwPTpkwcJOVktU8klp/8OjvfoTUi5HM9hKxp1vz7zQK8E2Q4qCKTpt6/chh5+fUQWWJYyEQdZQhOO/BaNlS4xZ+S8
MIME-Version: 1.0
X-Received: by 2002:a02:a498:: with SMTP id d24mr39976112jam.137.1600681882524;
 Mon, 21 Sep 2020 02:51:22 -0700 (PDT)
Date:   Mon, 21 Sep 2020 02:51:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000019e9e05afcfcb96@google.com>
Subject: WARNING in f2fs_is_valid_blkaddr
From:   syzbot <syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154f90d3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b12e84189082991c
dashboard link: https://syzkaller.appspot.com/bug?extid=763ae12a2ede1d99d4dc
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c469ab900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10093365900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com

F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop0): invalid crc_offset: 0
F2FS-fs (loop0): access invalid blkaddr:1
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6861 at fs/f2fs/checkpoint.c:189 arch_set_bit arch/x86/include/asm/bitops.h:55 [inline]
WARNING: CPU: 0 PID: 6861 at fs/f2fs/checkpoint.c:189 set_bit include/asm-generic/bitops/instrumented-atomic.h:29 [inline]
WARNING: CPU: 0 PID: 6861 at fs/f2fs/checkpoint.c:189 set_sbi_flag fs/f2fs/f2fs.h:1823 [inline]
WARNING: CPU: 0 PID: 6861 at fs/f2fs/checkpoint.c:189 f2fs_is_valid_blkaddr+0xdb2/0xf80 fs/f2fs/checkpoint.c:188
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6861 Comm: syz-executor472 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 __warn.cold+0x20/0x4b kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:f2fs_is_valid_blkaddr+0xdb2/0xf80 fs/f2fs/checkpoint.c:189
Code: 89 e2 48 89 df 48 c7 c6 a0 90 cd 88 e8 e7 fa fe ff 48 8d bb b8 00 00 00 be 08 00 00 00 e8 26 11 5e fe f0 80 8b b8 00 00 00 04 <0f> 0b e9 af f7 ff ff e8 b2 3e 5e fe e9 a5 fa ff ff e8 b8 3e 5e fe
RSP: 0018:ffffc90005187738 EFLAGS: 00010206
RAX: 0000000000000001 RBX: ffff8880a6ff8000 RCX: ffffffff8358d09a
RDX: ffffed1014dff018 RSI: 0000000000000008 RDI: ffff8880a6ff80b8
RBP: 0000000000000007 R08: 0000000000000001 R09: ffff8880a6ff80bf
R10: ffffed1014dff017 R11: 0000000000000000 R12: 0000000000000001
R13: ffff888097a27c00 R14: 0000000000001400 R15: 0000000000000400
 f2fs_get_node_info+0x4b4/0xbc0 fs/f2fs/node.c:571
 read_node_page+0x4a6/0x9b0 fs/f2fs/node.c:1294
 __get_node_page.part.0+0xa2/0xac0 fs/f2fs/node.c:1354
 __get_node_page fs/f2fs/node.c:35 [inline]
 f2fs_get_node_page+0x109/0x180 fs/f2fs/node.c:1399
 do_read_inode fs/f2fs/inode.c:336 [inline]
 f2fs_iget+0x233/0x4b10 fs/f2fs/inode.c:485
 f2fs_fill_super+0x3ae8/0x6e80 fs/f2fs/super.c:3673
 mount_bdev+0x32e/0x3f0 fs/super.c:1417
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44766a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffe48abef58 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe48abefb0 RCX: 000000000044766a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe48abef70
RBP: 00007ffe48abef70 R08: 00007ffe48abefb0 R09: 00007ffe00000015
R10: 0000000000000000 R11: 0000000000000297 R12: 000000000000002f
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
