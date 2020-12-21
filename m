Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63792DF80C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 04:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgLUDew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 22:34:52 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:48721 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgLUDew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 22:34:52 -0500
Received: by mail-il1-f199.google.com with SMTP id f4so8248191ilu.15
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 19:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FlEgzUD3QYmF41PuLCVzjuZhfq6vSLPvJuuSLKlwXN0=;
        b=d/LUEtZe91R68yLuD8NXalQkwPFr3JtHxHevCMwwp/DJ9BQPm6ss6rqTikKG/39oLs
         oJAJzw5FL0Q+LMZibmupY3u61PqvjW1IcQtQ00BKH6Ww4yrFX1dOTDmoyON1YNMs8cG2
         Wt2DllSUFU/eZF7PRd9gizUrDTPokieTK/sh3EdOdkZi1oVUXCTDWo0Qi1az/CXCVAZc
         ZST6BW0K4WK5EB3c5228g1DIeiGztJFsqUILuUpX7TgTFu3ExaHjY3etP1mCdkoul4Pl
         /ZAssz5hqwKg9KSKyPXcFPQ0AUa5Cro8VskYgaIAM9JyD7aiuxwgerR5tIKlbPEoF8ll
         8qJg==
X-Gm-Message-State: AOAM533jUXnWVQOSYkJF/QZ4iOEz77IBlKuXDckpysWlb8Ksv+ZJG+fb
        7IZ+ilY3MNf+kph6fYkFARpNLXYOcel4GN1yMSKe2hbTv/kv
X-Google-Smtp-Source: ABdhPJw0Yac3wN6O5CdvHOK+e+SgSb1V6BAzy9fL5+lWZuExRbaMuwzfZFx94DzAFs+2eWwRUa6bM9Wbdkjm+SlBa2tw+c01eSU9
MIME-Version: 1.0
X-Received: by 2002:a5d:928d:: with SMTP id s13mr12922242iom.47.1608521650203;
 Sun, 20 Dec 2020 19:34:10 -0800 (PST)
