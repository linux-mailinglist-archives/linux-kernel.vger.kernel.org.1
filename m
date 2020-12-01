Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D62CA651
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403938AbgLAOvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:51:35 -0500
Received: from netrider.rowland.org ([192.131.102.5]:33877 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2389627AbgLAOve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:51:34 -0500
Received: (qmail 1007173 invoked by uid 1000); 1 Dec 2020 09:50:53 -0500
Date:   Tue, 1 Dec 2020 09:50:53 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+dbec6695a6565a9c6bc0@syzkaller.appspotmail.com>,
        eli.billauer@gmail.com, gustavoars@kernel.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tiwai@suse.de
Subject: Re: WARNING in port100_send_frame_async/usb_submit_urb
Message-ID: <20201201145053.GA1005384@rowland.harvard.edu>
References: <000000000000bab70f05b563a6cc@google.com>
 <20201201094702.1762-1-hdanton@sina.com>
 <X8YT6sbhhGwQ06nw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8YT6sbhhGwQ06nw@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:59:06AM +0100, Greg KH wrote:
> On Tue, Dec 01, 2020 at 05:47:02PM +0800, Hillf Danton wrote:
> > On Tue, 01 Dec 2020 01:21:27 -0800
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    c84e1efa Merge tag 'asm-generic-fixes-5.10-2' of git://git..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14a98565500000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=7be70951fca93701
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=dbec6695a6565a9c6bc0
> > > compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c607f1500000
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+dbec6695a6565a9c6bc0@syzkaller.appspotmail.com
> > > 
> > > usb 1-1: string descriptor 0 read error: -32
> > > ------------[ cut here ]------------
> > > URB 000000005c26bc1e submitted while active

> > Clear urb before putting it in use.
> > 
> > --- a/drivers/nfc/port100.c
> > +++ b/drivers/nfc/port100.c
> > @@ -1525,7 +1525,7 @@ static int port100_probe(struct usb_inte
> >  	}
> >  
> >  	dev->in_urb = usb_alloc_urb(0, GFP_KERNEL);
> > -	dev->out_urb = usb_alloc_urb(0, GFP_KERNEL);
> > +	dev->out_urb = usb_alloc_urb(0, GFP_KERNEL | __GFP_ZERO);
> >  
> >  	if (!dev->in_urb || !dev->out_urb) {
> >  		nfc_err(&interface->dev, "Could not allocate USB URBs\n");
> 
> How does this solve a warning in the USB core about a string descriptor
> error?

Greg, you misread the bug report.  The problem wasn't the string 
descriptor read error; it was URB submitted while active.

More to the point, adding __GFP_ZERO to the usb_alloc_urb call won't fix 
anything, because usb_alloc_urb calls usb_init_urb, which already does a 
memset.

Alan Stern
