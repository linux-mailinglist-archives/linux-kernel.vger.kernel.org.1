Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A332E9B3F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbhADQou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:44:50 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:48394 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbhADQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:44:49 -0500
Received: by mail-il1-f200.google.com with SMTP id f4so28169613ilu.15
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 08:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mAlPZd211YKAjeZ/D9tu3mm37YIY+Dc+GsGDLBS5k0U=;
        b=I5b35aXqQ0Aa6ZP8AD4kijGqRSLFWJ3E7lcYB4+zHxHvm6+KVRePnGARUc/hrC5T/N
         PYu1M9BnnwJhZq5wTUNHqZ0h6XeB/LNE4v50yeDT5CvDEJip824Zw4SpZFWF5b/Z3zG2
         u/zk2Xqnd0n16PAfetJBwnjq+Jj1q0S9Ml3YWvI9AiRQJddAQSauVNgP06ZqtPIXaIMs
         OZWCm2uLtOFReoXYqoPCvXX5MORZG62tqpj1+lSPY3wQ+uqX0pixfsrM5GlnJmZMl/iz
         SAIp1DXlxnpZxi0xFNlNWn1bceLwLPhun4CrrJSA84wyonGPCd6Vv7w6SOuiDuOXdBnM
         S1EA==
X-Gm-Message-State: AOAM532ACfate6b6Kt4lqXTK94ugmDqnDZYoUIddcgNtO1O0KL38hd/I
        hxiPhzYA87ZaZ7c/8tJyxcF7Doth7yR4f9cPKv75l6UgZbG3
X-Google-Smtp-Source: ABdhPJynhlAtO+6FtbbckpJ+F63JKh6Ek+yvcGHgvaFPj/OQMJSF1C5Uea5cegEXEebL8mIAGPOtoY57qrn4JpATTImQ0FPQwREI
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c3:: with SMTP id i3mr69819906ilm.81.1609778647637;
 Mon, 04 Jan 2021 08:44:07 -0800 (PST)
Date:   Mon, 04 Jan 2021 08:44:07 -0800
In-Reply-To: <6a56df508f597d38746878e80e1f159a556d3152.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075a3e605b815cc38@google.com>
Subject: Re: KASAN: use-after-free Read in service_outstanding_interrupt
From:   syzbot <syzbot+9e04e2df4a32fb661daf@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in service_outstanding_interrupt

==================================================================
BUG: KASAN: use-after-free in usb_submit_urb+0x1210/0x1560 drivers/usb/core/urb.c:383
Read of size 4 at addr ffff888113e9f018 by task syz-executor.0/7799

CPU: 1 PID: 7799 Comm: syz-executor.0 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0xae/0x4c8 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 usb_submit_urb+0x1210/0x1560 drivers/usb/core/urb.c:383
 service_outstanding_interrupt.part.0+0x5f/0xa0 drivers/usb/class/cdc-wdm.c:470
 service_outstanding_interrupt drivers/usb/class/cdc-wdm.c:465 [inline]
 wdm_read+0x9a0/0xbd0 drivers/usb/class/cdc-wdm.c:583
 vfs_read+0x1b5/0x570 fs/read_write.c:494
 ksys_read+0x12d/0x250 fs/read_write.c:634
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e149
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fcce8099c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045e149
RDX: 0000000000001000 RSI: 0000000020001000 RDI: 0000000000000004
RBP: 000000000119c068 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119c034
R13: 00007fffc13967df R14: 00007fcce809a9c0 R15: 000000000119c034

Allocated by task 17:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:461
 kmalloc include/linux/slab.h:552 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 usb_alloc_dev+0x51/0xef0 drivers/usb/core/usb.c:582
 hub_port_connect drivers/usb/core/hub.c:5129 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x1def/0x42d0 drivers/usb/core/hub.c:5591
 process_one_work+0x98d/0x15c0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Freed by task 2183:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:352
 __kasan_slab_free+0x102/0x140 mm/kasan/common.c:422
 slab_free_hook mm/slub.c:1544 [inline]
 slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1577
 slab_free mm/slub.c:3140 [inline]
 kfree+0xdb/0x3a0 mm/slub.c:4122
 device_release+0x9f/0x240 drivers/base/core.c:1962
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3190
 hub_port_connect drivers/usb/core/hub.c:5074 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x1c8a/0x42d0 drivers/usb/core/hub.c:5591
 process_one_work+0x98d/0x15c0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0xc0/0xf0 mm/kasan/generic.c:343
 insert_work+0x48/0x370 kernel/workqueue.c:1331
 __queue_work+0x5c3/0xf60 kernel/workqueue.c:1497
 queue_work_on+0xc7/0xd0 kernel/workqueue.c:1524
 kref_put include/linux/kref.h:65 [inline]
 tty_kref_put drivers/tty/tty_io.c:1493 [inline]
 release_tty+0x4e9/0x610 drivers/tty/tty_io.c:1530
 tty_release_struct+0xb4/0xe0 drivers/tty/tty_io.c:1629
 tty_release+0xc70/0x1210 drivers/tty/tty_io.c:1789
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:168
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x186/0x190 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888113e9f000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 24 bytes inside of
 2048-byte region [ffff888113e9f000, ffff888113e9f800)
The buggy address belongs to the page:
page:00000000e5a7bd64 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x113e98
head:00000000e5a7bd64 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 dead000000000100 dead000000000122 ffff888100042000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888113e9ef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888113e9ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888113e9f000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888113e9f080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888113e9f100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         5e60366d Merge tag 'fallthrough-fixes-clang-5.11-rc1' of g..
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1755d077500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea7506b7139727
dashboard link: https://syzkaller.appspot.com/bug?extid=9e04e2df4a32fb661daf
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e05e57500000

