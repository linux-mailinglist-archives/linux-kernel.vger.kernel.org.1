Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD57E2E1DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgLWPZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:25:59 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:42613 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgLWPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:25:58 -0500
Received: by mail-io1-f72.google.com with SMTP id m9so9610027ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ccI8XWc2bkBr3nAUmdNVuOgWrLgiP4ffUXMAehqESVc=;
        b=Ehy1ylApotKrZtI+gUWcMutgkPJFZFgCWq5zVzcskpaq1o5O/Mlw7FPqjlNmBIMR5V
         maS4DVg33QRgUTAw4Yomo8336qKFSHiqL6HdVOMrJPxWKcdF6jI/BwWJV7NXuyGAm1wq
         kuWTyDXnnrhFDvfmu4CWYoIfxNMIO8873f+1UDEEQwQe5iSCgq4XFju4Mg+pRrCeD2vt
         KRaZW7p3vzQA2wJJrflXVcarFTe3zBNGDvbMgJ7kjzQElR7mCvTtxT1ZTea3Sm6ioLT2
         Y5iDHu4gLBHEvitK2G39MtZkO07eVpGMnmF6aO4CHA3imBeQOKa3F8UujMaghwg0Zg3Z
         Xj4A==
X-Gm-Message-State: AOAM531nhtIKWwZLgK+fcGIajxsuN/y7VounM80arczTDPMGiKDmmmjh
        ku0+jX64n81B+ZwLE1fqbt9BPg+Sao136P6XPHr/XxZTspsy
X-Google-Smtp-Source: ABdhPJx8vo7Y8yQHtUlIQ7SkyfkLzF0E+/Q5kGXsq5O9xMo9J7lBurcirREzhK+dz6cv/+m3tOhl7tmLnP8Wj5+4rpQPQytNgWbu
MIME-Version: 1.0
X-Received: by 2002:a92:db42:: with SMTP id w2mr25735842ilq.113.1608737117405;
 Wed, 23 Dec 2020 07:25:17 -0800 (PST)
Date:   Wed, 23 Dec 2020 07:25:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b86be05b7234cc1@google.com>
Subject: memory leak in zr364xx_probe
From:   syzbot <syzbot+b4d54814b339b5c6bbd4@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, royale@zerezo.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3644e2d2 mm/filemap: fix infinite loop in generic_file_buf..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f80eff500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37c889fb8b2761af
dashboard link: https://syzkaller.appspot.com/bug?extid=b4d54814b339b5c6bbd4
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1089df07500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1671c77f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4d54814b339b5c6bbd4@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffffc90000e71000 (size 200704):
  comm "kworker/0:2", pid 3653, jiffies 4294942426 (age 13.820s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000110a155e>] __vmalloc_node_range+0x3a5/0x410 mm/vmalloc.c:2585
    [<000000008a1ee970>] __vmalloc_node mm/vmalloc.c:2617 [inline]
    [<000000008a1ee970>] vmalloc+0x49/0x50 mm/vmalloc.c:2650
    [<00000000a6a3abfa>] zr364xx_board_init drivers/media/usb/zr364xx/zr364xx.c:1348 [inline]
    [<00000000a6a3abfa>] zr364xx_probe+0x60b/0x833 drivers/media/usb/zr364xx/zr364xx.c:1509
    [<0000000014a572f5>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<00000000f30ee977>] really_probe+0x159/0x480 drivers/base/dd.c:561
    [<00000000ddb29374>] driver_probe_device+0x84/0x100 drivers/base/dd.c:745
    [<0000000073c89cb9>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:851
    [<000000009f56a99c>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000848d591a>] __device_attach+0x122/0x250 drivers/base/dd.c:919
    [<00000000168be5bb>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<00000000464f40a6>] device_add+0x5be/0xc30 drivers/base/core.c:3091
    [<000000008c75a2b5>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2164
    [<00000000071d14a5>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<00000000f325b973>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<00000000f30ee977>] really_probe+0x159/0x480 drivers/base/dd.c:561
    [<00000000ddb29374>] driver_probe_device+0x84/0x100 drivers/base/dd.c:745



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
