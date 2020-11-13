Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403E92B21D5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKMRRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:17:19 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:44828 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgKMRRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:17:19 -0500
Received: by mail-io1-f72.google.com with SMTP id p12so1072821ioj.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Agi4vIfpYIxnSc7sohSHL9s1YwIYP2n4KLNjGhcfDCM=;
        b=trPdcuSyfIpZnVpXNrNhYwsX2SbfksVeK7b61MtjF3HqIVSNGA8GxtTxxVz6AeUKI7
         Pm2JtHUeVU54f5KQ7jnL3+5vGajAmQ0I04484hv3wbEasr7mSPGCBP5I0zCDdWNkVuw3
         GJ8tK5Fn3DFLeljeOP9J4zCiZx6hlDYyIuxYaIeWU9XPQhbFF9r2l73z+vQv/wKb/XP7
         G9+vIQtD5H+a+EW/K4+snQSHLcEvBQgoi5Azzc0OWCZ+Jf2ZDjL/ph1GHCm1+1KwIIhb
         0Z/jdEMJVKumXx4miB+COQHJwvdgsR9xrZRD/nlXyMdhd+LW8vnjDDeG30JkRX7eEc/H
         eFWg==
X-Gm-Message-State: AOAM533GMGiVi6Dpu+y7HCQwLv2FcPtRB/pW2U2IMDrim7LY9cd7Zd6x
        HtTcdde83SeQx43RS/xPIqG6WpZOCoLwjjNvZZPKf0ssSWZd
X-Google-Smtp-Source: ABdhPJwI9+L9+ot7vk2bnhKDzXurwWlV5KlrNJKrob8iF9WD+egoT9JMaIH9aJUvR1UIiWh6g+/XC2sdEeDFY0hPf6XlrZxwpUSS
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:bf3:: with SMTP id d19mr618076ilu.184.1605287852034;
 Fri, 13 Nov 2020 09:17:32 -0800 (PST)
Date:   Fri, 13 Nov 2020 09:17:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ed0ef05b4003400@google.com>
Subject: memory leak in atusb_probe
From:   syzbot <syzbot+28a246747e0a465127f3@syzkaller.appspotmail.com>
To:     eli.billauer@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    af5043c8 Merge tag 'acpi-5.10-rc4' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f165e6500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f13716fa0212fd
dashboard link: https://syzkaller.appspot.com/bug?extid=28a246747e0a465127f3
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155d8dba500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153b46a1500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28a246747e0a465127f3@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888109e0af00 (size 192):
  comm "kworker/1:2", pid 3205, jiffies 4294942324 (age 8.180s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 18 af e0 09 81 88 ff ff  ................
  backtrace:
    [<0000000070ad19b0>] kmalloc include/linux/slab.h:557 [inline]
    [<0000000070ad19b0>] usb_alloc_urb+0x66/0xe0 drivers/usb/core/urb.c:74
    [<000000008781be0e>] atusb_alloc_urbs drivers/net/ieee802154/atusb.c:362 [inline]
    [<000000008781be0e>] atusb_probe+0x158/0x820 drivers/net/ieee802154/atusb.c:1038
    [<00000000cce0cf01>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<0000000020e0d57d>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<00000000e105c1d7>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<0000000027607927>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
    [<000000003813d62a>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000e9e76ec4>] __device_attach+0x122/0x250 drivers/base/dd.c:912
    [<00000000db4b9c2e>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<0000000004dae719>] device_add+0x5ac/0xc30 drivers/base/core.c:2936
    [<000000002e126243>] usb_set_configuration+0x9de/0xb90 drivers/usb/core/message.c:2159
    [<0000000076889926>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<000000004ff8d735>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<0000000020e0d57d>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<00000000e105c1d7>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<0000000027607927>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844

BUG: memory leak
unreferenced object 0xffff888109e0a300 (size 192):
  comm "kworker/1:2", pid 3205, jiffies 4294942324 (age 8.180s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 18 a3 e0 09 81 88 ff ff  ................
  backtrace:
    [<0000000070ad19b0>] kmalloc include/linux/slab.h:557 [inline]
    [<0000000070ad19b0>] usb_alloc_urb+0x66/0xe0 drivers/usb/core/urb.c:74
    [<000000008781be0e>] atusb_alloc_urbs drivers/net/ieee802154/atusb.c:362 [inline]
    [<000000008781be0e>] atusb_probe+0x158/0x820 drivers/net/ieee802154/atusb.c:1038
    [<00000000cce0cf01>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<0000000020e0d57d>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<00000000e105c1d7>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<0000000027607927>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
    [<000000003813d62a>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000e9e76ec4>] __device_attach+0x122/0x250 drivers/base/dd.c:912
    [<00000000db4b9c2e>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<0000000004dae719>] device_add+0x5ac/0xc30 drivers/base/core.c:2936
    [<000000002e126243>] usb_set_configuration+0x9de/0xb90 drivers/usb/core/message.c:2159
    [<0000000076889926>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<000000004ff8d735>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<0000000020e0d57d>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<00000000e105c1d7>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<0000000027607927>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
