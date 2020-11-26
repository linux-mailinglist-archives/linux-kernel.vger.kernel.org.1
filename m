Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0197D2C5902
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 17:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391167AbgKZQIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 11:08:31 -0500
Received: from netrider.rowland.org ([192.131.102.5]:59517 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730602AbgKZQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:08:31 -0500
Received: (qmail 828475 invoked by uid 1000); 26 Nov 2020 11:08:30 -0500
Date:   Thu, 26 Nov 2020 11:08:30 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:ehci:fix an interrupt calltrace error
Message-ID: <20201126160830.GA827745@rowland.harvard.edu>
References: <1606361673-573-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606361673-573-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 11:34:33AM +0800, Longfang Liu wrote:
> The system goes to suspend when using USB audio player. This causes
> the USB device continuous send interrupt signal to system, When the
> number of interrupts exceeds 100000, the system will forcibly close
> the interrupts and output a calltrace error.

This description is very confusing.  USB devices do not send interrupt 
signals to the host.  Do you mean that the device sends a wakeup 
request?  Or do you mean something else?

> When the system goes to suspend, the last interrupt is reported to
> the driver. At this time, the system has set the state to suspend.
> This causes the last interrupt to not be processed by the system and
> not clear the interrupt state flag. This uncleared interrupt flag
> constantly triggers new interrupt event. This causing the driver to
> receive more than 100,000 interrupts, which causes the system to
> forcibly close the interrupt report and report the calltrace error.

If the driver receives an interrupt, it is supposed to process the event 
even if the host controller is suspended.  And when ehci_irq() runs, it 
clears the bits that are set in the USBSYS register.

Why is your system getting interrupts?  That is, which bits are set in 
the USBSTS register?

> so, when the driver goes to sleep and changes the system state to
> suspend, the interrupt flag needs to be cleared.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/usb/host/ehci-hub.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
> index ce0eaf7..5b13825 100644
> --- a/drivers/usb/host/ehci-hub.c
> +++ b/drivers/usb/host/ehci-hub.c
> @@ -348,6 +348,11 @@ static int ehci_bus_suspend (struct usb_hcd *hcd)
>  
>  	/* Any IAA cycle that started before the suspend is now invalid */
>  	end_iaa_cycle(ehci);
> +
> +	/* clear interrupt status */
> +	if (ehci->has_synopsys_hc_bug)
> +		ehci_writel(ehci, INTR_MASK | STS_FLR, &ehci->regs->status);

This is a very strange place to add your new code -- right in the middle 
of the IAA and unlink handling.  Why not put it in a more reasonable 
place?

Also, the patch description does not mention has_synopsys_hc_bug.  The 
meaning of this flag has no connection with the interrupt status 
register, so why do you use it here?

> +
>  	ehci_handle_start_intr_unlinks(ehci);
>  	ehci_handle_intr_unlinks(ehci);
>  	end_free_itds(ehci);

Alan Stern