Date:   Sun, 20 Dec 2020 19:34:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092f61e05b6f1215b@google.com>
Subject: memory leak in r8712_init_recv_priv
From:   syzbot <syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    467f8165 Merge tag 'close-range-cloexec-unshare-v5.11' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142b5745500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37c889fb8b2761af
dashboard link: https://syzkaller.appspot.com/bug?extid=1c46f3771695bccbdb3a
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1265cb37500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1763527b500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff88810ecc26c0 (size 192):
  comm "kworker/1:1", pid 35, jiffies 4294942461 (age 18.010s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 d8 26 cc 0e 81 88 ff ff  .........&......
  backtrace:
    [<000000005aecb941>] kmalloc include/linux/slab.h:557 [inline]
    [<000000005aecb941>] usb_alloc_urb+0x66/0xe0 drivers/usb/core/urb.c:74
    [<000000007c4331ea>] r8712_os_recvbuf_resource_alloc+0x1b/0x80 drivers/staging/rtl8712/recv_linux.c:46
    [<0000000026fac6b7>] r8712_init_recv_priv+0x96/0x210 drivers/staging/rtl8712/rtl8712_recv.c:54
    [<000000004dbac0de>] _r8712_init_recv_priv+0x134/0x150 drivers/staging/rtl8712/rtl871x_recv.c:78
    [<000000009f37c02e>] r8712_init_drv_sw+0xa0/0x1d0 drivers/staging/rtl8712/os_intfs.c:312
    [<00000000439d06d7>] r871xu_drv_init.cold+0x104/0x7d1 drivers/staging/rtl8712/usb_intf.c:391
    [<00000000a5c43c27>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<00000000106f93f1>] really_probe+0x159/0x480 drivers/base/dd.c:561
    [<00000000856556bd>] driver_probe_device+0x84/0x100 drivers/base/dd.c:745
    [<00000000789974b2>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:851
    [<000000003b6b23b1>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000d916cd73>] __device_attach+0x122/0x250 drivers/base/dd.c:919
    [<000000000aa7621e>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<00000000c2fd5fd8>] device_add+0x5be/0xc30 drivers/base/core.c:3091
    [<00000000d7a5749a>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2164
    [<00000000197a0613>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238

BUG: memory leak
unreferenced object 0xffff88810ecc2600 (size 192):
  comm "kworker/1:1", pid 35, jiffies 4294942461 (age 18.010s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 18 26 cc 0e 81 88 ff ff  .........&......
  backtrace:
    [<000000005aecb941>] kmalloc include/linux/slab.h:557 [inline]
    [<000000005aecb941>] usb_alloc_urb+0x66/0xe0 drivers/usb/core/urb.c:74
    [<000000007c4331ea>] r8712_os_recvbuf_resource_alloc+0x1b/0x80 drivers/staging/rtl8712/recv_linux.c:46
    [<0000000026fac6b7>] r8712_init_recv_priv+0x96/0x210 drivers/staging/rtl8712/rtl8712_recv.c:54
    [<000000004dbac0de>] _r8712_init_recv_priv+0x134/0x150 drivers/staging/rtl8712/rtl871x_recv.c:78
    [<000000009f37c02e>] r8712_init_drv_sw+0xa0/0x1d0 drivers/staging/rtl8712/os_intfs.c:312
    [<00000000439d06d7>] r871xu_drv_init.cold+0x104/0x7d1 drivers/staging/rtl8712/usb_intf.c:391
    [<00000000a5c43c27>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<00000000106f93f1>] really_probe+0x159/0x480 drivers/base/dd.c:561
    [<00000000856556bd>] driver_probe_device+0x84/0x100 drivers/base/dd.c:745
    [<00000000789974b2>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:851
    [<000000003b6b23b1>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000d916cd73>] __device_attach+0x122/0x250 drivers/base/dd.c:919
    [<000000000aa7621e>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<00000000c2fd5fd8>] device_add+0x5be/0xc30 drivers/base/core.c:3091
    [<00000000d7a5749a>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2164
    [<00000000197a0613>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238

BUG: memory leak
unreferenced object 0xffff88810ecc2540 (size 192):
  comm "kworker/1:1", pid 35, jiffies 4294942461 (age 18.010s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 58 25 cc 0e 81 88 ff ff  ........X%......
  backtrace:
    [<000000005aecb941>] kmalloc include/linux/slab.h:557 [inline]
    [<000000005aecb941>] usb_alloc_urb+0x66/0xe0 drivers/usb/core/urb.c:74
    [<000000007c4331ea>] r8712_os_recvbuf_resource_alloc+0x1b/0x80 drivers/staging/rtl8712/recv_linux.c:46
    [<0000000026fac6b7>] r8712_init_recv_priv+0x96/0x210 drivers/staging/rtl8712/rtl8712_recv.c:54
    [<000000004dbac0de>] _r8712_init_recv_priv+0x134/0x150 drivers/staging/rtl8712/rtl871x_recv.c:78
    [<000000009f37c02e>] r8712_init_drv_sw+0xa0/0x1d0 drivers/staging/rtl8712/os_intfs.c:312
    [<00000000439d06d7>] r871xu_drv_init.cold+0x104/0x7d1 drivers/staging/rtl8712/usb_intf.c:391
    [<00000000a5c43c27>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<00000000106f93f1>] really_probe+0x159/0x480 drivers/base/dd.c:561
    [<00000000856556bd>] driver_probe_device+0x84/0x100 drivers/base/dd.c:745
    [<00000000789974b2>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:851
    [<000000003b6b23b1>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000d916cd73>] __device_attach+0x122/0x250 drivers/base/dd.c:919
    [<000000000aa7621e>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<00000000c2fd5fd8>] device_add+0x5be/0xc30 drivers/base/core.c:3091
    [<00000000d7a5749a>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2164
    [<00000000197a0613>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
