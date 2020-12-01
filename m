Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A32C984A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgLAHlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:41:06 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:55043 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgLAHlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:41:06 -0500
Received: by mail-il1-f200.google.com with SMTP id z8so723203ilq.21
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mdZo0CBoOy0BSEc3OB8eUAquJiRm1blWIzW6S9YYI4A=;
        b=F1MFrRply000JlB3ECFPP/kUVBrCULSBdwAIGjLzi+RvKQWp1Eyo31DgpjUiuj/yCj
         hVSxT+0LL7gUPa1E2cAmffWVZTARMWqBFi67wLwP6WAn17NgihcFtAEdN09VG0cfXGP8
         CZMcenDeXqcrVg2xYZfeUCxLeFwHDgmd2dNdp6sjypfNHhMUxLYjrtU6HH22q3j66vpz
         qZRfHjk3m9KjJfIX+rKU6g6ogOu+8PP0OeraqCZDRzUPcn/wWv3dNideOqeRJztkEmnt
         oZDuyMyIErZyxjEzSoJQ/uJFPFGPncpIwgELEXTjrIOZ24jVaGks9qyhXAF0C2RkzWOb
         UwQw==
X-Gm-Message-State: AOAM531FgSaeFgToMTKmA77mKc196RiS6/tf9YL3JXeZ13kZQZTWfXn4
        zzQvRQiDU8i1GfblgMpQD7SzQGC3Z2C1hEJ0kKNYJaYYry5r
X-Google-Smtp-Source: ABdhPJybXyU5oWwQIbNLiltX4ZwcWxqq3WMVeAjnadDP9SpjR3XOpUxQI+SJensxXSlnCu0N4aYDyI+E+bFaunrufQoQV+6qPlGo
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f93:: with SMTP id v19mr1510778ilo.154.1606808425192;
 Mon, 30 Nov 2020 23:40:25 -0800 (PST)
Date:   Mon, 30 Nov 2020 23:40:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067e37805b5623d10@google.com>
Subject: BUG: unable to handle kernel paging request in workingset_age_nonresident
From:   syzbot <syzbot+a59e7ceb87a83c5233df@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c6b11acc Add linux-next specific files for 20201130
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=114b94e9500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5e03844e9b34d37
dashboard link: https://syzkaller.appspot.com/bug?extid=a59e7ceb87a83c5233df
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150fed8b500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1726291d500000

The issue was bisected to:

commit 76761ffa9ea1ddca78e817bf7eec5fcb0378a00c
Author: Alex Shi <alex.shi@linux.alibaba.com>
Date:   Sun Nov 29 23:58:06 2020 +0000

    mm/memcg: bail out early when !memcg in mem_cgroup_lruvec

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122ff445500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112ff445500000
console output: https://syzkaller.appspot.com/x/log.txt?x=162ff445500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a59e7ceb87a83c5233df@syzkaller.appspotmail.com
Fixes: 76761ffa9ea1 ("mm/memcg: bail out early when !memcg in mem_cgroup_lruvec")

BUG: unable to handle page fault for address: ffffffff81417c79
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD b08f067 P4D b08f067 PUD b090063 PMD 14001e1 
Oops: 0003 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8503 Comm: syz-executor118 Not tainted 5.10.0-rc5-next-20201130-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mem_cgroup_lruvec include/linux/memcontrol.h:630 [inline]
RIP: 0010:parent_lruvec include/linux/memcontrol.h:1560 [inline]
RIP: 0010:workingset_age_nonresident+0x179/0x1c0 mm/workingset.c:242
Code: 85 db 0f 85 c8 fe ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f e9 6a 67 cf ff e8 65 67 cf ff 49 8d 9d 18 4d 00 00 eb b3 e8 57 67 cf ff <4c> 89 ab c0 00 00 00 eb c7 e8 69 35 12 00 e9 d3 fe ff ff e8 5f 35
RSP: 0018:ffffc9000112f4c0 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffffff81417bb9 RCX: 0000000000000000
RDX: ffff88801eee5040 RSI: ffffffff81a159f9 RDI: ffffffff81417c79
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff88813ffffdbf
R10: ffffed1027ffffb7 R11: 0000000000000000 R12: ffffffff8e7911d0
R13: ffff88813fffb000 R14: 0000000000000001 R15: ffffffff8e7910b0
FS:  0000000002581880(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff81417c79 CR3: 0000000013a2f000 CR4: 00000000001506e0
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
RIP: 0033:0x440279
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe7c1ab298 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440279
RDX: 0000000000000015 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000401a80
R13: 0000000000401b10 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: ffffffff81417c79
---[ end trace 89bcebda47215cf6 ]---
RIP: 0010:mem_cgroup_lruvec include/linux/memcontrol.h:630 [inline]
RIP: 0010:parent_lruvec include/linux/memcontrol.h:1560 [inline]
RIP: 0010:workingset_age_nonresident+0x179/0x1c0 mm/workingset.c:242
Code: 85 db 0f 85 c8 fe ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f e9 6a 67 cf ff e8 65 67 cf ff 49 8d 9d 18 4d 00 00 eb b3 e8 57 67 cf ff <4c> 89 ab c0 00 00 00 eb c7 e8 69 35 12 00 e9 d3 fe ff ff e8 5f 35
RSP: 0018:ffffc9000112f4c0 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffffff81417bb9 RCX: 0000000000000000
RDX: ffff88801eee5040 RSI: ffffffff81a159f9 RDI: ffffffff81417c79
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff88813ffffdbf
R10: ffffed1027ffffb7 R11: 0000000000000000 R12: ffffffff8e7911d0
R13: ffff88813fffb000 R14: 0000000000000001 R15: ffffffff8e7910b0
FS:  0000000002581880(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff81417c79 CR3: 0000000013a2f000 CR4: 00000000001506e0
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
