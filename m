Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826BB2DF68A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 19:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgLTSox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 13:44:53 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:36891 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgLTSox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 13:44:53 -0500
Received: by mail-il1-f198.google.com with SMTP id g10so7485993ile.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 10:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=B+OucNE/e2hD3TvMLPN9TV2Z1nuA/18UyvmHrFjlvgQ=;
        b=tiQl9dzR2JxWyuH8vtf5OfyU3y+tXXEGfuvk/LTb7+U7j2dUhlcv2ElEdXo2f88sdK
         3m37gtB4hfBNGkoC0N9q43KcKbFh5kYjPpIGHtFpIYijvrcpUd9sCBLkKKek237zYNaG
         OVfn/xCm6I6vpO9O/+K/0NyP/CZotoBpJiVLlb9cun9BhN51bGqJC91dGdsQi1xbGVgL
         oCYb4ie5PkJKDyGOdKi7HbNIrrSpbMLEDllndeEE/7Au3TyHVWTxBZ/8XizW+5d9sfRp
         /rMbIGZIBiRhZ/lu7Go/+ggM6BN8EuYeV1OUB/NcGy96tGKRJdOsNt7BF9oHFKf9vFaf
         m8IQ==
X-Gm-Message-State: AOAM5337XC5LYqNQ6ds5+YKPi9ZLDE7uBBAX5+M0Pt/roIOCnF6M/YSp
        dFIsvnZ8Ghn+jy3xZRG6B07paKUTKjVUSstEn+gOd1Ibgmdb
X-Google-Smtp-Source: ABdhPJwghH2DhSvXi4qjA+Vn895Sg5aSvjfJvqAGLFHEi2VkojMpyiA0YZPidjYpj/eFAlDxXBgaFGVnNExQNJdvIDmDgailoZex
MIME-Version: 1.0
X-Received: by 2002:a6b:4f13:: with SMTP id d19mr11603783iob.121.1608489852027;
 Sun, 20 Dec 2020 10:44:12 -0800 (PST)
Date:   Sun, 20 Dec 2020 10:44:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000414db905b6e9bae8@google.com>
Subject: KASAN: null-ptr-deref Write in vhci_shutdown_connection
From:   syzbot <syzbot+a93fba6d384346a761e3@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5e60366d Merge tag 'fallthrough-fixes-clang-5.11-rc1' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f05613500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=503d0089cd701d6d
dashboard link: https://syzkaller.appspot.com/bug?extid=a93fba6d384346a761e3
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d0d8c5500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1058e41f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a93fba6d384346a761e3@syzkaller.appspotmail.com

vhci_hcd: stop threads
vhci_hcd: release socket
vhci_hcd: disconnect device
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
BUG: KASAN: null-ptr-deref in __refcount_add include/linux/refcount.h:193 [inline]
BUG: KASAN: null-ptr-deref in __refcount_inc include/linux/refcount.h:250 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:267 [inline]
BUG: KASAN: null-ptr-deref in get_task_struct include/linux/sched/task.h:102 [inline]
BUG: KASAN: null-ptr-deref in kthread_stop+0x90/0x760 kernel/kthread.c:591
Write of size 4 at addr 0000000000000024 by task kworker/u4:2/46

CPU: 0 PID: 46 Comm: kworker/u4:2 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usbip_event event_handler
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 __kasan_report mm/kasan/report.c:549 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
 __refcount_add include/linux/refcount.h:193 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 get_task_struct include/linux/sched/task.h:102 [inline]
 kthread_stop+0x90/0x760 kernel/kthread.c:591
 vhci_shutdown_connection+0x17f/0x340 drivers/usb/usbip/vhci_hcd.c:1021
 event_handler+0x1f0/0x4f0 drivers/usb/usbip/usbip_event.c:78
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 46 Comm: kworker/u4:2 Tainted: G    B             5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usbip_event event_handler
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 panic+0x343/0x77f kernel/panic.c:231
 end_report+0x58/0x5e mm/kasan/report.c:106
 __kasan_report mm/kasan/report.c:552 [inline]
 kasan_report.cold+0xd/0x37 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
 __refcount_add include/linux/refcount.h:193 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 get_task_struct include/linux/sched/task.h:102 [inline]
 kthread_stop+0x90/0x760 kernel/kthread.c:591
 vhci_shutdown_connection+0x17f/0x340 drivers/usb/usbip/vhci_hcd.c:1021
 event_handler+0x1f0/0x4f0 drivers/usb/usbip/usbip_event.c:78
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
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
