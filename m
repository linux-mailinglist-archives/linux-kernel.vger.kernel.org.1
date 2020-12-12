Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324E02D856E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 10:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390468AbgLLJyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 04:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407215AbgLLJyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 04:54:18 -0500
Received: from mail-io1-xd45.google.com (mail-io1-xd45.google.com [IPv6:2607:f8b0:4864:20::d45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1613EC0611E4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 01:27:42 -0800 (PST)
Received: by mail-io1-xd45.google.com with SMTP id b136so8288385iof.19
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 01:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mVCvsvjilIEUCYb64Taz8MA771Z+xRzYLk2/ruWIw4U=;
        b=cSdKlDO4R7XDoA/u8lJG5ve3emXhJjH+XNcKACRCfuc3DYvR/ZHnhkTGcQg0mKVv1f
         J8eK2Kl6KjkNWY4dxRSSR3+FW4PnfT7LI6SN2jmbT2oS9A0nqwF747bvJkqck5VaEwug
         R99Y5QwDmPVm+ghNyRohC5UMFlCn2FO7tlOORh1J1za37BjoWqYdDHY70nyHACn45m+8
         MMoyX6wlE60rX6pIDYzTbrK56iBlBA2ZeLquCUPYQP7S2le0A+MymJL1mb6DwflXrAyu
         h1jeFdOMnam/VHlgARTxc6pdZP3Iwa2GbWWB6i1JgNY64OK+mV3MweiOXMBWbxxQnqff
         J4SQ==
X-Gm-Message-State: AOAM530Pw0eDCWhe4Y+Q4Iird3BBQ/ID3QQc/Pd9322mJxiamG8PhEDq
        Z8EQwauIQR2r3+YFcTxjNx/Tg4REfdGzry1i1wa/UQtJ1iqm
X-Google-Smtp-Source: ABdhPJzp99wGmZYNcdaiMXlFfMlfFuG5EwK9ZN91IlDbz5OlMylrKOOtzwt7OCB6EvNaOVTsbulRXD76YWKOMOhqK1dXFF5s857S
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:128c:: with SMTP id y12mr21476112ilq.179.1607758990678;
 Fri, 11 Dec 2020 23:43:10 -0800 (PST)
Date:   Fri, 11 Dec 2020 23:43:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086229005b63f8fc1@google.com>
Subject: KMSAN: kernel-usb-infoleak in usbnet_write_cmd (2)
From:   syzbot <syzbot+11567dab5754ad6ee82a@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, glider@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    73d62e81 kmsan: random: prevent boot-time reports in _mix_..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13ff7703500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eef728deea880383
dashboard link: https://syzkaller.appspot.com/bug?extid=11567dab5754ad6ee82a
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11567dab5754ad6ee82a@syzkaller.appspotmail.com

smsc75xx 5-1:1.0 (unnamed net_device) (uninitialized): Error reading E2P_CMD
=====================================================
BUG: KMSAN: kernel-usb-infoleak in kmsan_handle_urb+0x28/0x40 mm/kmsan/kmsan_hooks.c:303
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.10.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 kmsan_internal_check_memory+0x484/0x520 mm/kmsan/kmsan.c:437
 kmsan_handle_urb+0x28/0x40 mm/kmsan/kmsan_hooks.c:303
 usb_submit_urb+0x87f/0x2530 drivers/usb/core/urb.c:421
 usb_start_wait_urb+0x155/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x495/0x7d0 drivers/usb/core/message.c:153
 __usbnet_write_cmd drivers/net/usb/usbnet.c:2010 [inline]
 usbnet_write_cmd+0x3d3/0x480 drivers/net/usb/usbnet.c:2048
 __smsc75xx_write_reg drivers/net/usb/smsc75xx.c:122 [inline]
 smsc75xx_write_reg drivers/net/usb/smsc75xx.c:153 [inline]
 smsc75xx_reset+0x389/0x8030 drivers/net/usb/smsc75xx.c:1065
 smsc75xx_bind+0xf5a/0x13f0 drivers/net/usb/smsc75xx.c:1492
 usbnet_probe+0x1169/0x3e90 drivers/net/usb/usbnet.c:1712
 usb_probe_interface+0xfcc/0x1520 drivers/usb/core/driver.c:396
 really_probe+0xebd/0x2420 drivers/base/dd.c:558
 driver_probe_device+0x293/0x390 drivers/base/dd.c:738
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:844
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x538/0x860 drivers/base/dd.c:912
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:959
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x399e/0x3f20 drivers/base/core.c:2936
 usb_set_configuration+0x39cf/0x4010 drivers/usb/core/message.c:2159
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:238
 usb_probe_device+0x317/0x570 drivers/usb/core/driver.c:293
 really_probe+0xebd/0x2420 drivers/base/dd.c:558
 driver_probe_device+0x293/0x390 drivers/base/dd.c:738
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:844
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x538/0x860 drivers/base/dd.c:912
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:959
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x399e/0x3f20 drivers/base/core.c:2936
 usb_new_device+0x1bd6/0x2a30 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5222 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
 port_event drivers/usb/core/hub.c:5508 [inline]
 hub_event+0x5bc9/0x8890 drivers/usb/core/hub.c:5590
 process_one_work+0x121c/0x1fc0 kernel/workqueue.c:2272
 worker_thread+0x10cc/0x2740 kernel/workqueue.c:2418
 kthread+0x51c/0x560 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 kmsan_memcpy_memmove_metadata+0x25e/0x2d0 mm/kmsan/kmsan.c:226
 kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:246
 __msan_memcpy+0x46/0x60 mm/kmsan/kmsan_instr.c:110
 kmemdup+0x107/0x140 mm/util.c:130
 __usbnet_write_cmd drivers/net/usb/usbnet.c:1999 [inline]
 usbnet_write_cmd+0x1a0/0x480 drivers/net/usb/usbnet.c:2048
 __smsc75xx_write_reg drivers/net/usb/smsc75xx.c:122 [inline]
 smsc75xx_write_reg drivers/net/usb/smsc75xx.c:153 [inline]
 smsc75xx_reset+0x389/0x8030 drivers/net/usb/smsc75xx.c:1065
 smsc75xx_bind+0xf5a/0x13f0 drivers/net/usb/smsc75xx.c:1492
 usbnet_probe+0x1169/0x3e90 drivers/net/usb/usbnet.c:1712
 usb_probe_interface+0xfcc/0x1520 drivers/usb/core/driver.c:396
 really_probe+0xebd/0x2420 drivers/base/dd.c:558
 driver_probe_device+0x293/0x390 drivers/base/dd.c:738
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:844
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x538/0x860 drivers/base/dd.c:912
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:959
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x399e/0x3f20 drivers/base/core.c:2936
 usb_set_configuration+0x39cf/0x4010 drivers/usb/core/message.c:2159
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:238
 usb_probe_device+0x317/0x570 drivers/usb/core/driver.c:293
 really_probe+0xebd/0x2420 drivers/base/dd.c:558
 driver_probe_device+0x293/0x390 drivers/base/dd.c:738
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:844
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x538/0x860 drivers/base/dd.c:912
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:959
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x399e/0x3f20 drivers/base/core.c:2936
 usb_new_device+0x1bd6/0x2a30 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5222 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
 port_event drivers/usb/core/hub.c:5508 [inline]
 hub_event+0x5bc9/0x8890 drivers/usb/core/hub.c:5590
 process_one_work+0x121c/0x1fc0 kernel/workqueue.c:2272
 worker_thread+0x10cc/0x2740 kernel/workqueue.c:2418
 kthread+0x51c/0x560 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
 __smsc75xx_write_reg drivers/net/usb/smsc75xx.c:119 [inline]
 smsc75xx_write_reg drivers/net/usb/smsc75xx.c:153 [inline]
 smsc75xx_reset+0x18fa/0x8030 drivers/net/usb/smsc75xx.c:1065
 smsc75xx_bind+0xf5a/0x13f0 drivers/net/usb/smsc75xx.c:1492
 usbnet_probe+0x1169/0x3e90 drivers/net/usb/usbnet.c:1712
 usb_probe_interface+0xfcc/0x1520 drivers/usb/core/driver.c:396
 really_probe+0xebd/0x2420 drivers/base/dd.c:558
 driver_probe_device+0x293/0x390 drivers/base/dd.c:738
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:844
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x538/0x860 drivers/base/dd.c:912
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:959
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x399e/0x3f20 drivers/base/core.c:2936
 usb_set_configuration+0x39cf/0x4010 drivers/usb/core/message.c:2159
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:238
 usb_probe_device+0x317/0x570 drivers/usb/core/driver.c:293
 really_probe+0xebd/0x2420 drivers/base/dd.c:558
 driver_probe_device+0x293/0x390 drivers/base/dd.c:738
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:844
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x538/0x860 drivers/base/dd.c:912
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:959
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x399e/0x3f20 drivers/base/core.c:2936
 usb_new_device+0x1bd6/0x2a30 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5222 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
 port_event drivers/usb/core/hub.c:5508 [inline]
 hub_event+0x5bc9/0x8890 drivers/usb/core/hub.c:5590
 process_one_work+0x121c/0x1fc0 kernel/workqueue.c:2272
 worker_thread+0x10cc/0x2740 kernel/workqueue.c:2418
 kthread+0x51c/0x560 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Local variable ----buf.i.i@smsc75xx_reset created at:
 __smsc75xx_read_reg drivers/net/usb/smsc75xx.c:976 [inline]
 smsc75xx_read_reg drivers/net/usb/smsc75xx.c:147 [inline]
 smsc75xx_reset+0x23a/0x8030 drivers/net/usb/smsc75xx.c:1057
 __smsc75xx_read_reg drivers/net/usb/smsc75xx.c:976 [inline]
 smsc75xx_read_reg drivers/net/usb/smsc75xx.c:147 [inline]
 smsc75xx_reset+0x23a/0x8030 drivers/net/usb/smsc75xx.c:1057

Bytes 0-3 of 4 are uninitialized
Memory access of size 4 starts at ffff8880a7403e28
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
