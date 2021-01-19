Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF712FAE68
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 02:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392679AbhASBtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 20:49:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:41065 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392592AbhASBtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 20:49:02 -0500
Received: by mail-io1-f70.google.com with SMTP id x189so13872786iof.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 17:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wIzbteXJHCU2iudd6X2oaALg36vL5d6tV7GtrAi4VRQ=;
        b=b8lpNix4qyXiEv+blhD3+un9LBDFlYS5Pw40cDUTK/c9aeSk87LV52P60K6l7KT1ek
         H2DFNk2/O0Ht4RtkjXOQ8EKAQMCD/SJaMnoo/pYOPfssk1lF9zJHq8wm0RlQA/nKVBbm
         StlUXRkQQRRJbS55y4c0Jcebft7TeK6NWFB5saYx22mgXBe88xOdWlIVhPxCQKahBTBW
         0pcZCMSYMVLtalz9SFM7sjwolFAXpwzpNNt0PJT/d96VgZVMqkZfYcQxALAAWPc/FocF
         4Vb5aK2v/GVDIqdzDGnGNkwlXdQsCcJduVakAJm6ljoJ1PnvV6aB54MzCw8WARjngH4q
         08Yw==
X-Gm-Message-State: AOAM532oTjR7s/8ijaCohcYXXqEhqcv+n2rMJWeAXECTM96Nns66HAJK
        a8aHYznMLiFX5YgwQJZErKzrj+SRqYQxK2VTAElHWUQZYtP4
X-Google-Smtp-Source: ABdhPJzF1fiuBv20/rZQCDqNNW7EQUYc6PYpvDOa1nGPlpePk+smiYbLJqH2zDCNaQSWm2Ds2UlfnVXJIIRHePxiK5E/rTgRrWO+
MIME-Version: 1.0
X-Received: by 2002:a92:650b:: with SMTP id z11mr1589797ilb.84.1611020900910;
 Mon, 18 Jan 2021 17:48:20 -0800 (PST)
Date:   Mon, 18 Jan 2021 17:48:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000864e7305b93708e7@google.com>
Subject: WARNING in qp_broker_alloc
From:   syzbot <syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com>
To:     alex.dewar90@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    65f0d241 Merge tag 'sound-5.11-rc4' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e21acf500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee2266946ed36986
dashboard link: https://syzkaller.appspot.com/bug?extid=15ec7391f3d6a1a7cc7d
compiler:       clang version 11.0.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17626e3f500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140d2c20d00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b656f7500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11b656f7500000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b656f7500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8466 at mm/page_alloc.c:4976 __alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Modules linked in:
CPU: 0 PID: 8466 Comm: syz-executor022 Not tainted 5.11.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Code: aa 09 00 e9 dd fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c eb fd ff ff 4c 89 ef e8 54 aa 09 00 8b 74 24 18 e9 da fd ff ff <0f> 0b e9 f3 fd ff ff a9 00 00 08 00 75 16 8b 4c 24 1c 89 cb 81 e3
RSP: 0018:ffffc900011ff5e0 EFLAGS: 00010246
RAX: ffffc900011ff660 RBX: ffffc900011ff660 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc900011ff688
RBP: ffffc900011ff708 R08: dffffc0000000000 R09: ffffc900011ff660
R10: fffff5200023fed1 R11: 0000000000000000 R12: dffffc0000000000
R13: 000000000000000c R14: 1ffff9200023fec8 R15: 0000000000040dc0
FS:  0000000000a3c880(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1d268a66c0 CR3: 000000001283c000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x40/0x130 mm/slab_common.c:837
 kmalloc_order_trace+0x15/0x70 mm/slab_common.c:853
 kmalloc_large include/linux/slab.h:481 [inline]
 __kmalloc+0x257/0x330 mm/slub.c:3959
 kmalloc include/linux/slab.h:557 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 qp_host_alloc_queue drivers/misc/vmw_vmci/vmci_queue_pair.c:540 [inline]
 qp_broker_create drivers/misc/vmw_vmci/vmci_queue_pair.c:1351 [inline]
 qp_broker_alloc+0x936/0x2740 drivers/misc/vmw_vmci/vmci_queue_pair.c:1739
 vmci_qp_broker_alloc+0x46/0x60 drivers/misc/vmw_vmci/vmci_queue_pair.c:1932
 vmci_host_do_alloc_queuepair drivers/misc/vmw_vmci/vmci_host.c:463 [inline]
 vmci_host_unlocked_ioctl+0x114f/0x30f0 drivers/misc/vmw_vmci/vmci_host.c:927
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4402f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe87f270c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402f9
RDX: 0000000020000140 RSI: 00000000000007a8 RDI: 0000000000000003
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
