Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A802BAE65
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgKTPPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:15:54 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:56845 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbgKTPPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:15:23 -0500
Received: by mail-il1-f200.google.com with SMTP id g2so7668651ilb.23
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=80yJjBsEuVf/DBylCCzyw6/08YZwdhWrU0iJ9iRPg0w=;
        b=qD4WRdqoQ8B/Dit12AmQ+4UAYyaGQXY/27FP8RlyMN8y+V6PFwk4N40Z9iGLJNv7jy
         vUoF3fc6ccwh56L+BUH/uHwF4dnFomcP8WEnEAIr9x81DRZyi5Zk8YHCwflNJBDa+nz6
         8Wokp/5NwoC91Rbnvr/tEaKHS0D4CDPP+eT5QVGlUK4PSwNoL/OWln5eC97ZZibQgqjT
         RpoOB1mGiJxwKFgGkyCfo5ClBZHzmSfFRlW1yHtoiwsew1EF2eVKnACea4+znrOVWvHU
         +MigpGMMm2forAVeCMb8mUWGjjoLZyuEKrCpoqc5w45Cde355ZHLQw/SXesFwQ8nwOMy
         TMFg==
X-Gm-Message-State: AOAM5335I1WmsWhUH1jGrwUU3+5uWakr/UbKmUuNbcmcuT92+pYOH9Vl
        ukVIgA0j5Q4Jqq2cXFIqpJsWPIxIMT9y7+S5w75fR5n6q1Jf
X-Google-Smtp-Source: ABdhPJw9LDTA8N9hZ4my4t5E+35mefe+zTbMD2qUDa755S1CR7PhUFMZVVVwPWMaAFT7feKNUth24eOxMxZRVDgCH/RT5TIpFQSG
MIME-Version: 1.0
X-Received: by 2002:a5e:a817:: with SMTP id c23mr13689091ioa.56.1605885320499;
 Fri, 20 Nov 2020 07:15:20 -0800 (PST)
