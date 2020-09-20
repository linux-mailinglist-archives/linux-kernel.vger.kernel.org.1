Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179B8271323
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 11:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgITJWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 05:22:17 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:51962 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgITJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 05:22:16 -0400
Received: by mail-io1-f77.google.com with SMTP id q12so7829126iob.18
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 02:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=To0958KlvR9rnacFqHmwL9rHYI1TEUcFIt/m7KfPjyg=;
        b=JnopWZdGgehBUY5S69GNHH3HoXi6LHmVHYdtAXuR/1VewQfhN76Lkj0dpzxlIVeONM
         K5t4IBFdmj+kVWBsyT1lw3YytV5WF4pI6NLPiwp5U/88GJcX5iy4KF8HDdls7mPVpd3r
         HcWJWvneCpWeSigkF/5Jc1C/M3NJsps4RQ8xr+gF1cgJ/CLhg9Mg0Ew+Ty9UnTd5Khc3
         jDdsmu2nvl/RktSE+h9jcvAWjA9dzG3W6T/xlyZVKhmwHP6pHZFLkthB0LfL34GBmftE
         K60z+DNHgl8UamBpsFWTBAq6p3axqLDoWTysblnVmcv//9xJ2bYi4D4WJvWMkHVH5lL0
         pqNw==
X-Gm-Message-State: AOAM532AlUSmliMevlPJ10WMfjxINbKzBo8FDHBBzXVktPV5U5eD5D9u
        tQYw0GX563b8vzjts3SAg08eFuTEA9gxTJB2c9ickAhwdp6Q
X-Google-Smtp-Source: ABdhPJyDNeCia96xmEw5fuolUcxaByXJ+cAvOxDtBcMePQNKg2EwPE7xCw4BLtJyOSVE73rkr70HGoYo3xNrCSlFgfm+dT1U/zz3
MIME-Version: 1.0
X-Received: by 2002:a92:4101:: with SMTP id o1mr2661993ila.296.1600593735683;
 Sun, 20 Sep 2020 02:22:15 -0700 (PDT)
Date:   Sun, 20 Sep 2020 02:22:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b953a05afbb4548@google.com>
Subject: kernel BUG at fs/f2fs/segment.h:LINE!
From:   syzbot <syzbot+3698081bcf0bb2d12174@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fc4f28bb Merge tag 'for-5.9-rc5-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134d97dd900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c61f6bd349c981f3
dashboard link: https://syzkaller.appspot.com/bug?extid=3698081bcf0bb2d12174
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3698081bcf0bb2d12174@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.h:657!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 16220 Comm: syz-executor.0 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:f2fs_ra_meta_pages+0xa51/0xdc0 fs/f2fs/segment.h:657
Code: 08 49 83 ed 01 e9 3f f8 ff ff c7 44 24 18 80 00 00 00 45 31 ff 45 31 f6 31 f6 41 bc 01 00 00 00 e9 cd fb ff ff e8 0f 48 3e fe <0f> 0b e8 08 48 3e fe 4c 8b 6c 24 08 be 04 00 00 00 4c 89 ef e8 76
RSP: 0018:ffffc9000b4177a8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: dffffc0000000000 RCX: ffffc9000ac51000
RDX: 0000000000040000 RSI: ffffffff833605d1 RDI: 0000000000000004
RBP: ffff88804e738000 R08: 0000000000000001 R09: ffffea00060e7337
R10: 0000000000000037 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000601 R14: ffff88808cb73800 R15: 000000000000001e
FS:  00007fcc23249700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560df32133b7 CR3: 0000000074a09000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 build_sit_entries fs/f2fs/segment.c:4195 [inline]
 f2fs_build_segment_manager+0x4b8a/0xa3c0 fs/f2fs/segment.c:4779
 f2fs_fill_super+0x377d/0x6b80 fs/f2fs/super.c:3633
 mount_bdev+0x32e/0x3f0 fs/super.c:1417
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x2070 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x46004a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fcc23248a88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fcc23248b20 RCX: 000000000046004a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fcc23248ae0
RBP: 00007fcc23248ae0 R08: 00007fcc23248b20 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 0000000020012400
Modules linked in:
---[ end trace a60c6b47a90afa81 ]---
RIP: 0010:f2fs_ra_meta_pages+0xa51/0xdc0 fs/f2fs/segment.h:657
Code: 08 49 83 ed 01 e9 3f f8 ff ff c7 44 24 18 80 00 00 00 45 31 ff 45 31 f6 31 f6 41 bc 01 00 00 00 e9 cd fb ff ff e8 0f 48 3e fe <0f> 0b e8 08 48 3e fe 4c 8b 6c 24 08 be 04 00 00 00 4c 89 ef e8 76
RSP: 0018:ffffc9000b4177a8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: dffffc0000000000 RCX: ffffc9000ac51000
RDX: 0000000000040000 RSI: ffffffff833605d1 RDI: 0000000000000004
RBP: ffff88804e738000 R08: 0000000000000001 R09: ffffea00060e7337
R10: 0000000000000037 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000601 R14: ffff88808cb73800 R15: 000000000000001e
FS:  00007fcc23249700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f253183c000 CR3: 0000000074a09000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
