Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A9428371D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgJEN71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:59:27 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:43549 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgJEN7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:59:20 -0400
Received: by mail-io1-f79.google.com with SMTP id x13so4882507iom.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 06:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HjhcdI/QTm+zFD0fq5JEdhxBWDToFnhpbtIYaOozvDw=;
        b=mZ40pUcu+u18Vu0FT3RRujY5ndfsr0DcC0E3CB59aS7ptBX22cY0KoT5dquYjmkMsO
         Z0/UDj77G1PY10l6DPxQ6hynoyfIv84i4JAQ0mly9JHeAQmJBti2baX62SesgHrUrCwT
         1PAdqHQ/JdqsVcuELo8cZpWN5EnUlk6r5hnxgY5QgKkGhPURWbpR5gfTPU+dED+Luele
         iRtD2GK2yup6hI+Ps/EoqnfJ6s79ErVPIoczBhIoopEYy3jEfHyGkvbLm+Iz8YgSx/VB
         /sspfinwoMdn4qETuP/D8ZhmNTY5UDp+hddd5oICbPdlvjJqe0W1AHzAX6mlVFUCGxKh
         cBtQ==
X-Gm-Message-State: AOAM532xfh2XwbKcRFM0Gzk8VOmr3OSNPUWHuG6ln2waH77m8jWNUDgG
        9ORSwdaApCVxaGaNxqrElXXQkv4A68azK9jIPWa4vkJGQquT
X-Google-Smtp-Source: ABdhPJxa1D+r9nJhKHMCIIocqjqBPXJ59f2NWe7MIkUbyJzSf5ZkxgQ3JlrZx8iYPEr0vh/G6acC6uTf12AgNT2nrC72JcUsjWNh
MIME-Version: 1.0
X-Received: by 2002:a6b:d80d:: with SMTP id y13mr8011221iob.15.1601906359205;
 Mon, 05 Oct 2020 06:59:19 -0700 (PDT)
Date:   Mon, 05 Oct 2020 06:59:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000810a4405b0ece316@google.com>
Subject: KASAN: null-ptr-deref Write in event_handler
From:   syzbot <syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d3d45f82 Merge tag 'pinctrl-v5.9-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15781d8f900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
dashboard link: https://syzkaller.appspot.com/bug?extid=bf1a360e305ee719e364
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cbaa7d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1364f367900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com

vhci_hcd: stop threads
vhci_hcd: release socket
vhci_hcd: disconnect device
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
BUG: KASAN: null-ptr-deref in refcount_add include/linux/refcount.h:201 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:241 [inline]
BUG: KASAN: null-ptr-deref in get_task_struct include/linux/sched/task.h:104 [inline]
BUG: KASAN: null-ptr-deref in kthread_stop+0x90/0x7e0 kernel/kthread.c:591
Write of size 4 at addr 000000000000001c by task kworker/u4:5/2519

CPU: 1 PID: 2519 Comm: kworker/u4:5 Not tainted 5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usbip_event event_handler
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:517 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_write include/linux/instrumented.h:71 [inline]
 atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
 refcount_add include/linux/refcount.h:201 [inline]
 refcount_inc include/linux/refcount.h:241 [inline]
 get_task_struct include/linux/sched/task.h:104 [inline]
 kthread_stop+0x90/0x7e0 kernel/kthread.c:591
 vhci_shutdown_connection+0x170/0x2a0 drivers/usb/usbip/vhci_hcd.c:1015
 event_handler+0x1a5/0x450 drivers/usb/usbip/usbip_event.c:78
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 2519 Comm: kworker/u4:5 Tainted: G    B             5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usbip_event event_handler
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 end_report+0x4d/0x53 mm/kasan/report.c:104
 __kasan_report mm/kasan/report.c:520 [inline]
 kasan_report.cold+0xd/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_write include/linux/instrumented.h:71 [inline]
 atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
 refcount_add include/linux/refcount.h:201 [inline]
 refcount_inc include/linux/refcount.h:241 [inline]
 get_task_struct include/linux/sched/task.h:104 [inline]
 kthread_stop+0x90/0x7e0 kernel/kthread.c:591
 vhci_shutdown_connection+0x170/0x2a0 drivers/usb/usbip/vhci_hcd.c:1015
 event_handler+0x1a5/0x450 drivers/usb/usbip/usbip_event.c:78
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
