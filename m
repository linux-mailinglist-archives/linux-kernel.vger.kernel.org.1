Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72127259F78
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 21:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732760AbgIATwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 15:52:03 -0400
Received: from netrider.rowland.org ([192.131.102.5]:37225 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728711AbgIATwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:52:01 -0400
Received: (qmail 599608 invoked by uid 1000); 1 Sep 2020 15:51:59 -0400
Date:   Tue, 1 Sep 2020 15:51:59 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     gregkh@linuxfoundation.org, erkka.talvitie@vincit.fi,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC RESEND PATCH 0/1] USB EHCI: repeated resets on full and low
 speed devices
Message-ID: <20200901195159.GA599114@rowland.harvard.edu>
References: <cover.1598887346.git.khalid@gonehiking.org>
 <20200901023117.GD571008@rowland.harvard.edu>
 <608418fa-b0ce-c2a4-ad79-fe505c842587@oracle.com>
 <20200901163602.GG587030@rowland.harvard.edu>
 <4d1ab90a-ec55-85e8-d646-cfa58f08d449@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d1ab90a-ec55-85e8-d646-cfa58f08d449@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 11:00:16AM -0600, Khalid Aziz wrote:
> On 9/1/20 10:36 AM, Alan Stern wrote:
> > On Tue, Sep 01, 2020 at 09:15:46AM -0700, Khalid Aziz wrote:
> >> On 8/31/20 8:31 PM, Alan Stern wrote:
> >>> Can you collect a usbmon trace showing an example of this problem?
> >>>
> >>
> >> I have attached usbmon traces for when USB hub with keyboards and mouse
> >> is plugged into USB 2.0 port and when it is plugged into the NEC USB 3.0
> >> port.
> > 
> > The usbmon traces show lots of errors, but no Clear-TT events.  The 
> > large number of errors suggests that you've got a hardware problem; 
> > either a bad hub or bad USB connections.
> 
> That is what I thought initially which is why I got additional hubs and
> a USB 2.0 PCI card to test. I am seeing errors across 3 USB controllers,
> 4 USB hubs and 4 slow/full speed devices. All of the hubs and slow/full
> devices work with zero errors on my laptop. My keyboard/mouse devices
> and 2 of my USB hubs predate motherboard update and they all worked
> flawlessly before the motherboard upgrade. Some combinations of these
> also works with no errors on my desktop with new motherboard that I had
> listed in my original email:

It's a very puzzling situation.

One thing which probably would work well, surprisingly, would be to buy 
an old USB-1.1 hub and plug it into the PCI card.  That combination is 
likely to be similar to what you see when plugging the devices directly 
into the PCI card.  It might even work okay with the USB-3 controllers.

> 2. USB 2.0 controller - WORKS
> 5. USB 3.0/3.1 controller -> Bus powered USB 2.0 hub - WORKS
> 
> I am not seeing a common failure here that would point to any specific
> hardware being bad. Besides, that one code change (which I still can't
> say is the right code change) in ehci-q.c makes USB 2.0 controller work
> reliably with all my devices.

The USB and EHCI designs are flawed in that under the circumstances 
you're seeing, they don't have any way to tell the difference between a 
STALL and a host timing error.  The current code treats these situations 
as timing/transmission errors (resulting in device resets); your change 
causes them to be treated as STALLs.  However, there are known, common 
situations in which those same symptoms really are caused by 
transmission errors, so we don't want to start treating them as STALLs.

Besides, I suspect that your code change does _not_ make the USB-2 
controller work reliably with your devices.  You should collect a usbmon 
trace under those conditions; I predict it will be full of STALLs.  And 
furthermore, I believe these STALLs will not show up in a usbmon trace 
made with the devices plugged directly into the PCI card.  If I'm right 
about these things, the errors are still present even with your patch; 
all it does is hide them.

Short of a USB bus analyzer, however, there's no way to tell what's 
really going on.

Alan Stern
