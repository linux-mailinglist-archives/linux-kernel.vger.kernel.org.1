Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8705A2DFA33
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 09:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgLUIyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 03:54:51 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:33331 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgLUIyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 03:54:51 -0500
Received: by mail-io1-f70.google.com with SMTP id t23so5082719ioh.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2ynIvZyu/Mq8I0y4+W/1wGFuqsNw7/hbTUXKut/HCW8=;
        b=Ax4x3PbDwu1575x7y9Tu5trZMXJUnGCr3vtI9se6SjXNQr99QlyvxgNpttAYu0qATT
         l/V5k+Iq72YbyUFyBGXujkElh73/pR/cjFqrh0lJ8P+7AFedPuUJt8DkZGp5jc2sjL8S
         8OfTvaTkzZ75spvRCtHQcK3yW2GS9WM3g4M92Zsc9zhk2tShNYNFJ99OGw2y+Xr8TVPT
         ikqbSzIUoqAiMy1QugMyjzzd++PU17qsWI/yOZsP4JAhImhhoIBBygOU37dX0usy4WlC
         q0ZjXiutwlDoh7wRHLs45aV6NkNdkwgl5N5M9g/SQq5X+ycY1SR2kXUO6P8aQb+0a+u+
         Ku3Q==
X-Gm-Message-State: AOAM532ZE0cPR9/hUs9XR2ifg1DJ6SOtotm1lD7O1vgWSONszdmhLxPr
        9hDye83pYC6D8Po07gvSzUtTz+rEAsUecbLZcIKOyy9JKggp
X-Google-Smtp-Source: ABdhPJzar/byIQ4ZD44/83nGoCtUGavdwhNG9csm/7hV+2D2XX77WIBljGPE7hr4xmu6ih9ykLZDa5bZJHvGhUoR8GDfS0/68JYb
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e45:: with SMTP id l5mr15361557ilk.294.1608540849804;
 Mon, 21 Dec 2020 00:54:09 -0800 (PST)
Date:   Mon, 21 Dec 2020 00:54:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f599c005b6f59913@google.com>
Subject: memory leak in mcba_usb_probe
From:   syzbot <syzbot+57281c762a3922e14dfe@syzkaller.appspotmail.com>
To:     a.darwish@linutronix.de, bigeasy@linutronix.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    467f8165 Merge tag 'close-range-cloexec-unshare-v5.11' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15933e0f500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37c889fb8b2761af
dashboard link: https://syzkaller.appspot.com/bug?extid=57281c762a3922e14dfe
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fe2b9b500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bd2287500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57281c762a3922e14dfe@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811101c080 (size 64):
  comm "kworker/0:2", pid 56, jiffies 4294942309 (age 8.240s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000e42b7c1c>] kmalloc include/linux/slab.h:557 [inline]
    [<00000000e42b7c1c>] hcd_buffer_alloc+0x149/0x190 drivers/usb/core/buffer.c:134
    [<0000000042899d1a>] usb_alloc_coherent+0x42/0x60 drivers/usb/core/usb.c:897
    [<00000000abbb04b6>] mcba_usb_start drivers/net/can/usb/mcba_usb.c:644 [inline]
    [<00000000abbb04b6>] mcba_usb_probe+0x27b/0x430 drivers/net/can/usb/mcba_usb.c:846
    [<00000000b5e48b67>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<00000000a0416f71>] really_probe+0x159/0x480 drivers/base/dd.c:561
    [<00000000cce96f4d>] driver_probe_device+0x84/0x100 drivers/base/dd.c:745
    [<00000000b0116c0e>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:851
    [<00000000da4bf16e>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000e826f962>] __device_attach+0x122/0x250 drivers/base/dd.c:919
    [<00000000fb35d32b>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<0000000083f168a1>] device_add+0x5be/0xc30 drivers/base/core.c:3091
    [<000000002b4245b1>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2164
    [<00000000fa502fa0>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<000000004e1ab3a9>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<00000000a0416f71>] really_probe+0x159/0x480 drivers/base/dd.c:561
    [<00000000cce96f4d>] driver_probe_device+0x84/0x100 drivers/base/dd.c:745

BUG: memory leak
unreferenced object 0xffff88811101c0c0 (size 64):
  comm "kworker/0:2", pid 56, jiffies 4294942309 (age 8.240s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000e42b7c1c>] kmalloc include/linux/slab.h:557 [inline]
    [<00000000e42b7c1c>] hcd_buffer_alloc+0x149/0x190 drivers/usb/core/buffer.c:134
    [<0000000042899d1a>] usb_alloc_coherent+0x42/0x60 drivers/usb/core/usb.c:897
    [<00000000abbb04b6>] mcba_usb_start drivers/net/can/usb/mcba_usb.c:644 [inline]
    [<00000000abbb04b6>] mcba_usb_probe+0x27b/0x430 drivers/net/can/usb/mcba_usb.c:846
    [<00000000b5e48b67>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<00000000a0416f71>] really_probe+0x159/0x480 drivers/base/dd.c:561
    [<00000000cce96f4d>] driver_probe_device+0x84/0x100 drivers/base/dd.c:745
    [<00000000b0116c0e>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:851
    [<00000000da4bf16e>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000e826f962>] __device_attach+0x122/0x250 drivers/base/dd.c:919
    [<00000000fb35d32b>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<0000000083f168a1>] device_add+0x5be/0xc30 drivers/base/core.c:3091
    [<000000002b4245b1>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2164
    [<00000000fa502fa0>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<000000004e1ab3a9>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<00000000a0416f71>] really_probe+0x159/0x480 drivers/base/dd.c:561
    [<00000000cce96f4d>] driver_probe_device+0x84/0x100 drivers/base/dd.c:745

BUG: memory leak
unreferenced object 0xffff88811101c100 (size 64):
  comm "kworker/0:2", pid 56, jiffies 4294942309 (age 8.240s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000e42b7c1c>] kmalloc include/linux/slab.h:557 [inline]
    [<00000000e42b7c1c>] hcd_buffer_alloc+0x149/0x190 drivers/usb/core/buffer.c:134
    [<0000000042899d1a>] usb_alloc_coherent+0x42/0x60 drivers/usb/core/usb.c:897
    [<00000000abbb04b6>] mcba_usb_start drivers/net/can/usb/mcba_usb.c:644 [inline]
    [<00000000abbb04b6>] mcba_usb_probe+0x27b/0x430 drivers/net/can/usb/mcba_usb.c:846
    [<00000000b5e48b67>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<00000000a0416f71>] really_probe+0x159/0x480 drivers/base/dd.c:561
    [<00000000cce96f4d>] driver_probe_device+0x84/0x100 drivers/base/dd.c:745
    [<00000000b0116c0e>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:851
    [<00000000da4bf16e>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000e826f962>] __device_attach+0x122/0x250 drivers/base/dd.c:919
    [<00000000fb35d32b>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<0000000083f168a1>] device_add+0x5be/0xc30 drivers/base/core.c:3091
    [<000000002b4245b1>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2164
    [<00000000fa502fa0>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<000000004e1ab3a9>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<00000000a0416f71>] really_probe+0x159/0x480 drivers/base/dd.c:561
    [<00000000cce96f4d>] driver_probe_device+0x84/0x100 drivers/base/dd.c:745



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
