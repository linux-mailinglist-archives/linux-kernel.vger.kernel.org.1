Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA7E2AF29E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgKKNzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:55:36 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:35186 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbgKKNz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:55:29 -0500
Received: by mail-il1-f199.google.com with SMTP id l2so1383543ilj.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AfwyT0oEwq2fMzy5Nzeby/PEIIbu4MsdDfgXVxHMlRA=;
        b=PXuTaIXgYqtxHKBwK6lMQBpUDLPOIR/Ok+WK6WddHRhZoSEg5MRCHSRca1J2s2QB8N
         v/eMhKW2jN8OOM5u4luLpD9O+PkSJ5/v0ptaIp6Xid8PEHvJq1fhizKdmJ80BwEqMq8m
         e8xx9aEpYb3TbER3352lHem/0ounnkcg6ZDLZj0l5GSGHXxZs4nhPw5TBupa8iTYkNAR
         bTKUoS7B83aTvo3U/vU50yqDtRqZC5SUtW+VruKOrwDmsDXrbL4xuiZ0NHKaVYkhXtGa
         lukM1wtPrOFWtCuEYgHEougGb22IEMtBUcxhJfY+j/9HD2YMj6rnx1xi15YPz0YOtLy8
         6mnA==
X-Gm-Message-State: AOAM531fL4e0I+ynaqMH9allpV799PI45UmEZGgVIr3eLFC8mqM05+ge
        KOQBrtOy74BUg6JtIVro4uXIJIfvMII0Z8L5ItHQOrlOFVj5
X-Google-Smtp-Source: ABdhPJxr+mEdcRwJ0Z5xy/D380R7Fd8HMB0EF8vGO5g5aD3jadKyQh3n+QYO3nMMdKIoXL2uxUpyD65VXpMurLVwtWAyuGxeDC/A
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:111:: with SMTP id t17mr19651219ilm.79.1605102926684;
 Wed, 11 Nov 2020 05:55:26 -0800 (PST)
Date:   Wed, 11 Nov 2020 05:55:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5eece05b3d5256c@google.com>
Subject: memory leak in dvb_create_media_graph
From:   syzbot <syzbot+7f09440acc069a0d38ac@syzkaller.appspotmail.com>
To:     brad@nextdimension.cc, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, sean@mess.org, syzkaller-bugs@googlegroups.com,
        wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    407ab579 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1472cf3a500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f13716fa0212fd
dashboard link: https://syzkaller.appspot.com/bug?extid=7f09440acc069a0d38ac
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1496773a500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f5d04e500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f09440acc069a0d38ac@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888109ceb880 (size 128):
  comm "kworker/0:4", pid 4908, jiffies 4294942256 (age 13.710s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 06 05 00 00 00 00 00 00  ................
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<0000000063129123>] kmalloc include/linux/slab.h:552 [inline]
    [<0000000063129123>] kzalloc include/linux/slab.h:664 [inline]
    [<0000000063129123>] dvb_create_media_graph+0x301/0x7d0 drivers/media/dvb-core/dvbdev.c:662
    [<00000000446ffd59>] dvb_usb_adapter_frontend_init+0x180/0x1b0 drivers/media/usb/dvb-usb/dvb-usb-dvb.c:327
    [<000000004de3ceb1>] dvb_usb_adapter_init drivers/media/usb/dvb-usb/dvb-usb-init.c:84 [inline]
    [<000000004de3ceb1>] dvb_usb_init drivers/media/usb/dvb-usb/dvb-usb-init.c:173 [inline]
    [<000000004de3ceb1>] dvb_usb_device_init.cold+0x4d0/0x6ae drivers/media/usb/dvb-usb/dvb-usb-init.c:287
    [<0000000044208faf>] gp8psk_usb_probe+0x2a/0x50 drivers/media/usb/dvb-usb/gp8psk.c:304
    [<000000001403cbb0>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<000000009ed11d03>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<000000000cd27108>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<000000005568f559>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
    [<00000000f9838db7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<000000006449b02e>] __device_attach+0x122/0x250 drivers/base/dd.c:912
    [<000000007f8d4f6c>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<0000000023ea078a>] device_add+0x5ac/0xc30 drivers/base/core.c:2936
    [<0000000024710aa6>] usb_set_configuration+0x9de/0xb90 drivers/usb/core/message.c:2159
    [<000000009af942e5>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<00000000a5638b3c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<000000009ed11d03>] really_probe+0x159/0x480 drivers/base/dd.c:554

BUG: memory leak
unreferenced object 0xffff888110cbec80 (size 128):
  comm "kworker/1:2", pid 4591, jiffies 4294942850 (age 7.770s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 06 05 00 00 00 00 00 00  ................
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<0000000063129123>] kmalloc include/linux/slab.h:552 [inline]
    [<0000000063129123>] kzalloc include/linux/slab.h:664 [inline]
    [<0000000063129123>] dvb_create_media_graph+0x301/0x7d0 drivers/media/dvb-core/dvbdev.c:662
    [<00000000446ffd59>] dvb_usb_adapter_frontend_init+0x180/0x1b0 drivers/media/usb/dvb-usb/dvb-usb-dvb.c:327
    [<000000004de3ceb1>] dvb_usb_adapter_init drivers/media/usb/dvb-usb/dvb-usb-init.c:84 [inline]
    [<000000004de3ceb1>] dvb_usb_init drivers/media/usb/dvb-usb/dvb-usb-init.c:173 [inline]
    [<000000004de3ceb1>] dvb_usb_device_init.cold+0x4d0/0x6ae drivers/media/usb/dvb-usb/dvb-usb-init.c:287
    [<0000000044208faf>] gp8psk_usb_probe+0x2a/0x50 drivers/media/usb/dvb-usb/gp8psk.c:304
    [<000000001403cbb0>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<000000009ed11d03>] really_probe+0x159/0x480 drivers/base/dd.c:554
    [<000000000cd27108>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
    [<000000005568f559>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
    [<00000000f9838db7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<000000006449b02e>] __device_attach+0x122/0x250 drivers/base/dd.c:912
    [<000000007f8d4f6c>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<0000000023ea078a>] device_add+0x5ac/0xc30 drivers/base/core.c:2936
    [<0000000024710aa6>] usb_set_configuration+0x9de/0xb90 drivers/usb/core/message.c:2159
    [<000000009af942e5>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<00000000a5638b3c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<000000009ed11d03>] really_probe+0x159/0x480 drivers/base/dd.c:554



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
