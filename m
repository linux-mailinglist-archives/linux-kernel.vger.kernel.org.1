Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A52AF2A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgKKNzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:55:41 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:46401 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbgKKNz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:55:28 -0500
Received: by mail-il1-f200.google.com with SMTP id q5so1366851ilc.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=24cYXYNpqELV3yHrpqBCzuW7AoE4Q0aW3UQfbH4tOOg=;
        b=jyHg3wGB4Lo0wUKY9lR3UteKh9Sd0GFHDqSTerN4xzuUYQglNEWhxs9gGlr2eFa974
         eQaA4UK9yXX/QEPKbCxUpaubMfmCOk1rsPkdE8/5fgQ82RRC99K7PQaqdVG+6WO5BdnT
         8tDP3HdWjznNtfMMR3lc+95d+4EWOZ7uvmSTnHGwwSbWok58p6DuPTChD05QVr4yCKmR
         kut/gf4Ms9cv4fVWYGaimteJtDvv+8BZMT/EVTikNpb6TGZDU4MAehck1riV3PsPTNf0
         UL33SPhkO0YTWsZrjY/R3UuPGRyji1EV1pKSq/C/eVZHIpxPiD9i8nnpcwdD7Hi3cIsd
         ez5A==
X-Gm-Message-State: AOAM533gjC8yly8Xcy3UQc3otp4RjFY+gRjQ9sQLINjMnWccUuCx/bkh
        y/fifNPNgtz/ouE5957ES5aCoIHL1XpEz0KtoMSMErdhLIj/
X-Google-Smtp-Source: ABdhPJwAdB2bAWZvspAdNZ/fuf2NRMR72hM/N3fzHeO3gFuynOQClIvU/2qVkYoxioFuy3QidkJZiPdUJPwCkOmlfM7QmgDynJEp
MIME-Version: 1.0
X-Received: by 2002:a92:d9ca:: with SMTP id n10mr17712756ilq.21.1605102927173;
 Wed, 11 Nov 2020 05:55:27 -0800 (PST)
Date:   Wed, 11 Nov 2020 05:55:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd6be705b3d525d5@google.com>
Subject: memory leak in usb_set_configuration
From:   syzbot <syzbot+641bd6ff9b25e6d3aad1@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    407ab579 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d84062500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f13716fa0212fd
dashboard link: https://syzkaller.appspot.com/bug?extid=641bd6ff9b25e6d3aad1
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102c2094500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a8dfa8500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+641bd6ff9b25e6d3aad1@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810ed7cc00 (size 1024):
  comm "kworker/0:3", pid 4907, jiffies 4294954595 (age 14.630s)
  hex dump (first 32 bytes):
    48 92 b6 11 81 88 ff ff 48 92 b6 11 81 88 ff ff  H.......H.......
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000acb2212d>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000acb2212d>] kzalloc include/linux/slab.h:664 [inline]
    [<00000000acb2212d>] usb_set_configuration+0x18c/0xb90 drivers/usb/core/message.c:1987
    [<00000000398ef244>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<00000000c8516fd1>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<00000000eb555eca>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<0000000082b68944>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<000000000485fb4d>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
    [<00000000a0e84ad1>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<0000000017598cdd>] __device_attach+0x122/0x250 drivers/base/dd.c:912
    [<00000000201e5839>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<00000000ec5f56bf>] device_add+0x5ac/0xc30 drivers/base/core.c:2936
    [<0000000049b5ad41>] usb_new_device.cold+0x166/0x578 drivers/usb/core/hub.c:2554
    [<0000000030bc00f0>] hub_port_connect drivers/usb/core/hub.c:5222 [inline]
    [<0000000030bc00f0>] hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
    [<0000000030bc00f0>] port_event drivers/usb/core/hub.c:5508 [inline]
    [<0000000030bc00f0>] hub_event+0x144a/0x20d0 drivers/usb/core/hub.c:5590
    [<00000000e89e69ae>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<0000000063d76c23>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<00000000a311ec69>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<00000000690c42fe>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888110d0ab40 (size 32):
  comm "kworker/0:3", pid 4907, jiffies 4294954595 (age 14.630s)
  hex dump (first 32 bytes):
    31 2d 31 3a 30 2e 30 00 00 00 00 00 00 00 00 00  1-1:0.0.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000faadb384>] kvasprintf+0x6c/0xf0 lib/kasprintf.c:25
    [<00000000ae06ab4d>] kvasprintf_const+0x58/0x110 lib/kasprintf.c:49
    [<0000000098542b5a>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<00000000d0bb751d>] dev_set_name+0x63/0x90 drivers/base/core.c:2722
    [<00000000b7617caa>] usb_set_configuration+0x6be/0xb90 drivers/usb/core/message.c:2094
    [<00000000398ef244>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<00000000c8516fd1>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<00000000eb555eca>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<0000000082b68944>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<000000000485fb4d>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
    [<00000000a0e84ad1>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<0000000017598cdd>] __device_attach+0x122/0x250 drivers/base/dd.c:912
    [<00000000201e5839>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<00000000ec5f56bf>] device_add+0x5ac/0xc30 drivers/base/core.c:2936
    [<0000000049b5ad41>] usb_new_device.cold+0x166/0x578 drivers/usb/core/hub.c:2554
    [<0000000030bc00f0>] hub_port_connect drivers/usb/core/hub.c:5222 [inline]
    [<0000000030bc00f0>] hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
    [<0000000030bc00f0>] port_event drivers/usb/core/hub.c:5508 [inline]
    [<0000000030bc00f0>] hub_event+0x144a/0x20d0 drivers/usb/core/hub.c:5590

BUG: memory leak
unreferenced object 0xffff88811182b900 (size 256):
  comm "kworker/0:3", pid 4907, jiffies 4294954600 (age 14.580s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 b9 82 11 81 88 ff ff  ................
    08 b9 82 11 81 88 ff ff 40 44 58 82 ff ff ff ff  ........@DX.....
  backtrace:
    [<000000000b81baae>] kmalloc include/linux/slab.h:552 [inline]
    [<000000000b81baae>] kzalloc include/linux/slab.h:664 [inline]
    [<000000000b81baae>] device_private_init drivers/base/core.c:2778 [inline]
    [<000000000b81baae>] device_add+0x7e8/0xc30 drivers/base/core.c:2828
    [<000000002061ca5e>] usb_set_configuration+0x9de/0xb90 drivers/usb/core/message.c:2159
    [<00000000398ef244>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<00000000c8516fd1>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<00000000eb555eca>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<0000000082b68944>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<000000000485fb4d>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
    [<00000000a0e84ad1>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<0000000017598cdd>] __device_attach+0x122/0x250 drivers/base/dd.c:912
    [<00000000201e5839>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<00000000ec5f56bf>] device_add+0x5ac/0xc30 drivers/base/core.c:2936
    [<0000000049b5ad41>] usb_new_device.cold+0x166/0x578 drivers/usb/core/hub.c:2554
    [<0000000030bc00f0>] hub_port_connect drivers/usb/core/hub.c:5222 [inline]
    [<0000000030bc00f0>] hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
    [<0000000030bc00f0>] port_event drivers/usb/core/hub.c:5508 [inline]
    [<0000000030bc00f0>] hub_event+0x144a/0x20d0 drivers/usb/core/hub.c:5590
    [<00000000e89e69ae>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<0000000063d76c23>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<00000000a311ec69>] kthread+0x178/0x1b0 kernel/kthread.c:292



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
