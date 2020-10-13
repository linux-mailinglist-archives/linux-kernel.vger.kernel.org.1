Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C34F28D2C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgJMRC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 13:02:26 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:47030 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgJMRC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:02:26 -0400
Received: by mail-il1-f198.google.com with SMTP id z8so319569ilh.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 10:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nutX9FCD1sElMBWzX5zSlVufTFPkqD5XYfFefpFFUC8=;
        b=Zqyrvg6DCVhaCzPWyHxWw8k9/81EhAjmZKmpAxEnDjYXrYDAK+R4aK1vgBvj1qJVWB
         rMn0ZJAMmoKhvhZmYTX/aIGjy9HKB9ArVCrG9DLVAdKcvi8YoS+vli3XPAZ+Hy7L6/bk
         yUuiQ0lXg3xPa9JRjZmWLyDJhrUCnzC5GKkoqNfEtLv4800Id+YJdzwqvD4G/NVIkE1O
         GldJLX59Du7t+qo06vM7V7jes758flnnJ14c2ETOoRBVvVCc7qv+dYc6RmNYdILA+SNQ
         6j/tx/czoNeEtPy4c68brmQ4vv/RxCsBAU3K0oPLe7mGww//jMh4TMTAoFUtrpMV189u
         kV8A==
X-Gm-Message-State: AOAM532hyEHv/dhJVZ0zHrs7wrdhmzsrnbIXkLtc/aCss4QDP2JicjuP
        mwfuVCZsETIxFnD4QYuSGzLdUR6CC2Ix43KV+O83pwS62fv8
X-Google-Smtp-Source: ABdhPJyBFzEESpAkSw26jMiMsYUQcC92zNovocU/BNPCkqFwXluh518F3xkAhrU6WxOKpa9vgxBM6NAl0PuOedq7THGvvMdHvUVF
MIME-Version: 1.0
X-Received: by 2002:a92:98c5:: with SMTP id a66mr802236ill.50.1602608544806;
 Tue, 13 Oct 2020 10:02:24 -0700 (PDT)
Date:   Tue, 13 Oct 2020 10:02:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000702ea05b19061b2@google.com>
Subject: WARNING in drop_nlink (2)
From:   syzbot <syzbot+651ca866e5e2b4b5095b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    583090b1 Merge tag 'block5.9-2020-10-08' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14531384500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
dashboard link: https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11126817900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1705b5bf900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133e1210500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10be1210500000
console output: https://syzkaller.appspot.com/x/log.txt?x=173e1210500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+651ca866e5e2b4b5095b@syzkaller.appspotmail.com

MINIX-fs: mounting unchecked file system, running fsck is recommended
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6857 at fs/inode.c:303 drop_nlink+0xb9/0x100 fs/inode.c:303
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6857 Comm: syz-executor857 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 panic+0x2c0/0x800 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:drop_nlink+0xb9/0x100 fs/inode.c:303
Code: 49 8b 1e 48 8d bb b8 07 00 00 be 08 00 00 00 e8 9d 46 ef ff f0 48 ff 83 b8 07 00 00 5b 41 5c 41 5e 41 5f 5d c3 e8 87 92 af ff <0f> 0b eb 8a 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 63 ff ff ff 4c
RSP: 0018:ffffc900010d7c50 EFLAGS: 00010293
RAX: ffffffff81c56b69 RBX: 1ffff11010a15c21 RCX: ffff88809190c1c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81c56aee R09: fffffbfff16c82b0
R10: fffffbfff16c82b0 R11: 0000000000000000 R12: ffff8880850ae108
R13: ffffc900010d7ca8 R14: ffff8880850ae0c0 R15: dffffc0000000000
 inode_dec_link_count include/linux/fs.h:2190 [inline]
 minix_rename+0x42b/0x7f0 fs/minix/namei.c:226
 vfs_rename+0xa5f/0x1500 fs/namei.c:4309
 do_renameat2+0x84a/0x1070 fs/namei.c:4456
 __do_sys_renameat fs/namei.c:4497 [inline]
 __se_sys_renameat fs/namei.c:4494 [inline]
 __x64_sys_renameat+0x9a/0xb0 fs/namei.c:4494
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x444729
Code: 8d d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffefa186b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000108
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444729
RDX: 0000000000000009 RSI: 0000000020000500 RDI: 000000000000000a
RBP: 00000000006d0018 R08: 00000000004002e0 R09: 00000000004002e0
R10: 00000000200017c0 R11: 0000000000000246 R12: 0000000000402310
R13: 00000000004023a0 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
