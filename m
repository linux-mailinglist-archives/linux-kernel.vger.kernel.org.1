Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103D1268849
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgINJ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:29:33 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:38183 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgINJ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:29:16 -0400
Received: by mail-il1-f206.google.com with SMTP id m10so12234066ild.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VtmfLHib2h+LRfNGuXd81ORBmStbkBy6UxzgLPK49r8=;
        b=ZwSgf+EOgtLMXY8GDEp5pmKBYOaHd3QWpqTgoxZe6Ka+NYIyh7NcJFiNNuS8KczUC9
         IEpeAzLa6QuhDMoYBk3J346nPrHX4k9THNXJHM1p3fcwdHe3WjQGbH1B1OuenJNkRcC7
         AbFkTeTMmVAO9B2HLfQBoWyHITYd3N8ND691se2u4XJkoOSo6NITdRosHgTdOn6kBq3e
         uhpbgT9KVzFUTeNWkdDvkhT2nInF5LUDSPcyZVsHnGpxDIM5824Peup1C00T13pfoqF0
         Ntri2nAuvmkdpj7OMNvrsPeIVxU2Qe3hwVY7nBzt+eWuoXgvLXwJEH8p9KZ1CuwTbTf5
         OoEA==
X-Gm-Message-State: AOAM533qe3eVzlhc+WbmVm8G13r3W0hsu0NrR1YCuKeN6UP0URhuPfX/
        sym+bum8pDT+CGAIwWM7VyRsPYF8kJjn8tSZYQkvfcTC8p5B
X-Google-Smtp-Source: ABdhPJwEMwmQUuJTe9lVUdTWgeneHeZFcL8gYebxTb32muyyquevvOOBLpoz424KCtMLnzEZ/ujKEuQVjdJA8YqXTqAWV5+wbBr7
MIME-Version: 1.0
X-Received: by 2002:a92:cc0a:: with SMTP id s10mr11148256ilp.296.1600075755331;
 Mon, 14 Sep 2020 02:29:15 -0700 (PDT)
Date:   Mon, 14 Sep 2020 02:29:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002a86f05af42ab27@google.com>
Subject: general protection fault in madvise_cold_or_pageout_pte_range
From:   syzbot <syzbot+ecf80462cb7d5d552bc7@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andreyknvl@google.com,
        hannes@cmpxchg.org, khalid.aziz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        minchan@kernel.org, rppt@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    729e3d09 Merge tag 'ceph-for-5.9-rc5' of git://github.com/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1482b99e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f5c353182ed6199
dashboard link: https://syzkaller.appspot.com/bug?extid=ecf80462cb7d5d552bc7
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e2a255900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164afdb3900000

The issue was bisected to:

commit 1a4e58cce84ee88129d5d49c064bd2852b481357
Author: Minchan Kim <minchan@kernel.org>
Date:   Wed Sep 25 23:49:15 2019 +0000

    mm: introduce MADV_PAGEOUT

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127f973e900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=117f973e900000
console output: https://syzkaller.appspot.com/x/log.txt?x=167f973e900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ecf80462cb7d5d552bc7@syzkaller.appspotmail.com
Fixes: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT")

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 PID: 6826 Comm: syz-executor142 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__lock_acquire+0x84/0x2ae0 kernel/locking/lockdep.c:4296
Code: ff df 8a 04 30 84 c0 0f 85 e3 16 00 00 83 3d 56 58 35 08 00 0f 84 0e 17 00 00 83 3d 25 c7 f5 07 00 74 2c 4c 89 e8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ef e8 3e d1 5a 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90004b9f850 EFLAGS: 00010006
RAX: 0000000000000003 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000018
RBP: ffffc90004b9f9a8 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff131e2e6 R11: 0000000000000000 R12: ffff8880937161c0
R13: 0000000000000018 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000002638880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002100003f CR3: 00000000a49a2000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:354 [inline]
 madvise_cold_or_pageout_pte_range+0x52f/0x25c0 mm/madvise.c:389
 walk_pmd_range mm/pagewalk.c:89 [inline]
 walk_pud_range mm/pagewalk.c:160 [inline]
 walk_p4d_range mm/pagewalk.c:193 [inline]
 walk_pgd_range mm/pagewalk.c:229 [inline]
 __walk_page_range+0xe7b/0x1da0 mm/pagewalk.c:331
 walk_page_range+0x2c3/0x5c0 mm/pagewalk.c:427
 madvise_pageout_page_range mm/madvise.c:521 [inline]
 madvise_pageout mm/madvise.c:557 [inline]
 madvise_vma mm/madvise.c:946 [inline]
 do_madvise+0x12d0/0x2090 mm/madvise.c:1145
 __do_sys_madvise mm/madvise.c:1171 [inline]
 __se_sys_madvise mm/madvise.c:1169 [inline]
 __x64_sys_madvise+0x76/0x80 mm/madvise.c:1169
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4440e9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffed62d6668 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 00000000004440e9
RDX: 0000000000000015 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 00000000006ce018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000401d50
R13: 0000000000401de0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 0453ba4a30f03f10 ]---
RIP: 0010:__lock_acquire+0x84/0x2ae0 kernel/locking/lockdep.c:4296
Code: ff df 8a 04 30 84 c0 0f 85 e3 16 00 00 83 3d 56 58 35 08 00 0f 84 0e 17 00 00 83 3d 25 c7 f5 07 00 74 2c 4c 89 e8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ef e8 3e d1 5a 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90004b9f850 EFLAGS: 00010006
RAX: 0000000000000003 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000018
RBP: ffffc90004b9f9a8 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff131e2e6 R11: 0000000000000000 R12: ffff8880937161c0
R13: 0000000000000018 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000002638880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002100003f CR3: 00000000a49a2000 CR4: 00000000001506e0
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
