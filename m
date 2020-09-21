Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EEC272854
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgIUOmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:42:25 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:54782 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgIUOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:41:19 -0400
Received: by mail-io1-f77.google.com with SMTP id q6so10036519iod.21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FoqVmAupsuIVC2Fgp7htx982JbeujiYszlNG41P9AJU=;
        b=IvMt9R/AvSaKAPE7xW8+w5taewQMmdeAKMcuFPFDQmW9jLHD966LBoHS4bxkC6cRgp
         OSIje5fGW3tD99gV/hflWCke9mD4IB51KlBlPeXbM6si3tBeH3dufkg94ttO/E86fNVl
         tmBVdP/aafE5O+6t0EsBXuLSUdNWwUbywuFfgrkWr13R4Pb+eRl29SBIytBKTcsMhuxA
         vM2nzxHMnWvVxzZKp5v60J8baciYxx5f1pJ0UXfgZ5bnEjaYgtxguzzYLdFl1HN3gHE/
         rlV70feKrNGcloWLzc87auL8QRvdECW9ElL+M7r6jqi8UFj+QBe8R1TIDA8IlhSSLD/1
         BLYQ==
X-Gm-Message-State: AOAM532D5GdDbbEU/UZciqXSZhC9XjMv1YCYazeLH+h1D5AtNHOgUqwk
        vFWUO3/g803phM8s+eK0KYi4EP1iy8hDz+saqwlb4VTgZJFR
X-Google-Smtp-Source: ABdhPJxO4vu1SgKRkxhxnzXqJssV1ZBp4zmvn2H9KhC1SuWqSxjQp5iyjnDsrNrop/9eksqGXJkNVkYGjaP1jzroHTEuSJTqG6U6
MIME-Version: 1.0
X-Received: by 2002:a92:8509:: with SMTP id f9mr136270ilh.253.1600699279055;
 Mon, 21 Sep 2020 07:41:19 -0700 (PDT)
Date:   Mon, 21 Sep 2020 07:41:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eba11705afd3d759@google.com>
Subject: kernel BUG at fs/reiserfs/prints.c:LINE!
From:   syzbot <syzbot+1541a3226994c0781b29@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        zhengbin13@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ba4f184e Linux 5.9-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158e1fb5900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f4c828c9e3cef97
dashboard link: https://syzkaller.appspot.com/bug?extid=1541a3226994c0781b29
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1541a3226994c0781b29@syzkaller.appspotmail.com

REISERFS panic (device loop5): journal-2332 do_journal_end: Trying to log block 8211, which is a log block
------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:390!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6886 Comm: syz-executor.5 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__reiserfs_panic.cold+0x37/0x8a fs/reiserfs/prints.c:390
Code: 9c 88 74 6d e8 4f 9a 7a ff 4c 89 e9 4c 89 f2 4c 89 e6 49 c7 c0 20 32 4f 8d 48 c7 c7 e0 b4 9c 88 e8 32 a3 63 ff e8 2e 9a 7a ff <0f> 0b e8 27 9a 7a ff 4d 85 e4 49 c7 c6 20 b3 9c 88 75 0a 49 c7 c6
RSP: 0018:ffffc900057c7b00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88804d17e000 RCX: 0000000000000000
RDX: ffff888057f3e140 RSI: ffffffff81fba412 RDI: fffff52000af8f52
RBP: ffffc900057c7bd0 R08: 000000000000006a R09: ffff8880ae5318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff889d1b20
R13: ffffffff889d2320 R14: ffffffff889cb320 R15: 0000000000002015
FS:  00000000023b5940(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbc9e331db8 CR3: 00000000966ca000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_journal_end+0x3d85/0x4950 fs/reiserfs/journal.c:4135
 reiserfs_sync_fs+0xf8/0x120 fs/reiserfs/super.c:78
 __sync_filesystem fs/sync.c:39 [inline]
 sync_filesystem fs/sync.c:64 [inline]
 sync_filesystem+0x105/0x260 fs/sync.c:48
 generic_shutdown_super+0x70/0x370 fs/super.c:448
 kill_block_super+0x97/0xf0 fs/super.c:1444
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 deactivate_super+0xad/0xd0 fs/super.c:366
 cleanup_mnt+0x3a3/0x530 fs/namespace.c:1118
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:165 [inline]
 exit_to_user_mode_prepare+0x1e1/0x200 kernel/entry/common.c:192
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:267
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x460027
Code: 64 89 04 25 d0 02 00 00 58 5f ff d0 48 89 c7 e8 2f be ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 fd 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffccf055678 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000460027
RDX: 0000000000403188 RSI: 0000000000000002 RDI: 00007ffccf055720
RBP: 0000000000000949 R08: 0000000000000000 R09: 000000000000000b
R10: 0000000000000005 R11: 0000000000000246 R12: 00007ffccf0567b0
R13: 00000000023b6a60 R14: 0000000000000000 R15: 00007ffccf0567b0
Modules linked in:
---[ end trace 3c2c809ae25fc32e ]---
RIP: 0010:__reiserfs_panic.cold+0x37/0x8a fs/reiserfs/prints.c:390
Code: 9c 88 74 6d e8 4f 9a 7a ff 4c 89 e9 4c 89 f2 4c 89 e6 49 c7 c0 20 32 4f 8d 48 c7 c7 e0 b4 9c 88 e8 32 a3 63 ff e8 2e 9a 7a ff <0f> 0b e8 27 9a 7a ff 4d 85 e4 49 c7 c6 20 b3 9c 88 75 0a 49 c7 c6
RSP: 0018:ffffc900057c7b00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88804d17e000 RCX: 0000000000000000
RDX: ffff888057f3e140 RSI: ffffffff81fba412 RDI: fffff52000af8f52
RBP: ffffc900057c7bd0 R08: 000000000000006a R09: ffff8880ae5318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff889d1b20
R13: ffffffff889d2320 R14: ffffffff889cb320 R15: 0000000000002015
FS:  00000000023b5940(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000748698 CR3: 00000000966ca000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
