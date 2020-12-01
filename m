Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8D72C9E76
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391071AbgLAJ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgLAJ6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:58:34 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D773204FD;
        Tue,  1 Dec 2020 09:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606816674;
        bh=ejPW1efOfPUTaOqTDryktqI2qtZ6U8BFdeUype6/NQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOqbIBHIvv5MA7u7TjwN7gBR4xDTJevs4m3kPl3e/niLZogKEdI2IS7uhmy0IrBaf
         co8vY9U0k+F+suYdeh08v42h6k3HSI+BFyPHDn7HoSP/eFEx8tvVbACVpdP0iiGz2s
         JtmsI0fRerXeuQHOUucU4W1IgfKfnH/chQsSDDys=
Date:   Tue, 1 Dec 2020 10:59:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+dbec6695a6565a9c6bc0@syzkaller.appspotmail.com>,
        eli.billauer@gmail.com, gustavoars@kernel.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tiwai@suse.de
Subject: Re: WARNING in port100_send_frame_async/usb_submit_urb
Message-ID: <X8YT6sbhhGwQ06nw@kroah.com>
References: <000000000000bab70f05b563a6cc@google.com>
 <20201201094702.1762-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201094702.1762-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 05:47:02PM +0800, Hillf Danton wrote:
> On Tue, 01 Dec 2020 01:21:27 -0800
> > syzbot found the following issue on:
> > 
> > HEAD commit:    c84e1efa Merge tag 'asm-generic-fixes-5.10-2' of git://git..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14a98565500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7be70951fca93701
> > dashboard link: https://syzkaller.appspot.com/bug?extid=dbec6695a6565a9c6bc0
> > compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c607f1500000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+dbec6695a6565a9c6bc0@syzkaller.appspotmail.com
> > 
> > usb 1-1: string descriptor 0 read error: -32
> > ------------[ cut here ]------------
> > URB 000000005c26bc1e submitted while active
> > WARNING: CPU: 0 PID: 5 at drivers/usb/core/urb.c:378 usb_submit_urb+0xf57/0x1510 drivers/usb/core/urb.c:378
> > Modules linked in:
> > CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.10.0-rc5-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > RIP: 0010:usb_submit_urb+0xf57/0x1510 drivers/usb/core/urb.c:378
> > Code: 5c 41 5d 41 5e 41 5f 5d e9 76 5b ff ff e8 f1 e8 04 fc c6 05 25 0e 8b 07 01 48 c7 c7 a0 b7 5b 8a 4c 89 e6 31 c0 e8 89 07 d5 fb <0f> 0b e9 20 f1 ff ff e8 cd e8 04 fc eb 05 e8 c6 e8 04 fc bb a6 ff
> > RSP: 0018:ffffc90000ca6ec8 EFLAGS: 00010246
> > RAX: cf72e284cb303700 RBX: ffff888021723708 RCX: ffff888011108000
> > RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> > RBP: 0000000000000cc0 R08: ffffffff815d29f2 R09: ffffed1017383ffc
> > R10: ffffed1017383ffc R11: 0000000000000000 R12: ffff888021723700
> > R13: dffffc0000000000 R14: ffff888012cfa458 R15: 1ffff1100259f489
> > FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000056157313d160 CR3: 000000001e22c000 CR4: 00000000001506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  port100_send_frame_async+0x1ea/0x390 drivers/nfc/port100.c:780
> >  port100_send_cmd_async+0x6c7/0x950 drivers/nfc/port100.c:876
> >  port100_send_cmd_sync drivers/nfc/port100.c:916 [inline]
> >  port100_set_command_type drivers/nfc/port100.c:987 [inline]
> >  port100_probe+0xd4f/0x1600 drivers/nfc/port100.c:1567
> >  usb_probe_interface+0x662/0xb40 drivers/usb/core/driver.c:396
> >  really_probe+0x4ab/0x1380 drivers/base/dd.c:558
> >  driver_probe_device+0x15b/0x310 drivers/base/dd.c:738
> >  bus_for_each_drv+0x108/0x170 drivers/base/bus.c:431
> >  __device_attach+0x2c9/0x480 drivers/base/dd.c:912
> >  bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:491
> >  device_add+0x1612/0x19e0 drivers/base/core.c:2936
> >  usb_set_configuration+0x1c17/0x2100 drivers/usb/core/message.c:2159
> >  usb_generic_driver_probe+0x82/0x140 drivers/usb/core/generic.c:238
> >  usb_probe_device+0x13a/0x260 drivers/usb/core/driver.c:293
> >  really_probe+0x4ab/0x1380 drivers/base/dd.c:558
> >  driver_probe_device+0x15b/0x310 drivers/base/dd.c:738
> >  bus_for_each_drv+0x108/0x170 drivers/base/bus.c:431
> >  __device_attach+0x2c9/0x480 drivers/base/dd.c:912
> >  bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:491
> >  device_add+0x1612/0x19e0 drivers/base/core.c:2936
> >  usb_new_device+0xcc3/0x1700 drivers/usb/core/hub.c:2554
> >  hub_port_connect+0xec7/0x2540 drivers/usb/core/hub.c:5222
> >  hub_port_connect_change+0x600/0xb00 drivers/usb/core/hub.c:5362
> >  port_event+0xae9/0x10a0 drivers/usb/core/hub.c:5508
> >  hub_event+0x417/0xcb0 drivers/usb/core/hub.c:5590
> >  process_one_work+0x789/0xfc0 kernel/workqueue.c:2272
> >  worker_thread+0xaa4/0x1460 kernel/workqueue.c:2418
> >  kthread+0x39a/0x3c0 kernel/kthread.c:292
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> Clear urb before putting it in use.
> 
> --- a/drivers/nfc/port100.c
> +++ b/drivers/nfc/port100.c
> @@ -1525,7 +1525,7 @@ static int port100_probe(struct usb_inte
>  	}
>  
>  	dev->in_urb = usb_alloc_urb(0, GFP_KERNEL);
> -	dev->out_urb = usb_alloc_urb(0, GFP_KERNEL);
> +	dev->out_urb = usb_alloc_urb(0, GFP_KERNEL | __GFP_ZERO);
>  
>  	if (!dev->in_urb || !dev->out_urb) {
>  		nfc_err(&interface->dev, "Could not allocate USB URBs\n");

How does this solve a warning in the USB core about a string descriptor
error?
