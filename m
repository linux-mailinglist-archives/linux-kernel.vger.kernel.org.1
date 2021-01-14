Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776B62F661B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbhANQlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:41:03 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:47901 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbhANQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:41:03 -0500
Received: by mail-io1-f71.google.com with SMTP id q21so9324716ios.14
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7192zlKn16JygXH2LKAVWnZBIVE6P8l/NpsiiaO75NA=;
        b=dOgGNdw9XrghBbpqEzE6QRPHx2XIln2gZRe7WOaf5SKap+lfPbCa+l00VC1n0hrD8L
         yGEr56ie9i4LUZTYTrQLvWAXUy+x8/xWeZTozADjpy+EpMLetlL9Nj0TInmCvoUq8/3w
         4GeaoC2FTAzRWAboZFNfkB+xNDeQxuuTL8On57acVwKoM5uCA7MuoeT6++CDC/xKt88w
         ICL0iFzxhrgHWI4Ke+8T9jAdwGJgtp6HWlkbVPS0cTnc7QGxi989jPi7lWUjSaC13Pjb
         bgPkQVCpBOCpdmstC+3+V+kxfYYNVvSM2dkfpw0oF/h68TBOgyZclYx95SDSVrJCBk4r
         M8jA==
X-Gm-Message-State: AOAM531+yWp0u2a/+WfBW6/E+NaWJRpm1EcsqI0YClSAAL6sElL0uip5
        +Afg+ozyfoXUSp8oGuvklVX3CLCHM2++EBkkfXq4EjHwXp3W
X-Google-Smtp-Source: ABdhPJzjOPE9SnvDLy/rcdcnwqSwSQKdpXj9u2jomn+c0UpG4sqd7H925P5JTRcmtkxSnPTXzkzZ3ArazzfA7iI9aySct8ueT8kn
MIME-Version: 1.0
X-Received: by 2002:a92:9eda:: with SMTP id s87mr7479532ilk.85.1610642422026;
 Thu, 14 Jan 2021 08:40:22 -0800 (PST)
Date:   Thu, 14 Jan 2021 08:40:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006cd76105b8dee9e3@google.com>
Subject: BUG: corrupted list in kobject_add_internal (2)
From:   syzbot <syzbot+77966d28c046cef546cb@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2ff90100 Merge tag 'hwmon-for-v5.11-rc3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cee4cf500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c84b50cb7dc0e2f
dashboard link: https://syzkaller.appspot.com/bug?extid=77966d28c046cef546cb
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77966d28c046cef546cb@syzkaller.appspotmail.com

list_add double add: new=ffff888073202420, prev=ffff888073202420, next=ffff88814077de00.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:29!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8482 Comm: kworker/u5:1 Not tainted 5.11.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci4 hci_rx_work
RIP: 0010:__list_add_valid.cold+0x26/0x3c lib/list_debug.c:29
Code: 77 cf fb fa 4c 89 e1 48 c7 c7 e0 7f 9e 89 e8 36 34 f3 ff 0f 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 20 81 9e 89 e8 1f 34 f3 ff <0f> 0b 48 89 f1 48 c7 c7 a0 80 9e 89 4c 89 e6 e8 0b 34 f3 ff 0f 0b
RSP: 0018:ffffc90001b97830 EFLAGS: 00010282
RAX: 0000000000000058 RBX: ffff88814077de00 RCX: 0000000000000000
RDX: ffff88806db94240 RSI: ffffffff815b6a45 RDI: fffff52000372ef8
RBP: ffff888073202420 R08: 0000000000000058 R09: 0000000000000000
R10: ffffffff815afbee R11: 0000000000000000 R12: ffff88814077de00
R13: ffff8880a0181298 R14: ffff888073202438 R15: ffff888073202420
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000016b9e60 CR3: 000000007a823000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 __list_add include/linux/list.h:67 [inline]
 list_add_tail include/linux/list.h:100 [inline]
 kobj_kset_join lib/kobject.c:196 [inline]
 kobject_add_internal+0x18d/0xa60 lib/kobject.c:246
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:442
 device_add+0x36a/0x1d90 drivers/base/core.c:3024
 hci_conn_add_sysfs+0x97/0x1a0 net/bluetooth/hci_sysfs.c:53
 hci_conn_complete_evt net/bluetooth/hci_event.c:2643 [inline]
 hci_event_packet+0x9e3/0x7d60 net/bluetooth/hci_event.c:6153
 hci_rx_work+0x511/0xd30 net/bluetooth/hci_core.c:4971
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Modules linked in:
---[ end trace f938414eaac88f6e ]---
RIP: 0010:__list_add_valid.cold+0x26/0x3c lib/list_debug.c:29
Code: 77 cf fb fa 4c 89 e1 48 c7 c7 e0 7f 9e 89 e8 36 34 f3 ff 0f 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 20 81 9e 89 e8 1f 34 f3 ff <0f> 0b 48 89 f1 48 c7 c7 a0 80 9e 89 4c 89 e6 e8 0b 34 f3 ff 0f 0b
RSP: 0018:ffffc90001b97830 EFLAGS: 00010282
RAX: 0000000000000058 RBX: ffff88814077de00 RCX: 0000000000000000
RDX: ffff88806db94240 RSI: ffffffff815b6a45 RDI: fffff52000372ef8
RBP: ffff888073202420 R08: 0000000000000058 R09: 0000000000000000
R10: ffffffff815afbee R11: 0000000000000000 R12: ffff88814077de00
R13: ffff8880a0181298 R14: ffff888073202438 R15: ffff888073202420
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000016b9e60 CR3: 000000000b08e000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
