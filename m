Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819F72D3C62
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgLIHfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:35:00 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:43371 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgLIHeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:34:50 -0500
Received: by mail-il1-f198.google.com with SMTP id p6so627838ils.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 23:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hu6iJbFDy3nFb70699PrdHaMHxEsAqLkKm9sMmsagYU=;
        b=rrgiW3TgLgJP22v8CpGZTCD5R0DOB91hXkzxdB9DKyiZr3XGJ5OYOkKNottU1gKhE4
         OyMxdQN1UW1Z/Beaz7kEaebrhWRzDFzsDyJmJBz+JDh+6CuKIYVFUeHHGo0ZIPVpekPO
         tg5Rt4aOhr0FzhBWBIeNYQSat9FHm7HlnEVz3ztcongLWDqmLGdBcFKQrdPFnLr9I1ed
         N8oxpklOT4e7GA/0osllVfnvbjngat3aBd8yr3n8EN+H8nGLNid/SDH1bICkGUJcHRTc
         SrDK8v05thRhmBpM7ig86uCQQAztKKBLWqMUZWOY6CILvWzvN9the0JTNqZQL+Jzq8BP
         D4mQ==
X-Gm-Message-State: AOAM533llPi5PdVuvX9Km82er2lveop5GTOl/I1ROvvO2EHwLCdEWJ5n
        LfEnPwpZ7M3lLiXFdl7QCuZ25LT9BclAjreLy8xGLDIaxr2K
X-Google-Smtp-Source: ABdhPJx3HLdEiYZhYSUuOOfSw9uk2euCuwTaO90+qYsbTXiba0NC/jMTnJJiPnYMSwH3jWN3udAKuW5PfMjCMq3Y24mCmupMnXDy
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cb:: with SMTP id r11mr1125473ilq.11.1607499249912;
 Tue, 08 Dec 2020 23:34:09 -0800 (PST)
Date:   Tue, 08 Dec 2020 23:34:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c492d105b6031553@google.com>
Subject: UBSAN: shift-out-of-bounds in f2fs_fill_super
From:   syzbot <syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15ac8fdb Add linux-next specific files for 20201207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14ba4b37500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3696b8138207d24d
dashboard link: https://syzkaller.appspot.com/bug?extid=ca9a785f8ac472085994
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e17ccb500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c21287500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com

loop0: detected capacity change from 16384 to 0
================================================================================
UBSAN: shift-out-of-bounds in fs/f2fs/super.c:2812:16
shift exponent 59 is too large for 32-bit type 'int'
CPU: 0 PID: 8465 Comm: syz-executor962 Not tainted 5.10.0-rc6-next-20201207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 sanity_check_raw_super fs/f2fs/super.c:2812 [inline]
 read_raw_super_block fs/f2fs/super.c:3267 [inline]
 f2fs_fill_super.cold+0x16c9/0x16f6 fs/f2fs/super.c:3519
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
RIP: 0033:0x446d4a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fff137bba68 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff137bbac0 RCX: 0000000000446d4a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fff137bba80
RBP: 00007fff137bba80 R08: 00007fff137bbac0 R09: 00007fff00000015
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000002
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
