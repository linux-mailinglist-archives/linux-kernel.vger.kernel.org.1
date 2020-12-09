Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA92D3C5F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgLIHeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:34:37 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:52451 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgLIHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:33:52 -0500
Received: by mail-io1-f72.google.com with SMTP id b136so597749iof.19
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 23:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fqgdtXNXsphP7dzwRFVwAVgzQW8ckR3/RpP8iw9eAlU=;
        b=c39fSKvqbtvdijy4QcRqqLWSXCWNV0a6xYR0ecDQ11hLbMMZKYTw6RrInjY9xAcQXh
         UXNhbICmeTPvLdM6uvqNbAy/eGOngDIEiKU+lNmnPXCGm75n9NfChP3ED/C6mJr//dvM
         4uWd2q3yg6CafT1X+BfcPSDTETwI1+dvLIdsGWP5ErKbtsQ1vCj2aSdgtWuPEhp7qehA
         EM0LZaS3zK+USPoZhb2fdCeTlxKTT15dqfEoBxR45OMsn02xxMKvFy7V4pE7+cVdq94j
         Ze68hcvP3pfVZoN+57SK+xT2HBb4avJl7NgEVoaClm7P6gCqHHGJSDp+k68MIDmFtfVY
         Z5dA==
X-Gm-Message-State: AOAM533jIaz8WIFIlmz7nqg/xVpP+1YmJrqKhbfUS9opruupimPrfft+
        sAWvGaqHskqb5YyX/+8MTkR9R/NuFSMTc1NpslUfW8MPDmHQ
X-Google-Smtp-Source: ABdhPJwzD4gC4lAai93nEFQE2k9fFCjo4GpCsM7yrAmjoe+vTcUY7NeccDu9yWNhWrUYuGlIuNZ0EMSzxK/DVvqLVzrMp8+C3btg
MIME-Version: 1.0
X-Received: by 2002:a02:37c2:: with SMTP id r185mr1271712jar.107.1607499191461;
 Tue, 08 Dec 2020 23:33:11 -0800 (PST)
Date:   Tue, 08 Dec 2020 23:33:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048a9de05b603126a@google.com>
Subject: UBSAN: shift-out-of-bounds in ext4_fill_super
From:   syzbot <syzbot+345b75652b1d24227443@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15ac8fdb Add linux-next specific files for 20201207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1125c923500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3696b8138207d24d
dashboard link: https://syzkaller.appspot.com/bug?extid=345b75652b1d24227443
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151bf86b500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139212cb500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+345b75652b1d24227443@syzkaller.appspotmail.com

loop0: detected capacity change from 4 to 0
================================================================================
UBSAN: shift-out-of-bounds in fs/ext4/super.c:4190:25
shift exponent 589825 is too large for 32-bit type 'int'
CPU: 1 PID: 8498 Comm: syz-executor023 Not tainted 5.10.0-rc6-next-20201207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 ext4_fill_super.cold+0x154/0x3ce fs/ext4/super.c:4190
 mount_bdev+0x34d/0x410 fs/super.c:1366
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1496
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3227
 do_mount fs/namespace.c:3240 [inline]
 __do_sys_mount fs/namespace.c:3448 [inline]
 __se_sys_mount fs/namespace.c:3425 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3425
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446d6a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffc2d215018 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc2d215070 RCX: 0000000000446d6a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffc2d215030
RBP: 00007ffc2d215030 R08: 00007ffc2d215070 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000001
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
