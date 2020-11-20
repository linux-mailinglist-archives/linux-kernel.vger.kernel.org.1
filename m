Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410092BB0FE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgKTQ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:56:11 -0500
Received: from netrider.rowland.org ([192.131.102.5]:55997 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730139AbgKTQ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:56:10 -0500
Received: (qmail 621944 invoked by uid 1000); 20 Nov 2020 11:56:09 -0500
Date:   Fri, 20 Nov 2020 11:56:09 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+44e64397bd81d5e84cba@syzkaller.appspotmail.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: memory leak in hub_event
Message-ID: <20201120165609.GE619708@rowland.harvard.edu>
References: <00000000000014163805b48b5063@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000014163805b48b5063@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 07:15:20AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4d02da97 Merge tag 'net-5.10-rc5' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a7d2b6500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c5353ac514ca5a43
> dashboard link: https://syzkaller.appspot.com/bug?extid=44e64397bd81d5e84cba
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14925089500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16810051500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+44e64397bd81d5e84cba@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff88810d5ff800 (size 2048):
>   comm "kworker/1:0", pid 17, jiffies 4294949188 (age 14.280s)
>   hex dump (first 32 bytes):
>     ff ff ff ff 31 00 00 00 00 00 00 00 00 00 00 00  ....1...........
>     00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00  ................
>   backtrace:
>     [<00000000f0428224>] kmalloc include/linux/slab.h:552 [inline]
>     [<00000000f0428224>] kzalloc include/linux/slab.h:664 [inline]
>     [<00000000f0428224>] usb_alloc_dev+0x32/0x450 drivers/usb/core/usb.c:582
>     [<000000001802b3dd>] hub_port_connect drivers/usb/core/hub.c:5128 [inline]
>     [<000000001802b3dd>] hub_port_connect_change drivers/usb/core/hub.c:5362 [inline]
>     [<000000001802b3dd>] port_event drivers/usb/core/hub.c:5508 [inline]
>     [<000000001802b3dd>] hub_event+0x118d/0x20d0 drivers/usb/core/hub.c:5590
>     [<0000000092d3650d>] process_one_work+0x27d/0x590 kernel/workqueue.c:2272
>     [<00000000d4629ab0>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2418
>     [<000000003c358b45>] kthread+0x178/0x1b0 kernel/kthread.c:292
>     [<000000003689dbb0>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

This looks like a reference is being taken but not released.  Hard to 
tell where it's happening, though.  Let's try to narrow it down.

Alan Stern

#syz test: upstream 4d02da97

Index: usb-devel/drivers/media/usb/gspca/gspca.c
===================================================================
--- usb-devel.orig/drivers/media/usb/gspca/gspca.c
+++ usb-devel/drivers/media/usb/gspca/gspca.c
@@ -1489,6 +1489,8 @@ int gspca_dev_probe2(struct usb_interfac
 	}
 
 	gspca_dev->v4l2_dev.release = gspca_release;
+	ret = -EIO;
+	goto out;
 	ret = v4l2_device_register(&intf->dev, &gspca_dev->v4l2_dev);
 	if (ret)
 		goto out;
