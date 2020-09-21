Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490AA271F93
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgIUKCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:02:22 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:39978 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIUKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:02:22 -0400
Received: by mail-il1-f206.google.com with SMTP id g188so10564038ilh.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=878X+MokR+ZbeqJGJQNq7QDLXnpG5EMYsQ8wF9gEG6g=;
        b=G78l8lxt+5XtsDb6U1u2FOJEMPjacC0zjB4RA1aOPJPPI0q4h6z0C1hcqn5AfwHTQk
         QuYT+gZ4SgYfNIw0UwWftO+sxLX7AOpRH645E5xBQF4mwVa2h4NT1i0DmjFLmWtKltuC
         3gf/IrAI8gPUPIpJqSGxn72gLqk6f22Yq9a4AV9z1zY6WTFtaBuBENXS/FrX5Vb7PRpX
         FR5CV5sjkExzUQ/77ej7URk6nhSohOYamnYhwYXH0S/rd1xBbOy9HpFVMJE6DOMajCSD
         bs22O/mNjRaFsGojhA/iRB2XrnD1+Fvtm7f5Cnva0qbj1GYRSkC/mPSdmJmywZRNQZI6
         kD/Q==
X-Gm-Message-State: AOAM532Fihmf3/idrhcyvRSJsxYRMiOMrGBfWwoIYmkR+fcE3YQxf5a+
        ZDnHhK9K2Y5bg2vF0F9L6PZOo2Oay7m5mBwCPJg15tn9/zf9
X-Google-Smtp-Source: ABdhPJy77SpanDAhaUD564y+kfir5vkWynL2iO3uzcCnBbobRoCMtMVM2wLANCqpTZo8HnFv9DEsyoW2UKTNcmOMcsiqIT+5iXiI
MIME-Version: 1.0
X-Received: by 2002:a6b:3e84:: with SMTP id l126mr35372373ioa.118.1600682541024;
 Mon, 21 Sep 2020 03:02:21 -0700 (PDT)
Date:   Mon, 21 Sep 2020 03:02:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000418c7705afcff2e1@google.com>
Subject: general protection fault in jffs2_parse_param
From:   syzbot <syzbot+9765367bb86a19d38732@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, sandeen@sandeen.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12acb307900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b12e84189082991c
dashboard link: https://syzkaller.appspot.com/bug?extid=9765367bb86a19d38732
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175909d9900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179b3cc3900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9765367bb86a19d38732@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 6866 Comm: syz-executor202 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:jffs2_parse_param+0x141/0x330 fs/jffs2/super.c:206
Code: 48 c1 ea 03 4d 63 fc 80 3c 02 00 0f 85 de 01 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 75 00 49 8d 7e 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 c8 01 00 00 4d 8b 76 08 4c 89 ff 4c 89 f6 e8 d6
RSP: 0018:ffffc90001087b78 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880932c9c00 RCX: ffffffff82882084
RDX: 0000000000000001 RSI: ffffffff82882096 RDI: 0000000000000008
RBP: 1ffff92000210f6f R08: 0000000000000001 R09: 0000000000000003
R10: 00000000003fffff R11: 0000000000000000 R12: 0000000000000000
R13: ffff88808de2a000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000002198880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043e830 CR3: 00000000a11a3000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 vfs_parse_fs_param fs/fs_context.c:117 [inline]
 vfs_parse_fs_param+0x203/0x550 fs/fs_context.c:98
 vfs_parse_fs_string+0xe6/0x150 fs/fs_context.c:161
 generic_parse_monolithic+0x16f/0x1f0 fs/fs_context.c:201
 do_new_mount fs/namespace.c:2871 [inline]
 path_mount+0x133f/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44699a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 7d ae fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 5a ae fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffc381bf788 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc381bf7d0 RCX: 000000000044699a
RDX: 0000000020001300 RSI: 0000000020001340 RDI: 0000000000000000
RBP: 0000000000000000 R08: 00007ffc381bf7d0 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401c80
R13: 0000000000401d10 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 9cf0f624124bffcb ]---
RIP: 0010:jffs2_parse_param+0x141/0x330 fs/jffs2/super.c:206
Code: 48 c1 ea 03 4d 63 fc 80 3c 02 00 0f 85 de 01 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 75 00 49 8d 7e 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 c8 01 00 00 4d 8b 76 08 4c 89 ff 4c 89 f6 e8 d6
RSP: 0018:ffffc90001087b78 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880932c9c00 RCX: ffffffff82882084
RDX: 0000000000000001 RSI: ffffffff82882096 RDI: 0000000000000008
RBP: 1ffff92000210f6f R08: 0000000000000001 R09: 0000000000000003
R10: 00000000003fffff R11: 0000000000000000 R12: 0000000000000000
R13: ffff88808de2a000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000002198880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043e830 CR3: 00000000a11a3000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
