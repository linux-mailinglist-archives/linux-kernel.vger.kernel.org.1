Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F18D2F0A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 00:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbhAJXa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 18:30:56 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:54906 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAJXaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 18:30:55 -0500
Received: by mail-io1-f70.google.com with SMTP id w26so11295633iox.21
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 15:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=X1JNYRWQWHd7SyuQYk0eJYZCltMJ6JCHhogyCcyvBos=;
        b=QTwsJ95igup4oGNV11TGsEMKRHSxS/oyzq+1GNZ77Cha7sd3ER4od4nJhIXK7lV9/S
         28sWDzqI+7PQDU4cqjE7YuOR/15L0/dz9JrRrEygxacB/86kL99yQjeLQrWb3umdEAZj
         /Gd4ruc8estF+bTt78Ub07utj2Jtz/b73uTLZZbUBP1efHFh3dKoQ0LM/49Y7R3eMeXB
         uVc4x4Axcuijz9KiiQ97obh9RRjDjLqhFfoSoft/O8X6bx9hjJR8x98ANADI6JFn05KA
         el1pGLsXQ2etPu9sTDU1fx/l3eESfemPRQnqbXH4EUoOQ6r++8x0wG6LABTfz4RJfHL0
         wYCw==
X-Gm-Message-State: AOAM531xmF5lZ3JpM2T0Up6u/+pCLXeFYKykLit//n9eDRlPvJmSA2MC
        uOyOVvygI7HW2OCrTGZAOxGZSpHuQVP6Iq21QOgvuuF1tPA5
X-Google-Smtp-Source: ABdhPJxN5vFsDKAOjlh9MCRfd9VqSKm7LYCFgAcroKrvi4ALASt0zs9Mfe8NmcOnGzjYrgWFHm0ZYx7KEb6+Epi/WuUuyj2MfrQT
MIME-Version: 1.0
X-Received: by 2002:a92:9510:: with SMTP id y16mr13545436ilh.26.1610321414203;
 Sun, 10 Jan 2021 15:30:14 -0800 (PST)
Date:   Sun, 10 Jan 2021 15:30:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de2f4f05b8942be9@google.com>
Subject: WARNING in input_mt_init_slots
From:   syzbot <syzbot+0122fa359a69694395d5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f5e6c330 Merge tag 'spi-fix-v5.11-rc2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121ca757500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa30b9da402d224
dashboard link: https://syzkaller.appspot.com/bug?extid=0122fa359a69694395d5
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eee7db500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1456a0cf500000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10778f4f500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12778f4f500000
console output: https://syzkaller.appspot.com/x/log.txt?x=14778f4f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0122fa359a69694395d5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8471 at mm/page_alloc.c:4976 __alloc_pages_nodemask+0x5f8/0x730 mm/page_alloc.c:5011
Modules linked in:
CPU: 1 PID: 8471 Comm: syz-executor772 Not tainted 5.11.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x5f8/0x730 mm/page_alloc.c:4976
Code: 00 00 0c 00 0f 85 a7 00 00 00 8b 3c 24 4c 89 f2 44 89 e6 c6 44 24 70 00 48 89 6c 24 58 e8 d0 d7 ff ff 49 89 c5 e9 ea fc ff ff <0f> 0b e9 b5 fd ff ff 89 74 24 14 4c 89 4c 24 08 4c 89 74 24 18 e8
RSP: 0018:ffffc900015efbb8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff920002bdf7b RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000040dc0
RBP: 0000000000040dc0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81b1f7e1 R11: 0000000000000000 R12: 000000000000000b
R13: 000000000000000b R14: 0000000000000000 R15: ffff888025a36168
FS:  00000000006fc880(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000012990000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages_current+0x18c/0x2a0 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x2e/0xb0 mm/slab_common.c:837
 kmalloc_order_trace+0x14/0x120 mm/slab_common.c:853
 kmalloc include/linux/slab.h:557 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 input_mt_init_slots drivers/input/input-mt.c:49 [inline]
 input_mt_init_slots+0xd9/0x5f0 drivers/input/input-mt.c:38
 uinput_create_device drivers/input/misc/uinput.c:327 [inline]
 uinput_ioctl_handler.isra.0+0x81d/0x1dc0 drivers/input/misc/uinput.c:870
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440e99
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc567274b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440e99
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000246 R12: 00000000004026a0
R13: 0000000000402730 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
