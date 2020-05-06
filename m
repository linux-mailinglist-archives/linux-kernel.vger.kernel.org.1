Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC391C7AF3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 22:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgEFUJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 16:09:26 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39241 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728166AbgEFUJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:09:25 -0400
Received: (qmail 17008 invoked by uid 500); 6 May 2020 16:09:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 May 2020 16:09:24 -0400
Date:   Wed, 6 May 2020 16:09:24 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Pete Zaitcev <zaitcev@redhat.com>
cc:     Oliver Neukum <oneukum@suse.com>,
        syzbot <syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com>,
        <andreyknvl@google.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in usblp_bulk_read
In-Reply-To: <20200506114732.5f81c8c5@suzdal.zaitcev.lan>
Message-ID: <Pine.LNX.4.44L0.2005061607310.16154-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020, Pete Zaitcev wrote:

> On Wed, 06 May 2020 11:14:42 +0200
> Oliver Neukum <oneukum@suse.com> wrote:
> 
> > Very well. We are not going to find it without exceptional luck. Yet
> > there may be a real issue, too. We simply do not know. How about the
> > attached patch?
> 
> >  	usblp_unlink_urbs(usblp);
> >  	mutex_unlock(&usblp->mut);
> > +	usb_poison_anchored_urbs(&usblp->urbs);
> >  
> >  	if (!usblp->used)
> >  		usblp_cleanup(usblp);
> 
> This can't be right. Our URBs are freed by the callback, and this
> technique is not compatible with poisoning, at least with how the
> usb/core.c implements it. The usb_poison_urb() waits for URB
> to complete, and if the callback frees it, it's a problem.

That's not a problem.  URBs are reference-counted, and 
usb_poison_anchored_urbs() does usb_get_urb() before and usb_put_urb() 
after calling usb_poison_urb().

Alan Stern

