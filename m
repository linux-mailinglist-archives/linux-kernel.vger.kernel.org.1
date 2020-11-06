Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989F62A9656
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbgKFMnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:43:19 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:49725 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgKFMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:43:18 -0500
Received: by mail-io1-f69.google.com with SMTP id c4so791765ioi.16
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 04:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=N9gPfDiDQ+wXb/h/9ggtILEvZvmTsvBOZrs9B66eao0=;
        b=aqkWJd+3oqdI3LXJjdBgaaX+MN3JBoqbURr9V2wo4DZJ1+ZiwxZAAVbu1M/hzXRovH
         UqaTvdGctV3IbV4uq3j/rZX4/nYkNg+HdXmrM6w2byqhW5r8MdNVdUTqGlP9eue9a/85
         /KMBPl6G1JzaRMreX3esf7hHvih9exWEdqSX7uuDw+uUOcKlg74EUR/O9jaPjcF8Qo2l
         xUkyBLruH2zKltX/fVrJfgqcYbZFef/wMrvQc9Gb30UFdHyqgiF42NP82ExkydHhmn9B
         lGZNCCWmYOl989nI3Dt3FjFYabGAEH962DyQywWIy3vIs3zRgW64aLPngsU3T1Z2/RAk
         t8vA==
X-Gm-Message-State: AOAM530dOcb5lrcI/zpRH4pY6UkR0TBRPDH9a6pHbpsEfmeM9egl8bEB
        APyYVtLXTiFap91fQF6OYqdH5C7FZfKCYl1BrQg1hrIdUCOH
X-Google-Smtp-Source: ABdhPJyvy/jAlB6UzdWdEQpVaCfyP4Pxy5gE6mHM8iJVPVCMPTVEcLNjNPDAUeJZt8XbIZlf9FUP1HQps6CtIAuFi/2m75IjH81a
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4a9:: with SMTP id e9mr1163472ils.24.1604666597516;
 Fri, 06 Nov 2020 04:43:17 -0800 (PST)
Date:   Fri, 06 Nov 2020 04:43:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000872b5405b36f8e31@google.com>
Subject: WARNING in input_register_device
From:   syzbot <syzbot+92340f7b2b4789907fdb@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9e39aef3 usb: misc: brcmstb-usb-pinmap: Make sync_all_pins..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=145ffa8a500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a05f5efbb00b1465
dashboard link: https://syzkaller.appspot.com/bug?extid=92340f7b2b4789907fdb
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172ae7a8500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b24746500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92340f7b2b4789907fdb@syzkaller.appspotmail.com

microsoft 0003:045E:07DA.0001: unknown main item tag 0x0
HID 045e:07da: Invalid code 65791 type 1
------------[ cut here ]------------
init_uevent_argv: buffer size too small
WARNING: CPU: 0 PID: 5 at lib/kobject_uevent.c:259 init_uevent_argv lib/kobject_uevent.c:259 [inline]
WARNING: CPU: 0 PID: 5 at lib/kobject_uevent.c:259 kobject_uevent_env+0x1640/0x1680 lib/kobject_uevent.c:608
Modules linked in:
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.10.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:init_uevent_argv lib/kobject_uevent.c:259 [inline]
RIP: 0010:kobject_uevent_env+0x1640/0x1680 lib/kobject_uevent.c:608
Code: 87 e8 24 af fe ff e9 cf f8 ff ff 48 8b 3c 24 e8 06 33 68 ff e9 a9 f8 ff ff e8 cc 9e 3c ff 48 c7 c7 e0 68 00 86 e8 59 b9 71 03 <0f> 0b 41 bf f4 ff ff ff e9 51 ec ff ff 4c 89 ff e8 5b 32 68 ff e9
RSP: 0018:ffffc9000005e8e0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
RDX: ffff88810022e500 RSI: ffffffff8128fe63 RDI: fffff5200000bd0e
RBP: 00000000000007fb R08: 0000000000000001 R09: ffff8881f6a1febb
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000005
R13: 00000000000007fb R14: 0000000000000005 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881f6a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006d0090 CR3: 0000000103ed4000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 device_add+0xb47/0x1ce0 drivers/base/core.c:2919
 input_register_device+0x73a/0xce0 drivers/input/input.c:2212
 hidinput_connect+0x5056/0x9d50 drivers/hid/hid-input.c:1949
 hid_connect+0x958/0xbc0 drivers/hid/hid-core.c:1949
 hid_hw_start drivers/hid/hid-core.c:2053 [inline]
 hid_hw_start+0xa2/0x130 drivers/hid/hid-core.c:2044
 ms_probe+0x159/0x4b0 drivers/hid/hid-microsoft.c:391
 hid_device_probe+0x2bd/0x3f0 drivers/hid/hid-core.c:2281
 really_probe+0x291/0xde0 drivers/base/dd.c:554
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:738
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:844
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:912
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbb2/0x1ce0 drivers/base/core.c:2938
 hid_add_device+0x344/0x9d0 drivers/hid/hid-core.c:2437
 usbhid_probe+0xaae/0xfc0 drivers/hid/usbhid/hid-core.c:1407
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 really_probe+0x291/0xde0 drivers/base/dd.c:554
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:738
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:844
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:912
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbb2/0x1ce0 drivers/base/core.c:2938
 usb_set_configuration+0x113c/0x1910 drivers/usb/core/message.c:2168
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 really_probe+0x291/0xde0 drivers/base/dd.c:554
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:738
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:844
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:912
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbb2/0x1ce0 drivers/base/core.c:2938
 usb_new_device.cold+0x71d/0xfe9 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x2348/0x42d0 drivers/usb/core/hub.c:5591
 process_one_work+0x933/0x1520 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
