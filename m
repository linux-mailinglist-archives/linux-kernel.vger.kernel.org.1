Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607462DB68E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgLOWew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:34:52 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:44531 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbgLOWev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:34:51 -0500
Received: by mail-io1-f69.google.com with SMTP id a1so14879603ioa.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 14:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qJfOOi/jCLah0HLkC8kP6zj2p36F/BFmhOKk9WK7kP4=;
        b=e8dMx2G491wQJxH9IF2jbvEHcsgAM8nrcTeYqFwkvS39fOrPpX8z1H4guD8Y0R+ql6
         Xg8c0KTnVb+cgM0CXpOSk6RaU74kz37Svsdzhi9BcMD5rRhszFazYBMjADL6S418szhd
         IBaJ+U24wmLSIX57CpGvy2kcGMznyur1PygUUQIdX9339ajY7r97onZAU1YQMQgsH7bV
         uPBlSEwOMBsluUeAvNiIa9GE2OuPM6NFOZQjn4vIGuUgN9rLH9fd+VTS2z7u2glNEvrI
         DpCudgp+LgeczVNo1jTVl2sTSPOzhfWUUTm/l6lH/r7eyKOL0llQIbrYhL51gof0T5bH
         q1Sg==
X-Gm-Message-State: AOAM533TtmseUFaegFSlo49xOACGKloSmOVb1U4iz2zkB/TbhpWrV/Mv
        lsfj1KX0nufQa4G0WVSSMuuomwgCnxRj4OzUYUflmEMyUdgQ
X-Google-Smtp-Source: ABdhPJzbkZhzOYYDOkE+/F5indI6uJhmMqcscBShZQtOO/mhLxMb2tSuzs8M2VrVedkiD6NKdF7cmrfqsFZDgdbEPERNd/newhxA
MIME-Version: 1.0
X-Received: by 2002:a02:ab95:: with SMTP id t21mr41065966jan.51.1608071650238;
 Tue, 15 Dec 2020 14:34:10 -0800 (PST)
Date:   Tue, 15 Dec 2020 14:34:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c672a05b6885bb9@google.com>
Subject: BUG: corrupted list in klist_release
From:   syzbot <syzbot+676530ea9d4736aad21c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    33dc9614 Merge tag 'ktest-v5.10-rc6' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f2f703500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3416bb960d5c705d
dashboard link: https://syzkaller.appspot.com/bug?extid=676530ea9d4736aad21c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c17c5b500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b5b923500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+676530ea9d4736aad21c@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
list_del corruption. prev->next should be ffff88801b11ec68, but was ffff88801b644040
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:51!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8512 Comm: syz-executor819 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__list_del_entry_valid.cold+0xf/0x4a lib/list_debug.c:51
Code: e8 fb 12 f7 ff 0f 0b 48 89 f1 48 c7 c7 40 94 9d 89 4c 89 e6 e8 e7 12 f7 ff 0f 0b 48 89 ee 48 c7 c7 e0 95 9d 89 e8 d6 12 f7 ff <0f> 0b 4c 89 ea 48 89 ee 48 c7 c7 20 95 9d 89 e8 c2 12 f7 ff 0f 0b
RSP: 0018:ffffc9000177f998 EFLAGS: 00010286
RAX: 0000000000000054 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880189b8000 RSI: ffffffff8158c835 RDI: fffff520002eff25
RBP: ffff88801b11ec68 R08: 0000000000000054 R09: ffff8880b9f30627
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888011063068
R13: ffff888011063068 R14: ffff88801b11ec60 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000200 CR3: 000000000b08e000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_del_entry include/linux/list.h:132 [inline]
 list_del include/linux/list.h:146 [inline]
 klist_release+0x66/0x480 lib/klist.c:189
 kref_put include/linux/kref.h:65 [inline]
 klist_dec_and_del lib/klist.c:206 [inline]
 klist_put+0xf7/0x1d0 lib/klist.c:217
 device_del+0x245/0xec0 drivers/base/core.c:3094
 hci_conn_del_sysfs+0xdc/0x180 net/bluetooth/hci_sysfs.c:78
 hci_conn_cleanup+0x2e7/0x6c0 net/bluetooth/hci_conn.c:138
 hci_conn_del+0x2a0/0x790 net/bluetooth/hci_conn.c:645
 hci_conn_hash_flush+0x19c/0x260 net/bluetooth/hci_conn.c:1558
 hci_dev_do_close+0x569/0x1110 net/bluetooth/hci_core.c:1770
 hci_unregister_dev+0x223/0xfe0 net/bluetooth/hci_core.c:3827
 vhci_release+0x70/0xe0 drivers/bluetooth/hci_vhci.c:340
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:151
 exit_task_work include/linux/task_work.h:30 [inline]
 do_exit+0xb64/0x29b0 kernel/exit.c:809
 do_group_exit+0x125/0x310 kernel/exit.c:906
 __do_sys_exit_group kernel/exit.c:917 [inline]
 __se_sys_exit_group kernel/exit.c:915 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:915
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x445098
Code: Unable to access opcode bytes at RIP 0x44506e.
RSP: 002b:00007ffeec93f2f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000445098
RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00000000004ccdf0 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000015 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006e0200 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace e0d5d8f0eda11654 ]---
RIP: 0010:__list_del_entry_valid.cold+0xf/0x4a lib/list_debug.c:51
Code: e8 fb 12 f7 ff 0f 0b 48 89 f1 48 c7 c7 40 94 9d 89 4c 89 e6 e8 e7 12 f7 ff 0f 0b 48 89 ee 48 c7 c7 e0 95 9d 89 e8 d6 12 f7 ff <0f> 0b 4c 89 ea 48 89 ee 48 c7 c7 20 95 9d 89 e8 c2 12 f7 ff 0f 0b
RSP: 0018:ffffc9000177f998 EFLAGS: 00010286
RAX: 0000000000000054 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880189b8000 RSI: ffffffff8158c835 RDI: fffff520002eff25
RBP: ffff88801b11ec68 R08: 0000000000000054 R09: ffff8880b9f30627
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888011063068
R13: ffff888011063068 R14: ffff88801b11ec60 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000200 CR3: 000000000b08e000 CR4: 00000000001506e0
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
