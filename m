Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896B02AF29B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgKKNz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:55:29 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:36034 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgKKNz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:55:27 -0500
Received: by mail-il1-f199.google.com with SMTP id r12so1379375iln.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eBJECi1MCWmcND7XU6JD96ghwkq64uxBYy2L3wSV0kY=;
        b=WMk7mLYGsAh+5BsyNPwacVMWNjSb5C27VgNryFI5mfkzRGQpjWClRVQrkBZnjPmQBX
         KyxkzyAQQUdS+rF6Borr1vESYaaURbLLH+T+3LdIP+DRy1Vf1Wr3z8OC14MV4+zUbuI2
         JuHZCT5FHTE7veWlMz1/IEyydfmz4FXPfA8zOOGEiCtUcd7MkxTcvzwhD2s2gEV6x84Y
         WtjtO7EbMAYzH7BuUbPReAHAvcDWhiH4dak+U89R9B4io47UZyAJKBFZ5WeuuE9nNyYE
         mbeiiXH6p6R8abjiU+VLajh/v5U/bvlIhss5OoCZFhqhRe7Zhi+4jigMXiMJKzAl/x7Q
         nm4w==
X-Gm-Message-State: AOAM532fhnMyJuskh7KMdDi4tVmeYi4FGJUB98ky5Kz043pTxA2zirIO
        h3X/e36LWYNAE5vTsos5TL9rl/I1LhpRm8TWNywT98gdw5qR
X-Google-Smtp-Source: ABdhPJyqsVD/08P7KbjopKFgcEXU3rJ49JEnT/YpZLyQBbsuoA9cpDRkJxew2c6gp9ZEl+04aZ2IP0wHC6Pa5XJA9g5YPzelGxcR
MIME-Version: 1.0
X-Received: by 2002:a92:4442:: with SMTP id a2mr18160839ilm.220.1605102926926;
 Wed, 11 Nov 2020 05:55:26 -0800 (PST)
Date:   Wed, 11 Nov 2020 05:55:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c99ca505b3d525fb@google.com>
Subject: memory leak in __usbhid_submit_report
From:   syzbot <syzbot+47b26cd837ececfc666d@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f8394f23 Linux 5.10-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ebbdc6500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f13716fa0212fd
dashboard link: https://syzkaller.appspot.com/bug?extid=47b26cd837ececfc666d
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14497b82500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1586ff14500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47b26cd837ececfc666d@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881097e5ec0 (size 32):
  comm "kworker/0:1", pid 7, jiffies 4294949214 (age 33.520s)
  hex dump (first 32 bytes):
    04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008296eaa1>] __usbhid_submit_report+0x116/0x490 drivers/hid/usbhid/hid-core.c:588
    [<00000000fe39f007>] usbhid_submit_report drivers/hid/usbhid/hid-core.c:638 [inline]
    [<00000000fe39f007>] usbhid_request+0x59/0xa0 drivers/hid/usbhid/hid-core.c:1272
    [<00000000428a854b>] hidinput_led_worker+0x59/0x160 drivers/hid/hid-input.c:1507
    [<000000001bb8d86d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<000000005d9a2f9c>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<00000000dc999b29>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<0000000099d5a9ee>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff8881120200c0 (size 32):
  comm "kworker/0:1", pid 7, jiffies 4294949214 (age 33.520s)
  hex dump (first 32 bytes):
    04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008296eaa1>] __usbhid_submit_report+0x116/0x490 drivers/hid/usbhid/hid-core.c:588
    [<00000000fe39f007>] usbhid_submit_report drivers/hid/usbhid/hid-core.c:638 [inline]
    [<00000000fe39f007>] usbhid_request+0x59/0xa0 drivers/hid/usbhid/hid-core.c:1272
    [<00000000428a854b>] hidinput_led_worker+0x59/0x160 drivers/hid/hid-input.c:1507
    [<000000001bb8d86d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<000000005d9a2f9c>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<00000000dc999b29>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<0000000099d5a9ee>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888107fa9420 (size 32):
  comm "kworker/0:1", pid 7, jiffies 4294949214 (age 33.520s)
  hex dump (first 32 bytes):
    04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008296eaa1>] __usbhid_submit_report+0x116/0x490 drivers/hid/usbhid/hid-core.c:588
    [<00000000fe39f007>] usbhid_submit_report drivers/hid/usbhid/hid-core.c:638 [inline]
    [<00000000fe39f007>] usbhid_request+0x59/0xa0 drivers/hid/usbhid/hid-core.c:1272
    [<00000000428a854b>] hidinput_led_worker+0x59/0x160 drivers/hid/hid-input.c:1507
    [<000000001bb8d86d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<000000005d9a2f9c>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<00000000dc999b29>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<0000000099d5a9ee>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888112020b60 (size 32):
  comm "kworker/1:4", pid 8569, jiffies 4294949237 (age 33.290s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008296eaa1>] __usbhid_submit_report+0x116/0x490 drivers/hid/usbhid/hid-core.c:588
    [<00000000fe39f007>] usbhid_submit_report drivers/hid/usbhid/hid-core.c:638 [inline]
    [<00000000fe39f007>] usbhid_request+0x59/0xa0 drivers/hid/usbhid/hid-core.c:1272
    [<00000000428a854b>] hidinput_led_worker+0x59/0x160 drivers/hid/hid-input.c:1507
    [<000000001bb8d86d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<000000005d9a2f9c>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<00000000dc999b29>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<0000000099d5a9ee>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888107fa9a20 (size 32):
  comm "kworker/1:3", pid 8559, jiffies 4294949241 (age 33.250s)
  hex dump (first 32 bytes):
    04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008296eaa1>] __usbhid_submit_report+0x116/0x490 drivers/hid/usbhid/hid-core.c:588
    [<00000000fe39f007>] usbhid_submit_report drivers/hid/usbhid/hid-core.c:638 [inline]
    [<00000000fe39f007>] usbhid_request+0x59/0xa0 drivers/hid/usbhid/hid-core.c:1272
    [<00000000428a854b>] hidinput_led_worker+0x59/0x160 drivers/hid/hid-input.c:1507
    [<000000001bb8d86d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<000000005d9a2f9c>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<00000000dc999b29>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<0000000099d5a9ee>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888112020940 (size 32):
  comm "kworker/1:3", pid 8559, jiffies 4294949241 (age 33.250s)
  hex dump (first 32 bytes):
    04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008296eaa1>] __usbhid_submit_report+0x116/0x490 drivers/hid/usbhid/hid-core.c:588
    [<00000000fe39f007>] usbhid_submit_report drivers/hid/usbhid/hid-core.c:638 [inline]
    [<00000000fe39f007>] usbhid_request+0x59/0xa0 drivers/hid/usbhid/hid-core.c:1272
    [<00000000428a854b>] hidinput_led_worker+0x59/0x160 drivers/hid/hid-input.c:1507
    [<000000001bb8d86d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
    [<000000005d9a2f9c>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
    [<00000000dc999b29>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<0000000099d5a9ee>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

executing program
executing program
executing program
executing program
executing program
executing program
executing program


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
