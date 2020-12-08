Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058D92D2A04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 12:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgLHLx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 06:53:57 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:34863 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729214AbgLHLx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:53:57 -0500
Received: by mail-il1-f198.google.com with SMTP id l11so8481631ilq.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 03:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5lIivfIegrOSwEr6lH8WZABgvU+Z1wH05JIi4bOtavM=;
        b=ORN3u0dK2GszIWDBStYgW5z6vUbJbJUqtEnD4LKEZ5z07X43ckiVe1EnOgR1DoWZKE
         +gGRkiN/es3Bd/EjFC7h5MWWwokzDktPl3dEhIJtVwdcssC/2IwkSVnzyR+hYSYU8LCt
         u1hujha1LyAh+YTsAM5j8BKFL5Ivk7UqbDFKZ7ZsBDTJ9K8Osu576l7jIB5H8Ka2ZSZn
         MJSaq88iR85VpdXY+TRt5+aZmSJm3347BFvjT6UC6VDEy6jMgUkFjXRadK8KgLM6lQkp
         MuflLj3juR5caq2+yyv6GmUK0wkACzVarIzsEQJ76d9ZNo2M1pfgAUKvPs0l8UCEkogq
         Tv0g==
X-Gm-Message-State: AOAM531lfxQvkiZ8aGouWH1Xji2pfrXzcbEfXzi+LH1n1XyXZ2iSUDnt
        pC/Cm3W+EbeOsKzjc053HcuUV2rv+vKZpHb6zJy4KbJ/kSQ7
X-Google-Smtp-Source: ABdhPJxHNbgZIU2Vh7UiPHS5oMJTw0UHCaSW5jJh4mCgIbTxaoIicxGAwcK70UvhNshe8AU3AZ+zr7iIeL4g5q3sANZcDO5EzuF2
MIME-Version: 1.0
X-Received: by 2002:a5e:9612:: with SMTP id a18mr2370150ioq.13.1607428396041;
 Tue, 08 Dec 2020 03:53:16 -0800 (PST)
Date:   Tue, 08 Dec 2020 03:53:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c4f0f05b5f29682@google.com>
Subject: general protection fault in tower_disconnect
From:   syzbot <syzbot+9be25235b7a69b24d117@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        legousb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, starblue@users.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    08a02f95 USB: add RESET_RESUME quirk for Snapscan 1212
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1435927b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d24ee9ecd7ce968e
dashboard link: https://syzkaller.appspot.com/bug?extid=9be25235b7a69b24d117
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15145f07500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b99413500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9be25235b7a69b24d117@syzkaller.appspotmail.com

usb 1-1: USB disconnect, device number 2
general protection fault, probably for non-canonical address 0xdffffc0000000013: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000098-0x000000000000009f]
CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:tower_disconnect+0x53/0x360 drivers/usb/misc/legousbtower.c:848
Code: 03 80 3c 02 00 0f 85 15 03 00 00 48 8b ab a8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bd 98 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 7b 02 00 00 48 c7 c6 40 07 bb 87 48
RSP: 0018:ffffc9000007f7c0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888117ec0000 RCX: ffffffff8381f807
RDX: 0000000000000013 RSI: ffffffff83bab792 RDI: 0000000000000098
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff898cc4ef
R10: 0000000000000002 R11: 0000000000000000 R12: ffff888117ec0090
R13: ffff888117ec0078 R14: ffff888117ec0030 R15: ffff888117ec0098
FS:  0000000000000000(0000) GS:ffff8881f6a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f557af47550 CR3: 00000001090f3000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:458
 __device_release_driver+0x3bd/0x6f0 drivers/base/dd.c:1154
 device_release_driver_internal drivers/base/dd.c:1185 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1208
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x502/0xec0 drivers/base/core.c:3115
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1413
 usb_disconnect.cold+0x27d/0x780 drivers/usb/core/hub.c:2218
 hub_port_connect drivers/usb/core/hub.c:5074 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x1c8a/0x42d0 drivers/usb/core/hub.c:5591
 process_one_work+0x933/0x1520 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Modules linked in:
---[ end trace 5aeb1d199be5d5f2 ]---
RIP: 0010:tower_disconnect+0x53/0x360 drivers/usb/misc/legousbtower.c:848
Code: 03 80 3c 02 00 0f 85 15 03 00 00 48 8b ab a8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bd 98 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 7b 02 00 00 48 c7 c6 40 07 bb 87 48
RSP: 0018:ffffc9000007f7c0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888117ec0000 RCX: ffffffff8381f807
RDX: 0000000000000013 RSI: ffffffff83bab792 RDI: 0000000000000098
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff898cc4ef
R10: 0000000000000002 R11: 0000000000000000 R12: ffff888117ec0090
R13: ffff888117ec0078 R14: ffff888117ec0030 R15: ffff888117ec0098
FS:  0000000000000000(0000) GS:ffff8881f6a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f557af47550 CR3: 00000001090f3000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
