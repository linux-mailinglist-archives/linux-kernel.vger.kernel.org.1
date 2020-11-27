Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D412C68EE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbgK0PrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:47:19 -0500
Received: from netrider.rowland.org ([192.131.102.5]:36021 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731135AbgK0PrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:47:19 -0500
Received: (qmail 862474 invoked by uid 1000); 27 Nov 2020 10:47:18 -0500
Date:   Fri, 27 Nov 2020 10:47:18 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     liulongfang <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:ehci:fix an interrupt calltrace error
Message-ID: <20201127154718.GA861473@rowland.harvard.edu>
References: <1606361673-573-1-git-send-email-liulongfang@huawei.com>
 <20201126160830.GA827745@rowland.harvard.edu>
 <96b4d366-c94c-9708-da12-5693bf16b716@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96b4d366-c94c-9708-da12-5693bf16b716@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 10:29:03AM +0800, liulongfang wrote:
> On 2020/11/27 0:08, Alan Stern Wrote:
> > On Thu, Nov 26, 2020 at 11:34:33AM +0800, Longfang Liu wrote:
> >> The system goes to suspend when using USB audio player. This causes
> >> the USB device continuous send interrupt signal to system, When the
> >> number of interrupts exceeds 100000, the system will forcibly close
> >> the interrupts and output a calltrace error.
> > 
> > This description is very confusing.  USB devices do not send interrupt 
> > signals to the host.  Do you mean that the device sends a wakeup 
> > request?  Or do you mean something else?
> The irq type is IRQ_NONE，It's counted in the note_interrupt function.
> From the analysis of the driver code, that are indeed  interrupt signals.

Above you wrote: "the USB device continuous send interrupt signal to 
system".  But that's not correct.  The interrupt signals are sent by the 
USB host controller, not by the USB audio device.

The patch description should mention that this happens only with some 
Synopsys host controllers.

> >> When the system goes to suspend, the last interrupt is reported to
> >> the driver. At this time, the system has set the state to suspend.
> >> This causes the last interrupt to not be processed by the system and
> >> not clear the interrupt state flag. This uncleared interrupt flag
> >> constantly triggers new interrupt event. This causing the driver to
> >> receive more than 100,000 interrupts, which causes the system to
> >> forcibly close the interrupt report and report the calltrace error.
> > 
> > If the driver receives an interrupt, it is supposed to process the event 
> > even if the host controller is suspended.  And when ehci_irq() runs, it 
> > clears the bits that are set in the USBSYS register.
> When the host controller is suspended, the ehci_suspend() will clear
> the HCD_FLAG_HW_ACCESSIBLE, and then usb_hcd_irq() will return IRQ_NONE
> directly without calling ehci_irq().

Yes.  But ehci_bus_suspend() runs _before_ the host controller is 
suspended.  While ehci_bus_suspend() is running, usb_hcd_irq() _will_ 
call ehci_irq(), and ehci_irq() _will_ clear the status bits.

After the host controller is suspended it is not supposed to generate 
any interrupt signals at all, because ehci_suspend() writes 0 to the 
USBINTR register, and it does this _before_ clearing 
HCD_FLAG_HW_ACCESSIBLE.

> > Why is your system getting interrupts?  That is, which bits are set in 
> > the USBSTS register?
> BIT(5) and BIT(3) are setted, STS_IAA and STS_FLR.

STS_FLR is not set in the USBINTR register, but STS_IAA is.  So that's 
the one which matters.

> >> so, when the driver goes to sleep and changes the system state to
> >> suspend, the interrupt flag needs to be cleared.
> >>
> >> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> >> ---
> >>  drivers/usb/host/ehci-hub.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
> >> index ce0eaf7..5b13825 100644
> >> --- a/drivers/usb/host/ehci-hub.c
> >> +++ b/drivers/usb/host/ehci-hub.c
> >> @@ -348,6 +348,11 @@ static int ehci_bus_suspend (struct usb_hcd *hcd)
> >>  
> >>  	/* Any IAA cycle that started before the suspend is now invalid */
> >>  	end_iaa_cycle(ehci);
> >> +
> >> +	/* clear interrupt status */
> >> +	if (ehci->has_synopsys_hc_bug)
> >> +		ehci_writel(ehci, INTR_MASK | STS_FLR, &ehci->regs->status);
> > 
> > This is a very strange place to add your new code -- right in the middle 
> > of the IAA and unlink handling.  Why not put it in a more reasonable 
> > place?After the IAA is processed, clear the STS_IAA interrupt state flag.
> > 
> > Also, the patch description does not mention has_synopsys_hc_bug.  The 
> > meaning of this flag has no connection with the interrupt status 
> > register, so why do you use it here?
> Because of our USB IP comes from Synopsys, and the uncleared flage is also caused by
> special hardware design, in addition, we have not tested other manufacturers' USB
> controllers.We don’t know if other manufacturers’ designs have this problem,
> so this modification is only limited to this kind of design.

Clearing the STS_IAA flag won't hurt, no matter who manufactured the 
controller.  So your patch should look more like this:

+	/* Some Synopsys controllers mistakenly leave IAA turned on */
+	ehci_writel(ehci, STS_IAA, &ehci->regs->status);

And these lines should come before the "Any IAA cycle..." comment line.
Does that fix the problem?

Alan Stern