Date:   Fri, 20 Nov 2020 07:15:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014163805b48b5063@google.com>
Subject: memory leak in hub_event
From:   syzbot <syzbot+44e64397bd81d5e84cba@syzkaller.appspotmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4d02da97 Merge tag 'net-5.10-rc5' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a7d2b6500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5353ac514ca5a43
dashboard link: https://syzkaller.appspot.com/bug?extid=44e64397bd81d5e84cba
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14925089500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16810051500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44e64397bd81d5e84cba@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810d5ff800 (size 2048):
  comm "kworker/1:0", pid 17, jiffies 4294949188 (age 14.280s)
  hex dump (first 32 bytes):
    ff ff ff ff 31 00 00 00 00 00 00 00 00 00 00 00  ....1...........
    00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00  ................
  backtrace:
    [<00000000f0428224>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000f0428224>] kzalloc include/linux/slab.h:664 [inline]
    [<00000000f0428224>] usb_alloc_dev+0x32/0x450 drivers/usb/core/usb.c:582
    [<000000001802b3dd>] hub_port_connect drivers/usb/core/hub.c:5128 [inline]
    [<000000001802b3dd>] hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
    [<000000001802b3dd>] port_event drivers/usb/core/hub.c:5508 [inline]
    [<000000001802b3dd>] hub_event+0x118d/0x20d0 drivers/usb/core/hub.c:5590
    [<0000000092d3650d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<00000000d4629ab0>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<000000003c358b45>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<000000003689dbb0>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888112544c40 (size 32):
  comm "kworker/1:0", pid 17, jiffies 4294949188 (age 14.280s)
  hex dump (first 32 bytes):
    31 2d 31 00 00 00 00 00 00 00 00 00 00 00 00 00  1-1.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000d0f4aa93>] kvasprintf+0x6c/0xf0 lib/kasprintf.c:25
    [<000000005866b3ad>] kvasprintf_const+0x58/0x110 lib/kasprintf.c:49
    [<00000000b590b008>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<00000000d251a578>] dev_set_name+0x63/0x90 drivers/base/core.c:2722
    [<0000000075b37c03>] usb_alloc_dev+0x1ee/0x450 drivers/usb/core/usb.c:650
    [<000000001802b3dd>] hub_port_connect drivers/usb/core/hub.c:5128 [inline]
    [<000000001802b3dd>] hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
    [<000000001802b3dd>] port_event drivers/usb/core/hub.c:5508 [inline]
    [<000000001802b3dd>] hub_event+0x118d/0x20d0 drivers/usb/core/hub.c:5590
    [<0000000092d3650d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<00000000d4629ab0>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<000000003c358b45>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<000000003689dbb0>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888112544ce0 (size 32):
  comm "kworker/1:0", pid 17, jiffies 4294949231 (age 13.850s)
  hex dump (first 32 bytes):
    00 4d 54 12 81 88 ff ff 00 00 00 00 00 00 00 00  .MT.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000005516ca37>] kmalloc include/linux/slab.h:557 [inline]
    [<000000005516ca37>] kzalloc include/linux/slab.h:664 [inline]
    [<000000005516ca37>] usb_get_configuration+0xce/0x1dd0 drivers/usb/core/config.c:887
    [<000000009ab33a39>] usb_enumerate_device drivers/usb/core/hub.c:2387 [inline]
    [<000000009ab33a39>] usb_new_device+0x1a9/0x2e0 drivers/usb/core/hub.c:2523
    [<0000000069b10350>] hub_port_connect drivers/usb/core/hub.c:5222 [inline]
    [<0000000069b10350>] hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
    [<0000000069b10350>] port_event drivers/usb/core/hub.c:5508 [inline]
    [<0000000069b10350>] hub_event+0x144a/0x20d0 drivers/usb/core/hub.c:5590
    [<0000000092d3650d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<00000000d4629ab0>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<000000003c358b45>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<000000003689dbb0>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888112544bc0 (size 32):
  comm "kworker/1:0", pid 17, jiffies 4294949247 (age 13.690s)
  hex dump (first 32 bytes):
    73 79 7a 00 00 00 00 00 00 00 00 00 00 00 00 00  syz.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000b344f779>] kmalloc include/linux/slab.h:557 [inline]
    [<00000000b344f779>] usb_cache_string+0x8a/0xf0 drivers/usb/core/message.c:1025
    [<0000000074577e65>] usb_enumerate_device drivers/usb/core/hub.c:2397 [inline]
    [<0000000074577e65>] usb_new_device+0x98/0x2e0 drivers/usb/core/hub.c:2523
    [<0000000069b10350>] hub_port_connect drivers/usb/core/hub.c:5222 [inline]
    [<0000000069b10350>] hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
    [<0000000069b10350>] port_event drivers/usb/core/hub.c:5508 [inline]
    [<0000000069b10350>] hub_event+0x144a/0x20d0 drivers/usb/core/hub.c:5590
    [<0000000092d3650d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<00000000d4629ab0>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<000000003c358b45>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<000000003689dbb0>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888112544cc0 (size 32):
  comm "kworker/1:0", pid 17, jiffies 4294949251 (age 13.650s)
  hex dump (first 32 bytes):
    73 79 7a 00 00 00 00 00 00 00 00 00 00 00 00 00  syz.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000b344f779>] kmalloc include/linux/slab.h:557 [inline]
    [<00000000b344f779>] usb_cache_string+0x8a/0xf0 drivers/usb/core/message.c:1025
    [<000000003d5bd90b>] usb_enumerate_device drivers/usb/core/hub.c:2398 [inline]
    [<000000003d5bd90b>] usb_new_device+0xae/0x2e0 drivers/usb/core/hub.c:2523
    [<0000000069b10350>] hub_port_connect drivers/usb/core/hub.c:5222 [inline]
    [<0000000069b10350>] hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
    [<0000000069b10350>] port_event drivers/usb/core/hub.c:5508 [inline]
    [<0000000069b10350>] hub_event+0x144a/0x20d0 drivers/usb/core/hub.c:5590
    [<0000000092d3650d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<00000000d4629ab0>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<000000003c358b45>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<000000003689dbb0>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888112544d40 (size 32):
  comm "kworker/1:0", pid 17, jiffies 4294949255 (age 13.610s)
  hex dump (first 32 bytes):
    73 79 7a 00 00 00 00 00 00 00 00 00 00 00 00 00  syz.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000b344f779>] kmalloc include/linux/slab.h:557 [inline]
    [<00000000b344f779>] usb_cache_string+0x8a/0xf0 drivers/usb/core/message.c:1025
    [<000000007392d5f6>] usb_enumerate_device drivers/usb/core/hub.c:2400 [inline]
    [<000000007392d5f6>] usb_new_device+0xc4/0x2e0 drivers/usb/core/hub.c:2523
    [<0000000069b10350>] hub_port_connect drivers/usb/core/hub.c:5222 [inline]
    [<0000000069b10350>] hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
    [<0000000069b10350>] port_event drivers/usb/core/hub.c:5508 [inline]
    [<0000000069b10350>] hub_event+0x144a/0x20d0 drivers/usb/core/hub.c:5590
    [<0000000092d3650d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<00000000d4629ab0>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<000000003c358b45>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<000000003689dbb0>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
