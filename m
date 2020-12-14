Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E0B2D94C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439643AbgLNJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:14:07 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:40363 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439621AbgLNJNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:13:52 -0500
Received: by mail-il1-f198.google.com with SMTP id g1so7332184ilq.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Xwq+h39/FNGcyxtgEq8iwiPV6bbaAoQGXtrZlx1lkEA=;
        b=qE4ulDYqRAMQJoQXbV7PulR8/LgFtE7Fku4gmz1P5AgGl2hnnbxfYyKGXx9d/HILPt
         XUoH7AqcoW9HHh7F79TAgaPLLhpzWF9fs5FaeUiVqUWsrpt4OEEeDFaIxsdFVb8kFhSd
         y2scYt4L6Y5ujHiBMFL3SoOOVZsffvefa4kzcCnOg3SSYf/dZNmrdL/2hkQlT1t0frku
         fCdpctPgdITO/j0nmjd9HjslKhTo4lDhnL0F5x81Ib1KzFrVvBphuwqLulF9EKMK9j/K
         2cgjyoiu6AA54811HTM2dsjZyPQZAorUcpUjgZo80/hlbW4YZ4kBuXlRayCwxBMrnyUC
         Pvgg==
X-Gm-Message-State: AOAM532YaNUEpXrXpneCF//nlaW803zwRSDbxMCldtDPozWWgxtNozTl
        VmwMlGEV+RV6kvU/AxfVGgDwfudwUjUbYmymheVCTf/+8VBJ
X-Google-Smtp-Source: ABdhPJw8ZFAjwxvmwvqPi0SPPyyv9Z+QTUIXnzL62HLv85D0ycwzfSH4pN+2ewuQ8JhjdX086viZYubBgKBUbuHzI2tIbDYzaqrl
MIME-Version: 1.0
X-Received: by 2002:a92:998c:: with SMTP id t12mr10118400ilk.140.1607937191228;
 Mon, 14 Dec 2020 01:13:11 -0800 (PST)
Date:   Mon, 14 Dec 2020 01:13:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001aba8205b6690d78@google.com>
Subject: memory leak in dlfb_usb_probe
From:   syzbot <syzbot+c9e365d7f450e8aa615d@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, bernie@plugable.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a68a0262 mm/madvise: remove racy mm ownership check
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1538046b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4305fa9ea70c7a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=c9e365d7f450e8aa615d
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1779cc13500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1173d00f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9e365d7f450e8aa615d@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810adde100 (size 32):
  comm "kworker/1:0", pid 17, jiffies 4294947788 (age 19.520s)
  hex dump (first 32 bytes):
    10 30 c3 0d 81 88 ff ff c0 fa 63 12 81 88 ff ff  .0........c.....
    00 30 c3 0d 81 88 ff ff 80 d1 3a 08 81 88 ff ff  .0........:.....
  backtrace:
    [<0000000019512953>] kmalloc include/linux/slab.h:552 [inline]
    [<0000000019512953>] kzalloc include/linux/slab.h:664 [inline]
    [<0000000019512953>] dlfb_alloc_urb_list drivers/video/fbdev/udlfb.c:1892 [inline]
    [<0000000019512953>] dlfb_usb_probe.cold+0x289/0x988 drivers/video/fbdev/udlfb.c:1704
    [<0000000072160152>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<00000000a8d6726f>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<00000000c3ce4b0e>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<00000000e942e01c>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
    [<00000000de0a5a5c>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000463fbcb4>] __device_attach+0x122/0x250 drivers/base/dd.c:912
    [<00000000b881a711>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<00000000364bbda5>] device_add+0x5ac/0xc30 drivers/base/core.c:2936
    [<00000000eecca418>] usb_set_configuration+0x9de/0xb90 drivers/usb/core/message.c:2159
    [<00000000edfeca2d>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<000000001830872b>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<00000000a8d6726f>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<00000000c3ce4b0e>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<00000000e942e01c>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
    [<00000000de0a5a5c>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431

BUG: memory leak
unreferenced object 0xffff8881083ad180 (size 192):
  comm "kworker/1:0", pid 17, jiffies 4294947788 (age 19.520s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 98 d1 3a 08 81 88 ff ff  ..........:.....
  backtrace:
    [<00000000a7783a78>] kmalloc include/linux/slab.h:557 [inline]
    [<00000000a7783a78>] usb_alloc_urb+0x66/0xe0 drivers/usb/core/urb.c:74
    [<0000000082822843>] dlfb_alloc_urb_list drivers/video/fbdev/udlfb.c:1897 [inline]
    [<0000000082822843>] dlfb_usb_probe.cold+0x2aa/0x988 drivers/video/fbdev/udlfb.c:1704
    [<0000000072160152>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<00000000a8d6726f>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<00000000c3ce4b0e>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<00000000e942e01c>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
    [<00000000de0a5a5c>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000463fbcb4>] __device_attach+0x122/0x250 drivers/base/dd.c:912
    [<00000000b881a711>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<00000000364bbda5>] device_add+0x5ac/0xc30 drivers/base/core.c:2936
    [<00000000eecca418>] usb_set_configuration+0x9de/0xb90 drivers/usb/core/message.c:2159
    [<00000000edfeca2d>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<000000001830872b>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<00000000a8d6726f>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<00000000c3ce4b0e>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<00000000e942e01c>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844

BUG: memory leak
unreferenced object 0xffff88811263fb20 (size 32):
  comm "kworker/1:0", pid 17, jiffies 4294947788 (age 19.530s)
  hex dump (first 32 bytes):
    00 fb 63 12 81 88 ff ff 10 30 c3 0d 81 88 ff ff  ..c......0......
    00 30 c3 0d 81 88 ff ff c0 53 c8 0b 81 88 ff ff  .0.......S......
  backtrace:
    [<0000000019512953>] kmalloc include/linux/slab.h:552 [inline]
    [<0000000019512953>] kzalloc include/linux/slab.h:664 [inline]
    [<0000000019512953>] dlfb_alloc_urb_list drivers/video/fbdev/udlfb.c:1892 [inline]
    [<0000000019512953>] dlfb_usb_probe.cold+0x289/0x988 drivers/video/fbdev/udlfb.c:1704
    [<0000000072160152>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<00000000a8d6726f>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<00000000c3ce4b0e>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<00000000e942e01c>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
    [<00000000de0a5a5c>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000463fbcb4>] __device_attach+0x122/0x250 drivers/base/dd.c:912
    [<00000000b881a711>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<00000000364bbda5>] device_add+0x5ac/0xc30 drivers/base/core.c:2936
    [<00000000eecca418>] usb_set_configuration+0x9de/0xb90 drivers/usb/core/message.c:2159
    [<00000000edfeca2d>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<000000001830872b>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<00000000a8d6726f>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<00000000c3ce4b0e>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<00000000e942e01c>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
    [<00000000de0a5a5c>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
