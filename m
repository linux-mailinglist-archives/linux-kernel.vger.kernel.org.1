Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5D127A8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1HsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:48:18 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:39471 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1HsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:48:18 -0400
Received: by mail-io1-f78.google.com with SMTP id y16so136153ioy.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xqucxLqQEmlXGY7iibgagZ/XnvxXtCOca8FFb/W7qNg=;
        b=SoxcNi0VKJsUEOxhMjari7vB9UUFec4mRuoIs+9Cq0UPMy8acXSAVrBCUYnoFs+7M/
         3GCFqojcY9n4h1RzWD/4XymQEZroQNm4QjDNNIdZRjIaRFK1wm6gclvuRVoVz30nEen9
         9j8pfzheoPi4PV8gHyQ8eryF/dyLbUhLGJ8JLB8tub43tJaJcnzOIb70yzl8sX7Pahqb
         3DPI0sKrvpt0c+K8AAUpCdszIOq0SmDNPK0/aICsOw1WEP+Bg45jAo7k9kyEMbOvSuin
         NOyGlP+xvBBz1iyA+K4SLnoyLe7aKtUI4nnJatMZ4JZE+/pNmCzAU1ZHD27K1PlD4rws
         Er2A==
X-Gm-Message-State: AOAM532gDMS0T1Puk5U8bbgnKOLzLFFyl1SlKR29kDsXpUVmPPg5H0Sl
        UOLRM/B4ziAIHDX5rVmdN5VpJDwg9Ekx75pbWql73mRgabZE
X-Google-Smtp-Source: ABdhPJyGBppGFLUrp8ay2mglSFJJu+QMS1kY139BBbqWDIsgC05O3qh5QYvv6d2nTv2CbL5YszQqyg4ERkaQt2yBegM03fZzRm0G
MIME-Version: 1.0
X-Received: by 2002:a92:5a48:: with SMTP id o69mr144193ilb.268.1601279297335;
 Mon, 28 Sep 2020 00:48:17 -0700 (PDT)
Date:   Mon, 28 Sep 2020 00:48:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4380505b05ae3b1@google.com>
Subject: BUG: unable to handle kernel paging request in diFree
From:   syzbot <syzbot+0a89a7b56db04c21a656@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    805c6d3c Merge branch 'fixes' of git://git.kernel.org/pub/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15dfd075900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af502ec9a451c9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=0a89a7b56db04c21a656
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f2399b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c34b1d900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=144704e3900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=164704e3900000
console output: https://syzkaller.appspot.com/x/log.txt?x=124704e3900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a89a7b56db04c21a656@syzkaller.appspotmail.com

ERROR: (device loop0): xtSearch: XT_GETPAGE: xtree page corrupt
BUG: unable to handle page fault for address: ffffffffffffff80
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 9690067 P4D 9690067 PUD 9692067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6847 Comm: syz-executor394 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:diFree+0xe3/0x25b0 fs/jfs/jfs_imap.c:853
Code: e8 b2 39 0a ff 48 8b 03 48 89 84 24 c8 00 00 00 48 8d 58 80 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 8d 39 0a ff <48> 8b 03 4c 89 6c 24 08 4d 89 ec 49 c1 ec 0c 48 89 44 24 38 48 8d
RSP: 0018:ffffc90001117a60 EFLAGS: 00010246
RAX: 1ffffffffffffff0 RBX: ffffffffffffff80 RCX: ffff8880a8658340
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888087f174f0
RBP: ffffc90001117bf8 R08: ffffffff82a8b8bd R09: ffffed1010fe2e1c
R10: ffffed1010fe2e1c R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000001 R14: ffff888091a0c668 R15: 1ffff110123418cd
FS:  00000000016fe880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffff80 CR3: 00000000a4d2f000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 jfs_evict_inode+0x259/0x2e0 fs/jfs/inode.c:154
 evict+0x2bb/0x6d0 fs/inode.c:576
 jfs_mount+0x2db/0x300 fs/jfs/jfs_mount.c:210
 jfs_fill_super+0x515/0x9b0 fs/jfs/super.c:562
 mount_bdev+0x24f/0x360 fs/super.c:1417
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x179d/0x29e0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount+0x126/0x180 fs/namespace.c:3390
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446dea
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fff1ed69ad8 EFLAGS: 00000283 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff1ed69b20 RCX: 0000000000446dea
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fff1ed69ae0
RBP: 00007fff1ed69ae0 R08: 00007fff1ed69b20 R09: 6f6f6c2f7665642f
R10: 0000000000008001 R11: 0000000000000283 R12: 0000000000000004
R13: 0000000000000003 R14: 0000000000000003 R15: 0000000000000006
Modules linked in:
CR2: ffffffffffffff80
---[ end trace 5dcf01db00d74546 ]---
RIP: 0010:diFree+0xe3/0x25b0 fs/jfs/jfs_imap.c:853
Code: e8 b2 39 0a ff 48 8b 03 48 89 84 24 c8 00 00 00 48 8d 58 80 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 8d 39 0a ff <48> 8b 03 4c 89 6c 24 08 4d 89 ec 49 c1 ec 0c 48 89 44 24 38 48 8d
RSP: 0018:ffffc90001117a60 EFLAGS: 00010246
RAX: 1ffffffffffffff0 RBX: ffffffffffffff80 RCX: ffff8880a8658340
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888087f174f0
RBP: ffffc90001117bf8 R08: ffffffff82a8b8bd R09: ffffed1010fe2e1c
R10: ffffed1010fe2e1c R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000001 R14: ffff888091a0c668 R15: 1ffff110123418cd
FS:  00000000016fe880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffff80 CR3: 00000000a4d2f000 CR4: 00000000001506e0
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
