Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4192C9860
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgLAHqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:46:00 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:40649 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgLAHp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:45:57 -0500
Received: by mail-il1-f197.google.com with SMTP id b18so761910ilr.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GIMISXxEBY2bGm7Cc9ODP1AmYZvU0X5mJZhyi/X0how=;
        b=FNV4MjKSCGNZ+JG9I7vb/fOnZNfnu2tbmfBiVMJa+PNirywgnQXqvgIn/yJ9xylwG/
         Uu+uzCuNSZ3qST9Da/uyg5ezd5sgKON3YYC3nIYbrBR/fBmnzrW1p7Zm+X4ImgBs+GQh
         yHCtbQzdPeDLG0zbgd9cvQWgLl+EtOUfKWOIclr40cMwqFhiNCi9hgFfITccmcQ6WZPA
         oKUBCHsMT+lzqpXPK4sQ8OeSLeFdbg9/VX1ZFKW6VoXe4Rqe4bcRYNH5YQJnOF2Jd/zM
         ja781TTndzCQEmnqQiawqbtmnxTkM9sHs+YU7JAuKdcBIvaHSUcq+P4I/w5SXU6nHsh7
         WFqg==
X-Gm-Message-State: AOAM532mjupyl6T/sY6i6jqGQ2Rh5ldORFyDf04vJU1sBGIP1E7Gcwl/
        znv3EUiEvazA6gVYZVNQl8SQosv6LsY7zj6CqIKlWqWPhQLP
X-Google-Smtp-Source: ABdhPJwMLcGDHzoWYNefKTZK9yS5DA5W2EKqSzTQawifXhbj6cra7L9DDj+lAEM4ZlWZ4FCOxTuFktgL+QT+sICpi5x+iCjIAmGE
MIME-Version: 1.0
X-Received: by 2002:a05:6638:124d:: with SMTP id o13mr1602666jas.98.1606808716905;
 Mon, 30 Nov 2020 23:45:16 -0800 (PST)
Date:   Mon, 30 Nov 2020 23:45:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb120405b5624ebf@google.com>
Subject: general protection fault in workingset_age_nonresident
From:   syzbot <syzbot+8f327e215a9398a664b7@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c6b11acc Add linux-next specific files for 20201130
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1074103d500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5e03844e9b34d37
dashboard link: https://syzkaller.appspot.com/bug?extid=8f327e215a9398a664b7
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f327e215a9398a664b7@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc017c027e8b: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000be013f458-0x0000000be013f45f]
CPU: 0 PID: 13851 Comm: syz-executor.5 Not tainted 5.10.0-rc5-next-20201130-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mem_cgroup_lruvec include/linux/memcontrol.h:629 [inline]
RIP: 0010:parent_lruvec include/linux/memcontrol.h:1560 [inline]
RIP: 0010:workingset_age_nonresident+0x13a/0x1c0 mm/workingset.c:242
Code: f8 48 c1 e8 03 80 3c 28 00 0f 85 88 00 00 00 49 8b 9c dc 58 0d 00 00 e8 a4 67 cf ff 48 8d bb c0 00 00 00 48 89 f8 48 c1 e8 03 <80> 3c 28 00 75 56 4c 3b ab c0 00 00 00 75 2b e8 82 67 cf ff 48 85
RSP: 0018:ffffc9000c0074c0 EFLAGS: 00010006
RAX: 000000017c027e8b RBX: 0000000be013f39a RCX: ffffc90013eb6000
RDX: 0000000000040000 RSI: ffffffff81a159ac RDI: 0000000be013f45a
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff88813ffffdbf
R10: ffffed1027ffffb7 R11: 0000000000000000 R12: ffffffff8e790e30
R13: ffff88813fffb000 R14: 0000000000000001 R15: ffffffff8e790d10
FS:  00007fba638dc700(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fba638dbdb8 CR3: 0000000029181000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 workingset_eviction+0x452/0x9b0 mm/workingset.c:266
 __remove_mapping+0x867/0xd20 mm/vmscan.c:927
 shrink_page_list+0x246a/0x5e80 mm/vmscan.c:1431
 reclaim_pages+0x3e2/0xcd0 mm/vmscan.c:2148
 madvise_cold_or_pageout_pte_range+0x1615/0x2880 mm/madvise.c:473
 walk_pmd_range mm/pagewalk.c:89 [inline]
 walk_pud_range mm/pagewalk.c:160 [inline]
 walk_p4d_range mm/pagewalk.c:193 [inline]
 walk_pgd_range mm/pagewalk.c:229 [inline]
 __walk_page_range+0xda4/0x1e20 mm/pagewalk.c:331
 walk_page_range+0x1be/0x450 mm/pagewalk.c:427
 madvise_pageout_page_range mm/madvise.c:526 [inline]
 madvise_pageout+0x21b/0x390 mm/madvise.c:562
 madvise_vma mm/madvise.c:943 [inline]
 do_madvise.part.0+0x9f2/0x1ed0 mm/madvise.c:1142
 do_madvise mm/madvise.c:1168 [inline]
 __do_sys_madvise mm/madvise.c:1168 [inline]
 __se_sys_madvise mm/madvise.c:1166 [inline]
 __x64_sys_madvise+0x113/0x150 mm/madvise.c:1166
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45deb9
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fba638dbc78 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 0000000000020ec0 RCX: 000000000045deb9
RDX: 0000000000000015 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 000000000118c0b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118c07c
R13: 00007ffe3594576f R14: 00007fba638dc9c0 R15: 000000000118c07c
Modules linked in:
---[ end trace 55e42525eeb89bbe ]---
RIP: 0010:mem_cgroup_lruvec include/linux/memcontrol.h:629 [inline]
RIP: 0010:parent_lruvec include/linux/memcontrol.h:1560 [inline]
RIP: 0010:workingset_age_nonresident+0x13a/0x1c0 mm/workingset.c:242
Code: f8 48 c1 e8 03 80 3c 28 00 0f 85 88 00 00 00 49 8b 9c dc 58 0d 00 00 e8 a4 67 cf ff 48 8d bb c0 00 00 00 48 89 f8 48 c1 e8 03 <80> 3c 28 00 75 56 4c 3b ab c0 00 00 00 75 2b e8 82 67 cf ff 48 85
RSP: 0018:ffffc9000c0074c0 EFLAGS: 00010006
RAX: 000000017c027e8b RBX: 0000000be013f39a RCX: ffffc90013eb6000
RDX: 0000000000040000 RSI: ffffffff81a159ac RDI: 0000000be013f45a
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff88813ffffdbf
R10: ffffed1027ffffb7 R11: 0000000000000000 R12: ffffffff8e790e30
R13: ffff88813fffb000 R14: 0000000000000001 R15: ffffffff8e790d10
FS:  00007fba638dc700(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fba638dbdb8 CR3: 0000000029181000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
