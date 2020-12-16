Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED1A2DC1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgLPOOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:14:51 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:42069 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgLPOOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:14:51 -0500
Received: by mail-io1-f72.google.com with SMTP id m9so22552695ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7cwq94/LndwHW8nMgne9GJXd2g5Vmy0CxkQ/gRkScDg=;
        b=DnkyZKB7AvKMwgLtKPJ2N6OjwNuiLHpJX7dg4RmDul5UNqYgtl6CnkVigttWpmKiMv
         vzbf2VZjtsKJUpDNNRFt57UmprAYwpkl9LTZDFl5mtfhPm0h3R/p+UJHyN22Rocn3Ewv
         MrK9A9ZDum/h2TZd+mnJatCfDXNP3bw+EUjGmKl501zghBofXQ4EYrOXR75E6LtaJsSj
         eK/R/vFPcsnHGzhV4FHj1+gU8WVLlegzTP9VgeKS0jyj7CcRw2YyTFFdfQczC0Qy01sl
         YddRNps0GC8npA2eU2ilEsDvnfk/I46Q62V9Y8eYd4EXK+0jVg8lEKriV/g2wacVb7Zu
         ZLPg==
X-Gm-Message-State: AOAM530LJHqtY4IgBbcoCq5TFXJNXjNJbqRndVL3aI9ttvPBrqUaoIrY
        XqMg6WzyXyL8fqRUEFjqm3YuNSRNTN2L5ktpRe9/8tCSG86w
X-Google-Smtp-Source: ABdhPJwCJsMcKgMjEpUgnxwHNawPsxdwEGX0vSGarCQjWqcs6hdNv7C/jSa4wOsbVqVRiESqZrqU4P/g2PrzNxfvgAiR8X8Euc8z
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cb:: with SMTP id r11mr46640578ilq.11.1608128050414;
 Wed, 16 Dec 2020 06:14:10 -0800 (PST)
Date:   Wed, 16 Dec 2020 06:14:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032cbc605b6957df0@google.com>
Subject: UBSAN: shift-out-of-bounds in chkSuper
From:   syzbot <syzbot+36315852ece4132ec193@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    14240d4c Add linux-next specific files for 20201210
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13457c5b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6dbe20fdaa5aaebe
dashboard link: https://syzkaller.appspot.com/bug?extid=36315852ece4132ec193
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1172cef3500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b1845b500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+36315852ece4132ec193@syzkaller.appspotmail.com

loop0: detected capacity change from 128 to 0
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_mount.c:373:25
shift exponent -9716 is negative
CPU: 0 PID: 8511 Comm: syz-executor446 Not tainted 5.10.0-rc7-next-20201210-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 chkSuper.cold+0x1e/0x8b fs/jfs/jfs_mount.c:373
 jfs_mount+0x47/0x3d0 fs/jfs/jfs_mount.c:82
 jfs_fill_super+0x5b1/0xbc0 fs/jfs/super.c:562
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
RIP: 0033:0x446d5a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fff49981e98 EFLAGS: 00000283 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff49981ee0 RCX: 0000000000446d5a
RDX: 0000000020000000 RSI: 0000000020000080 RDI: 00007fff49981ea0
RBP: 00007fff49981ea0 R08: 00007fff49981ee0 R09: 6f6f6c2f7665642f
R10: 0000000000000001 R11: 0000000000000283 R12: 0000000000000004
R13: 0000000000000003 R14: 0000000000000003 R15: 0000000000000001
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
