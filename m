Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA29A2F0210
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 18:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbhAIRID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 12:08:03 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:48723 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbhAIRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 12:08:02 -0500
Received: by mail-il1-f197.google.com with SMTP id f4so13319588ilu.15
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 09:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IF0ukMjdnHkAu7VCugIiLiVJtIZRWn3GfWqtfyzgXRI=;
        b=Z3Ah96Gh20iIS16vMnr/cfHlVMgeSOOjm3wXsk0H8RzU7NF4pG7NuQfajnSOhjXnon
         4/cREEuNxXYf8MvoZbbA0MvicgF1g6f8RLrx7LZ/LX+/18Yx3w42X80mi0XkiaEeAxan
         SyRv3KZSG7Nlaax2A5gakWjt5BY0ljM+IoDaox8WeP2WKqAQgTZU30+n2bAny25hZlok
         m0RmYbN1vP4R0CQKoKZmxVAy54QmU+5Wwh3tUKiD0CLJTyCnaog+DBE2kxJXaHN5koCi
         0yM3rPwlChXOOq26emru2Uep1e5Q97bltn8xnJFbTds9JbPquBjSQyUw95K2uUxtRPJt
         dx+A==
X-Gm-Message-State: AOAM531LNFBC7iEZO/nn4fF4+6eftdQAKyNNAwPpBNt2ZHAw/NHrlcTj
        zPahJt4Qbqn/KzniFL+KBB4kvYnsm0uRUJBVY9idp31mn9Pm
X-Google-Smtp-Source: ABdhPJybscSjKXrV6zEuIn5UAjzPtN7HwZ8gTBDyG6Q4+98xeHlXqvaR6T6yfxf10lJ7jNON/BzHoZtXF8z9wo1r4dmGcGpZJpWi
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216f:: with SMTP id s15mr6386491ilv.81.1610212041688;
 Sat, 09 Jan 2021 09:07:21 -0800 (PST)
Date:   Sat, 09 Jan 2021 09:07:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c20eb805b87ab49b@google.com>
Subject: WARNING in qp_host_alloc_queue
From:   syzbot <syzbot+3ad726072ce632af076c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    36bbbd0e Merge branch 'rcu/urgent' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d51767500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa30b9da402d224
dashboard link: https://syzkaller.appspot.com/bug?extid=3ad726072ce632af076c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f5b9c0d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d194db500000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1443a3a8d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1643a3a8d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1243a3a8d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ad726072ce632af076c@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8496 at mm/page_alloc.c:4976 __alloc_pages_nodemask+0x5f8/0x730 mm/page_alloc.c:5011
Modules linked in:
CPU: 1 PID: 8496 Comm: syz-executor831 Not tainted 5.11.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x5f8/0x730 mm/page_alloc.c:4976
Code: 00 00 0c 00 0f 85 a7 00 00 00 8b 3c 24 4c 89 f2 44 89 e6 c6 44 24 70 00 48 89 6c 24 58 e8 d0 d7 ff ff 49 89 c5 e9 ea fc ff ff <0f> 0b e9 b5 fd ff ff 89 74 24 14 4c 89 4c 24 08 4c 89 74 24 18 e8
RSP: 0018:ffffc9000130f840 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff92000261f0c RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000040dc0
RBP: 0000000000040dc0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81b1f7f1 R11: 0000000000000000 R12: 000000000000000c
R13: 000000000000000c R14: 0000000000000000 R15: ffff88801bb5ec00
FS:  00000000013e5880(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f72e34306c0 CR3: 000000001d402000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages_current+0x18c/0x2a0 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x2e/0xb0 mm/slab_common.c:837
 kmalloc_order_trace+0x14/0x120 mm/slab_common.c:853
 kmalloc include/linux/slab.h:557 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 qp_host_alloc_queue+0x4d/0x230 drivers/misc/vmw_vmci/vmci_queue_pair.c:540
 qp_broker_create drivers/misc/vmw_vmci/vmci_queue_pair.c:1351 [inline]
 qp_broker_alloc+0xea7/0x1bf0 drivers/misc/vmw_vmci/vmci_queue_pair.c:1739
 vmci_qp_broker_alloc+0x48/0x60 drivers/misc/vmw_vmci/vmci_queue_pair.c:1932
 vmci_host_do_alloc_queuepair.constprop.0+0x2c8/0x3a0 drivers/misc/vmw_vmci/vmci_host.c:463
 vmci_host_unlocked_ioctl+0x13c7/0x1e50 drivers/misc/vmw_vmci/vmci_host.c:927
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4402f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd50062838 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402f9
RDX: 0000000020000040 RSI: 00000000000007a8 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000401b00
R13: 0000000000401b90 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
