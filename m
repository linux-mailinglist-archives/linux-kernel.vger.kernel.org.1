Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF022D6689
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 20:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393420AbgLJTcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 14:32:14 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:50193 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390230AbgLJO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:29:53 -0500
Received: by mail-il1-f197.google.com with SMTP id t8so4536455ils.17
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oLeHKVV0ChX4sKICE3cLVEmUP4AP2CVq6ON5n87Fsyo=;
        b=A3LMRWtQoz9/udN1KcXFJI5kQJpD7k5GV87GlsobCXUL65qyEMv9tuYDznsIjj9hb0
         7smiy6/YN4W3d+vxRcvIPwDhtwSmAEs907I7aZ4r9Trjkq5Ie0Tcc81OBs8hMiqZRMwx
         bET8wuAu44iAqJJswm7BMStDIlbTBMbIyq+/O4j2nHVlFHDxxMT/gRX66FRiqjJijpFx
         05/t2kWm9RfebVa5nDr7fJrI4wS8f7pGYaFCdkxb3Z2Xhaa3RPdIsLYmrkOH7cQyRyTA
         jAOvqEAYHLKuIdPd1la62AjRH1JbI2VN3SsXCHzLNaBF2b41I1lMxT54swS1xr7nY9eM
         jNKw==
X-Gm-Message-State: AOAM532noy3KByFupQQkYhkwmKqt5acdP6KJMZqa2GSLBebn9UOSsZ+A
        Gy55ytYKK1y7lVaDOtfOiWMtLr1/elgKp0ykFcmEnPc/8blX
X-Google-Smtp-Source: ABdhPJy8+qBqHbQq5UwX0GnBwUzPEBkXmcIytguHfFEjM/rnkgEnu2uFKDtZQ5CO9eA8/BbNQX+xI9/W9yCf62/LuKwWy3L/Ujib
MIME-Version: 1.0
X-Received: by 2002:a92:d58a:: with SMTP id a10mr9312308iln.99.1607610552307;
 Thu, 10 Dec 2020 06:29:12 -0800 (PST)
Date:   Thu, 10 Dec 2020 06:29:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e858c005b61cffb1@google.com>
Subject: KASAN: null-ptr-deref Read in ida_free
From:   syzbot <syzbot+930c00d27e58b0d77fb9@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8010622c USB: UAS: introduce a quirk to set no_write_same
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=16dbc923500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d24ee9ecd7ce968e
dashboard link: https://syzkaller.appspot.com/bug?extid=930c00d27e58b0d77fb9
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+930c00d27e58b0d77fb9@syzkaller.appspotmail.com

input: TeVii S662 as /devices/platform/dummy_hcd.3/usb4/4-1/rc/rc0/input610
dvb-usb: schedule remote query interval to 250 msecs.
dw2102: su3000_power_ctrl: 0, initialized 1
dvb-usb: TeVii S662 successfully initialized and connected.
usb 4-1: USB disconnect, device number 114
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
BUG: KASAN: null-ptr-deref in ida_free+0x186/0x2b0 lib/idr.c:510
Read of size 8 at addr 0000000000000018 by task kworker/1:0/4637

CPU: 1 PID: 4637 Comm: kworker/1:0 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:549 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 ida_free+0x186/0x2b0 lib/idr.c:510
 __media_device_unregister_entity+0x70/0x300 drivers/media/mc/mc-device.c:586
 media_device_unregister_entity+0x49/0x70 drivers/media/mc/mc-device.c:689
 dvb_media_device_free+0x1d5/0x620 drivers/media/dvb-core/dvbdev.c:226
 dvb_remove_device.part.0+0x9c/0x260 drivers/media/dvb-core/dvbdev.c:561
 dvb_remove_device drivers/media/dvb-core/dvbdev.c:554 [inline]
 dvb_unregister_device+0x1b/0x60 drivers/media/dvb-core/dvbdev.c:583
 dvb_dmxdev_release+0x1a0/0x640 drivers/media/dvb-core/dmxdev.c:1459
 dvb_usb_adapter_dvb_exit+0x93/0x230 drivers/media/usb/dvb-usb/dvb-usb-dvb.c:224
 dvb_usb_adapter_exit drivers/media/usb/dvb-usb/dvb-usb-init.c:114 [inline]
 dvb_usb_exit.isra.0+0xb4/0x310 drivers/media/usb/dvb-usb/dvb-usb-init.c:129
 dvb_usb_device_exit+0x111/0x1a0 drivers/media/usb/dvb-usb/dvb-usb-init.c:306
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
 process_scheduled_works kernel/workqueue.c:2334 [inline]
 worker_thread+0x82b/0x1120 kernel/workqueue.c:2420
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
