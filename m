Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0B2CC7DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgLBUdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:33:17 -0500
Received: from netrider.rowland.org ([192.131.102.5]:44701 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729176AbgLBUdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:33:15 -0500
Received: (qmail 1067955 invoked by uid 1000); 2 Dec 2020 15:32:34 -0500
Date:   Wed, 2 Dec 2020 15:32:34 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+641bd6ff9b25e6d3aad1@syzkaller.appspotmail.com>
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: memory leak in usb_set_configuration
Message-ID: <20201202203234.GC1062758@rowland.harvard.edu>
References: <000000000000cd6be705b3d525d5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000cd6be705b3d525d5@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 05:55:27AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    407ab579 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16d84062500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f13716fa0212fd
> dashboard link: https://syzkaller.appspot.com/bug?extid=641bd6ff9b25e6d3aad1
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102c2094500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a8dfa8500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+641bd6ff9b25e6d3aad1@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff88810ed7cc00 (size 1024):
>   comm "kworker/0:3", pid 4907, jiffies 4294954595 (age 14.630s)
>   hex dump (first 32 bytes):
>     48 92 b6 11 81 88 ff ff 48 92 b6 11 81 88 ff ff  H.......H.......
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000acb2212d>] kmalloc include/linux/slab.h:552 [inline]
>     [<00000000acb2212d>] kzalloc include/linux/slab.h:664 [inline]
>     [<00000000acb2212d>] usb_set_configuration+0x18c/0xb90 drivers/usb/core/message.c:1987
>     [<00000000398ef244>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
>     [<00000000c8516fd1>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
>     [<00000000eb555eca>] really_probe+0x159/0x480 drivers/base/dd.c:554
>     [<0000000082b68944>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
>     [<000000000485fb4d>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
>     [<00000000a0e84ad1>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
>     [<0000000017598cdd>] __device_attach+0x122/0x250 drivers/base/dd.c:912
>     [<00000000201e5839>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
>     [<00000000ec5f56bf>] device_add+0x5ac/0xc30 drivers/base/core.c:2936
>     [<0000000049b5ad41>] usb_new_device.cold+0x166/0x578 drivers/usb/core/hub.c:2554
>     [<0000000030bc00f0>] hub_port_connect drivers/usb/core/hub.c:5222 [inline]
>     [<0000000030bc00f0>] hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
>     [<0000000030bc00f0>] port_event drivers/usb/core/hub.c:5508 [inline]
>     [<0000000030bc00f0>] hub_event+0x144a/0x20d0 drivers/usb/core/hub.c:5590
>     [<00000000e89e69ae>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
>     [<0000000063d76c23>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
>     [<00000000a311ec69>] kthread+0x178/0x1b0 kernel/kthread.c:292
>     [<00000000690c42fe>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

#syz dup: memory leak in hub_event

Alan Stern
