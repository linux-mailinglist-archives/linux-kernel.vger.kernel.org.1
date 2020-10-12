Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF98228AE14
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgJLGLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:11:19 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:46928 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgJLGLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:11:18 -0400
Received: by mail-io1-f78.google.com with SMTP id a2so9946618iod.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 23:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZOJO2AmvsswHX9kprL/Q85QYAC49Ojqk4Zjswn1BR28=;
        b=eTc7OxjNHMskdutF9trfKjQ7zMq1p29/1gijyzeneUESsuvJ/gbwuW4twNA5LPnlhC
         b2FtSN4dVsCEAN5sWmIOcoSz6EHaEy0GRN8rANGSIreTFRV/g6cXkvFpDnF2iMdu8agM
         6s/R4ByWswc1edWVQAOw5NHqPwJfoFGuwZUhnTL61j9KpV4OHA1pZ2GpIZySjClls+ip
         8iGmVf02Q58l/+ixZdrzORp1MSSI0UjRWo0ypJG0jCCVdTpcaq9hdkS7LmFdy75IY8nk
         oNbF06Kpr9FwBjoD5zxnqKs8NcsCcxtAx5tbnRNK7D9Pe+OVpqzUpsjvIqUnz4Q8OIKD
         omsQ==
X-Gm-Message-State: AOAM530PQl/yCylP4aHoH5AMYQpb/u2y48FmepVOepX/Vj3cwgi/qK0O
        su9eBKoPMxqn0TKFn2KflR4kcE/fqOjSLGo1aOIRJeZ1sxe1
X-Google-Smtp-Source: ABdhPJyFmDUa/77VAI9lTQqxvauDQ9qqZzEV7oDp9wIZ5CRb4KwGnMVWfOrKr9+NQ1sN+O0s4YzhIq/PhesCoM4nJzyJ/VLnvcIm
MIME-Version: 1.0
X-Received: by 2002:a6b:9041:: with SMTP id s62mr15196031iod.97.1602483077002;
 Sun, 11 Oct 2020 23:11:17 -0700 (PDT)
Date:   Sun, 11 Oct 2020 23:11:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000903b5c05b1732a75@google.com>
Subject: general protection fault in qp_release_pages
From:   syzbot <syzbot+f58fe4bb535845237057@syzkaller.appspotmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dd0130f Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1219a8e8500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c06bcf3cc963d91c
dashboard link: https://syzkaller.appspot.com/bug?extid=f58fe4bb535845237057
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113937fb900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1049031b900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d57007900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d57007900000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d57007900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f58fe4bb535845237057@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 6894 Comm: syz-executor291 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:compound_head include/linux/page-flags.h:182 [inline]
RIP: 0010:put_page include/linux/mm.h:1172 [inline]
RIP: 0010:qp_release_pages+0x5a/0x310 drivers/misc/vmw_vmci/vmci_queue_pair.c:635
Code: 5c ad d1 fc 4d 85 f6 c7 44 24 04 00 00 00 00 0f 85 0f 01 00 00 e9 27 02 00 00 e8 c1 b0 d1 fc 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 62 02 00 00 48 8b 45 08 31 ff 49 89 c4 48 89
RSP: 0018:ffffc900014e7948 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff8880a06990d0 RCX: ffffffff84a48f81
RDX: ffff88808e3ec300 RSI: ffffffff84a48e4f RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8880960634ff
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fffffffd
R13: dffffc0000000000 R14: fffffffffffffff2 R15: 0000000000000000
FS:  0000000001e5e880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 00000000a1e74000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 qp_host_get_user_memory+0x249/0x3e0 drivers/misc/vmw_vmci/vmci_queue_pair.c:660
 qp_host_register_user_memory drivers/misc/vmw_vmci/vmci_queue_pair.c:704 [inline]
 qp_broker_create drivers/misc/vmw_vmci/vmci_queue_pair.c:1383 [inline]
 qp_broker_alloc+0x10f9/0x1bf0 drivers/misc/vmw_vmci/vmci_queue_pair.c:1737
 vmci_qp_broker_alloc+0x48/0x60 drivers/misc/vmw_vmci/vmci_queue_pair.c:1930
 vmci_host_do_alloc_queuepair.constprop.0+0x1b4/0x400 drivers/misc/vmw_vmci/vmci_host.c:488
 vmci_host_unlocked_ioctl+0x13cc/0x1e60 drivers/misc/vmw_vmci/vmci_host.c:927
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4402f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd6af99eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402f9
RDX: 0000000020000100 RSI: 00000000000007a8 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000401b00
R13: 0000000000401b90 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 5d73c037702bf45c ]---
RIP: 0010:compound_head include/linux/page-flags.h:182 [inline]
RIP: 0010:put_page include/linux/mm.h:1172 [inline]
RIP: 0010:qp_release_pages+0x5a/0x310 drivers/misc/vmw_vmci/vmci_queue_pair.c:635
Code: 5c ad d1 fc 4d 85 f6 c7 44 24 04 00 00 00 00 0f 85 0f 01 00 00 e9 27 02 00 00 e8 c1 b0 d1 fc 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 62 02 00 00 48 8b 45 08 31 ff 49 89 c4 48 89
RSP: 0018:ffffc900014e7948 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff8880a06990d0 RCX: ffffffff84a48f81
RDX: ffff88808e3ec300 RSI: ffffffff84a48e4f RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8880960634ff
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fffffffd
R13: dffffc0000000000 R14: fffffffffffffff2 R15: 0000000000000000
FS:  0000000001e5e880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 00000000a1e74000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
