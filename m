Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0212775C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgIXPuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:50:06 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35431 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728139AbgIXPuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:50:06 -0400
Received: (qmail 1341527 invoked by uid 1000); 24 Sep 2020 11:50:05 -0400
Date:   Thu, 24 Sep 2020 11:50:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, jackp@codeaurora.org
Subject: Re: [PATCH v3] usb: dwc3: Stop active transfers before halting the
 controller
Message-ID: <20200924155005.GB1337044@rowland.harvard.edu>
References: <20200903210954.24504-1-wcheng@codeaurora.org>
 <87o8mi151l.fsf@kernel.org>
 <010101746fab2ee1-91b46c27-fef0-4266-94cb-14dea5ca350e-000000@us-west-2.amazonses.com>
 <877dsjei8j.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dsjei8j.fsf@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:39:24AM +0300, Felipe Balbi wrote:
> >>> +	/*
> >>> +	 * Synchronize and disable any further event handling while controller
> >>> +	 * is being enabled/disabled.
> >>> +	 */
> >>> +	disable_irq(dwc->irq_gadget);
> >> 
> >> why isn't dwc3_gadget_disable_irq() enough?
> >> 
> >>>  	spin_lock_irqsave(&dwc->lock, flags);
> >> 
> >> spin_lock_irqsave() will disable interrupts, why disable_irq() above?
> >> 
> >
> > In the discussion I had with Thinh, the concern was that with the newly
> > added code to override the lpos here, if the interrupt routine
> > (dwc3_check_event_buf()) runs, then it will reference the lpos for
> 
> that's running in hardirq context. All interrupts are disabled while
> that runs, there's no risk of race, right?
> 
> > copying the event buffer contents to the event cache, and potentially
> > process events.  There is no locking in place, so it could be possible
> > to have both run in parallel.
> 
> Is this academic or have you actually found a situation where this
> could, indeed, happen? The spin_lock_irqsave() should be enough to
> synchronize dwc3_gadget_pullup() and the interrupt handler.
> 
> > Hence, the reason if there was already a pending IRQ triggered, the
> > dwc3_gadget_disable_irq() won't ensure the IRQ is handled.  We can do
> > something like:
> > if (!is_on)
> > 	dwc3_gadget_disable_irq()
> > synchronize_irq()
> > spin_lock_irqsave()
> > if(!is_on) {
> > ...
> >
> > But the logic to only apply this on the pullup removal case is a little
> > messy.  Also, from my understanding, the spin_lock_irqsave() will only
> > disable the local CPU IRQs, but not the interrupt line on the GIC, which
> > means other CPUs can handle it, unless we explicitly set the IRQ
> > affinity to CPUX.
> 
> Yeah, the way I understand this can't really happen. But I'm open to
> being educated. Maybe Alan can explain if this is really possibility?

It depends on the details of the hardware, but yes, it is possible in
general for an interrupt handler to run after you have turned off the
device's interrupt-request line.  For example:

	CPU A				CPU B
	---------------------------	----------------------
	Gets an IRQ from the device
	Calls handler routine		spin_lock_irq
	  spin_lock_irq			Turns off the IRQ line
	  ...spins...			spin_unlock_irq
	  Rest of handler runs
	  spin_unlock_irq

That's why we have synchronize_irq().  The usual pattern is something
like this:

	spin_lock_irq(&priv->lock);
	priv->disconnected = true;
	my_disable_irq(priv);
	spin_unlock_irq(&priv->lock);
	synchronize_irq(priv->irq);

And of course this has to be done in a context that can sleep.

Does this answer your question?

Alan Stern
