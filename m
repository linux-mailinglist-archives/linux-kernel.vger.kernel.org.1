Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943F6268C97
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgINNxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:53:19 -0400
Received: from netrider.rowland.org ([192.131.102.5]:37257 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726721AbgINNsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:48:52 -0400
Received: (qmail 963410 invoked by uid 1000); 14 Sep 2020 09:48:43 -0400
Date:   Mon, 14 Sep 2020 09:48:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux@prisktech.co.nz, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: host: ehci-platform: Add workaround for
 brcm,xgs-iproc-ehci
Message-ID: <20200914134843.GA963127@rowland.harvard.edu>
References: <20200913215926.29880-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913215926.29880-1-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 09:59:26AM +1200, Chris Packham wrote:
> The ehci controller found in some Broadcom switches with integrated SoCs
> has an issue which causes a soft lockup with large transfers like you
> see when running ext4 on USB3 flash drive.
> 
> Port the fix from the Broadcom XLDK to increase the OUT_THRESHOLD to
> avoid the problem.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> I don't have much data on what this change does. I can say it is needed to
> avoid a soft lockup when using a USB3 Flash drive formatted has ext4 (USB2 +
> ext4 is OK, USB3 + fat is OK). I presume the affected combination ends up using
> larger transfers triggering the problem.
> 
> The equivalent change in the Broadcom XLDK is
> 
> 	if (IS_ENABLED(CONFIG_USB_EHCI_XGS_IPROC))
> 		ehci_writel(ehci, BCM_USB_FIFO_THRESHOLD,
> 				&ehci->regs->reserved4[6]);
> 
> This is problematic because it would unconditionally apply to all ehci
> controllers whenever CONFIG_USB_EHCI_XGS_IPROC is enabled (also reserved4 only
> goes to 6 so technically it's indexing off the end of the array).
> 
> I wasn't sure if I should add a new property or somehow detect the affected
> host controller. I settled on using of_device_is_compatible() as that seemed
> the simplest thing to do.
> 
> Changes in v2:
> - move workaround to ehci_platform_reset
> - cosmetic changes suggested by Alan
> 
>  drivers/usb/host/ehci-platform.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 006c4f6188a5..9804ffa9e67f 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -42,6 +42,9 @@
>  #define EHCI_MAX_CLKS 4
>  #define hcd_to_ehci_priv(h) ((struct ehci_platform_priv *)hcd_to_ehci(h)->priv)
>  
> +#define BCM_USB_FIFO_THRESHOLD	0x00800040
> +#define bcm_iproc_insnreg01	hostpc[0]
> +
>  struct ehci_platform_priv {
>  	struct clk *clks[EHCI_MAX_CLKS];
>  	struct reset_control *rsts;
> @@ -75,6 +78,11 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>  
>  	if (pdata->no_io_watchdog)
>  		ehci->need_io_watchdog = 0;
> +
> +	if (of_device_is_compatible(pdev->dev.of_node, "brcm,xgs-iproc-ehci"))
> +		ehci_writel(ehci, BCM_USB_FIFO_THRESHOLD,
> +			    &ehci->regs->bcm_iproc_insnreg01);
> +
>  	return 0;
>  }

Acked-by: Alan Stern <stern@rowland.harvard.edu>
