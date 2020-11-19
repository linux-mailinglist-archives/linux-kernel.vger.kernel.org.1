Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC8D2B8B92
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgKSGVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:21:18 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:37876 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgKSGVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:21:18 -0500
Received: by mail-io1-f69.google.com with SMTP id b4so3883929ioa.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 22:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bRfnd+Kmtxd2gIZV58DgY4uDkTr5vTy/tpcooXIgq1Y=;
        b=fFRbtVUdfz2h+tqWmVVYe4gCHqjEXi2ycwhP75fJKy9Q3zcljxQXy/yP1COpUVZ3vU
         e+JNeoo97SzSU0OF7gkwMiFhb/X+Iev1hcntk95kDgNUfe1cUEgSrA4PFR9PKJ43MO9h
         bVZj+UUVQNM0+HKJFN9vW86vhEGIwd9wpEPNJR2P7d7wJ+uOUx+8suHg+Po8sCHJfIEq
         qO7n7qsyDljkH4ZSpJNSILMFH2LPVHDrxf7Qcxe8vWo/V8iYCsEU+OvVTLsW0VMERHp0
         BuQUej/PZ3tGe2IA45uxT09LGyF7Wk9F02MFjROiYSHMwX7wlOpJNdfBMw5SqAHu/0T7
         XAgw==
X-Gm-Message-State: AOAM530r1rebH2ZL0bfkW8PDIEhhxT5keGbT2mNukWy4X3nvVxM+IQHD
        HmqBuzmNZ657F/xzGvrxmSRl/v3cq5/a/7b14ehwxi1GsZ3M
X-Google-Smtp-Source: ABdhPJx7bC7I6/LpW0XRBQqyMO131qELWx1zZHV8HFaOnrWreGE5kOOthWx9te/CFBHFHT1WTB+btXYGOJsgvvx+ku6EXf1S+XoA
MIME-Version: 1.0
X-Received: by 2002:a92:da10:: with SMTP id z16mr20496378ilm.20.1605766877398;
 Wed, 18 Nov 2020 22:21:17 -0800 (PST)
Date:   Wed, 18 Nov 2020 22:21:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051ccd505b46fbc45@google.com>
Subject: kernel BUG at mm/filemap.c:LINE! (2)
From:   syzbot <syzbot+f0179a8115cb538470a6@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e28c0d7c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145b685a500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86ae89f992df998f
dashboard link: https://syzkaller.appspot.com/bug?extid=f0179a8115cb538470a6
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0179a8115cb538470a6@syzkaller.appspotmail.com

raw: 0000000000000000 0000000000000000 00000202ffffffff ffff88801e330000
page dumped because: VM_BUG_ON_PAGE(page_mapped(page))
page->mem_cgroup:ffff88801e330000
------------[ cut here ]------------
kernel BUG at mm/filemap.c:173!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 10789 Comm: syz-executor.1 Not tainted 5.10.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:unaccount_page_cache_page+0xb1a/0x1040 mm/filemap.c:173
Code: e8 eb f3 dd ff 48 c7 c6 00 d6 53 89 48 89 ef e8 cc d6 0d 00 0f 0b e8 d5 f3 dd ff 48 c7 c6 60 da 53 89 48 89 ef e8 b6 d6 0d 00 <0f> 0b e8 bf f3 dd ff 49 8d 9f 58 4d 00 00 e9 7e fb ff ff e8 ae f3
RSP: 0018:ffffc900023bf668 EFLAGS: 00010096
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc9000cb33000
RDX: 0000000000040000 RSI: ffffffff88ae5577 RDI: fffff52000477e67
RBP: ffffea0001c68000 R08: 0000000000000021 R09: ffff88802cd2005b
R10: 0000000000000000 R11: 0000000000000000 R12: ffffea0001c68008
R13: ffff88801e3f85c8 R14: 0000000000000000 R15: ffffea0001c50308
FS:  00007f5a5d2ba700(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5a5d298db8 CR3: 000000006f8d8000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __delete_from_page_cache mm/filemap.c:238 [inline]
 delete_from_page_cache+0x150/0x240 mm/filemap.c:274
 truncate_inode_page+0x85/0xd0 mm/truncate.c:228
 shmem_undo_range+0x5ef/0x1b00 mm/shmem.c:949
 shmem_truncate_range mm/shmem.c:1058 [inline]
 shmem_setattr+0x67a/0xc70 mm/shmem.c:1117
 notify_change+0xb60/0x10a0 fs/attr.c:336
 do_truncate+0x134/0x1f0 fs/open.c:64
 handle_truncate fs/namei.c:2910 [inline]
 do_open fs/namei.c:3256 [inline]
 path_openat+0x2054/0x2730 fs/namei.c:3369
 do_filp_open+0x17e/0x3c0 fs/namei.c:3396
 do_sys_openat2+0x16d/0x420 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_creat fs/open.c:1258 [inline]
 __se_sys_creat fs/open.c:1252 [inline]
 __x64_sys_creat+0xc9/0x120 fs/open.c:1252
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45da59
Code: bd b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 8b b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5a5d2b9c88 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00000000006f4da0 RCX: 000000000045da59
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000400
RBP: 00000000004aab8b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000075c050
R13: 00007ffddf47bd7f R14: 00007f5a5d29a000 R15: 0000000000000003
Modules linked in:
---[ end trace 0b8db26874e8aeaf ]---
RIP: 0010:unaccount_page_cache_page+0xb1a/0x1040 mm/filemap.c:173
Code: e8 eb f3 dd ff 48 c7 c6 00 d6 53 89 48 89 ef e8 cc d6 0d 00 0f 0b e8 d5 f3 dd ff 48 c7 c6 60 da 53 89 48 89 ef e8 b6 d6 0d 00 <0f> 0b e8 bf f3 dd ff 49 8d 9f 58 4d 00 00 e9 7e fb ff ff e8 ae f3
RSP: 0018:ffffc900023bf668 EFLAGS: 00010096
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc9000cb33000
RDX: 0000000000040000 RSI: ffffffff88ae5577 RDI: fffff52000477e67
RBP: ffffea0001c68000 R08: 0000000000000021 R09: ffff88802cd2005b
R10: 0000000000000000 R11: 0000000000000000 R12: ffffea0001c68008
R13: ffff88801e3f85c8 R14: 0000000000000000 R15: ffffea0001c50308
FS:  00007f5a5d2ba700(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5a5d298db8 CR3: 000000006f8d8000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
