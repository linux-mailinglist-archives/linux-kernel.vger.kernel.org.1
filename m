Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1B2F1BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389209AbhAKRHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:07:45 -0500
Received: from netrider.rowland.org ([192.131.102.5]:55143 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388333AbhAKRHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:07:44 -0500
Received: (qmail 1201009 invoked by uid 1000); 11 Jan 2021 12:07:03 -0500
Date:   Mon, 11 Jan 2021 12:07:03 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, yisen.zhuang@huawei.com,
        kong.kongxinwei@hisilicon.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB:ehci:fix an interrupt calltrace error
Message-ID: <20210111170703.GD1196682@rowland.harvard.edu>
References: <1610364577-11617-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610364577-11617-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 07:29:37PM +0800, Longfang Liu wrote:
> The system that use Synopsys USB host controllers goes to suspend
> when using USB audio player. This causes the USB host controller
> continuous send interrupt signal to system, When the number of
> interrupts exceeds 100000, the system will forcibly close the
> interrupts and output a calltrace error.
> 
> When the system goes to suspend, the last interrupt is reported to
> the driver. At this time, the system has set the state to suspend.
> This causes the last interrupt to not be processed by the system and
> not clear the interrupt flag. This uncleared interrupt flag constantly
> triggers new interrupt event. This causing the driver to receive more
> than 100,000 interrupts, which causes the system to forcibly close the
> interrupt report and report the calltrace error.
> 
> so, when the driver goes to sleep and changes the system state to
> suspend, the interrupt flag needs to be cleared.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
> 
> Changes in v2:
> - updated cleared registers
> 
>  drivers/usb/host/ehci-hub.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
> index ce0eaf7..a99c1ac 100644
> --- a/drivers/usb/host/ehci-hub.c
> +++ b/drivers/usb/host/ehci-hub.c
> @@ -346,8 +346,12 @@ static int ehci_bus_suspend (struct usb_hcd *hcd)
>  
>  	unlink_empty_async_suspended(ehci);
>  
> +	/* Some Synopsys controllers mistakenly leave IAA turned on */
> +	ehci_writel(ehci, STS_IAA, &ehci->regs->status);
> +
>  	/* Any IAA cycle that started before the suspend is now invalid */
>  	end_iaa_cycle(ehci);
> +
>  	ehci_handle_start_intr_unlinks(ehci);
>  	ehci_handle_intr_unlinks(ehci);
>  	end_free_itds(ehci);
> -- 
> 2.8.1
> 
