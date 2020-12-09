Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31AF2D3C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgLIHeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:34:14 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:48265 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgLIHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:33:52 -0500
Received: by mail-io1-f71.google.com with SMTP id 191so605072iob.15
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 23:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=P9LZMAZBHJf7O9yDXHWHSE/19zyEUKOfD7IEF1OKF14=;
        b=T+zId1eoJkkNs1KepDpesNZqspHeBnbuoZ8Zp/Migot9gr9ZN0Lga7qtNvcS1hJmXM
         ztxCn3z7Yi7C2BPBKWDFJE4jZEJKn5EDmA82EkQlTX/+mEXy8i40Ya9iFR+492j56rx9
         DHIbQ8p/F6GV8gREzbkDftBFNLUERVVWvo+krTJvhJ87u5O7v+29K/reJ4MWhZDL1aag
         BtQtelfCIaQ6Y+7JazQN9ut2MuzEtYrvsCBezQHL0azCkMtmkb+QReH6Shhd0pAtFGff
         ZQWskhexNv8Nslmm12vTbtMBrmsmG/+NYZm9KAOHoffg7+LYH68zZx9Nhaue/blRSQGc
         OW3Q==
X-Gm-Message-State: AOAM530kKcUbmoSXcILbAf9FxmuGIgC6BwL+wkutEsH8DFp6PIA6TI2B
        95iLc+EEKYYDMF9/XFSgUTTFDk6EFuDFnSeb9eEaLZVpuD1L
X-Google-Smtp-Source: ABdhPJxeiG9pDSrKPLzAaSeLKo/j9mbJBnfYpzGtjanj1/S/ooN3PyFgINzu9pkjYBCnpJC/mqHlVwut2yh0IMMxDrRNPMYI/Hq8
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2211:: with SMTP id n17mr1139091ion.107.1607499191889;
 Tue, 08 Dec 2020 23:33:11 -0800 (PST)
Date:   Tue, 08 Dec 2020 23:33:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f34f605b60312af@google.com>
Subject: UBSAN: shift-out-of-bounds in parse_audio_format_i
From:   syzbot <syzbot+df7dc146ebdd6435eea3@syzkaller.appspotmail.com>
To:     alexander@tsoy.me, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, mickflemm@gmail.com, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15ac8fdb Add linux-next specific files for 20201207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16d4620f500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3696b8138207d24d
dashboard link: https://syzkaller.appspot.com/bug?extid=df7dc146ebdd6435eea3
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126afa13500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14389613500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df7dc146ebdd6435eea3@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=1d6b, idProduct=0101, bcdDevice= 0.40
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: 2:1 : no or invalid class specific endpoint descriptor
================================================================================
UBSAN: shift-out-of-bounds in sound/usb/format.c:44:17
shift exponent 4098 is too large for 64-bit type 'long long unsigned int'
CPU: 0 PID: 8656 Comm: kworker/0:4 Not tainted 5.10.0-rc6-next-20201207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 parse_audio_format_i_type sound/usb/format.c:44 [inline]
 parse_audio_format_i.cold+0xba/0x3e2 sound/usb/format.c:653
 snd_usb_parse_audio_format+0x89/0x290 sound/usb/format.c:753
 snd_usb_get_audioformat_uac12 sound/usb/stream.c:841 [inline]
 __snd_usb_parse_audio_interface+0xce4/0x3cf0 sound/usb/stream.c:1170
 snd_usb_parse_audio_interface+0x79/0x130 sound/usb/stream.c:1240
 snd_usb_create_stream.isra.0+0x23a/0x530 sound/usb/card.c:206
 snd_usb_create_streams sound/usb/card.c:278 [inline]
 usb_audio_probe+0x93c/0x2ab0 sound/usb/card.c:802
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 really_probe+0x2b1/0xe40 drivers/base/dd.c:554
 driver_probe_device+0x285/0x3f0 drivers/base/dd.c:738
 __device_attach_driver+0x216/0x2d0 drivers/base/dd.c:844
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4c0 drivers/base/dd.c:912
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbb2/0x1ce0 drivers/base/core.c:2934
 usb_set_configuration+0x113c/0x1910 drivers/usb/core/message.c:2167
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 really_probe+0x2b1/0xe40 drivers/base/dd.c:554
 driver_probe_device+0x285/0x3f0 drivers/base/dd.c:738
 __device_attach_driver+0x216/0x2d0 drivers/base/dd.c:844
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4c0 drivers/base/dd.c:912
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbb2/0x1ce0 drivers/base/core.c:2934
 usb_new_device.cold+0x725/0x1057 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x2348/0x42d0 drivers/usb/core/hub.c:5591
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
