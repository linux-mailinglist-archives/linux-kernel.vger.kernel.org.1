Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D38296F43
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463700AbgJWMdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S372849AbgJWMdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:33:02 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B5A52085B;
        Fri, 23 Oct 2020 12:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603456381;
        bh=TNRR7/M3AEKNKNlsmZFwHSJ4YLOIMqgPUbjhjdrwxfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3hchsKB07rfOmgF1gJ/sk6kEXv3DbgvF237KxqD794TK+r14xresTMi7l1AbmRdy
         Ks0XQa7vIz9GWpWt6c40CJWOhrz9WC7PPtJTQOgzcJ2yGMDGezPtW1ew4OurUKKzrv
         4DMJ+9Abm4q5Z35RUC3QZ7u1t7J2nJrnQEkgpSdc=
Date:   Fri, 23 Oct 2020 14:33:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanket.goswami@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH] usb: xhci: Workaround for S3 issue on AMD SNPS 3.0 xHC
Message-ID: <20201023123336.GA2493208@kroah.com>
References: <20201023122713.460551-1-Sandeep.Singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023122713.460551-1-Sandeep.Singh@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 05:57:13PM +0530, Sandeep Singh wrote:
> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> On some platform of AMD, S3 fails with HCE and SRE errors. To fix this,
> need to disable a bit which is enable in sparse controller.
> 
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> ---
>  drivers/usb/host/xhci-pci.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index c26c06e5c88c..bf89172c43ca 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -23,6 +23,8 @@
>  #define SSIC_PORT_CFG2_OFFSET	0x30
>  #define PROG_DONE		(1 << 30)
>  #define SSIC_PORT_UNUSED	(1 << 31)
> +#define SPARSE_DISABLE_BIT	17
> +#define SPARSE_CNTL_ENABLE	0xC12C
>  
>  /* Device for a quirk */
>  #define PCI_VENDOR_ID_FRESCO_LOGIC	0x1b73
> @@ -161,6 +163,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  	    (pdev->device == 0x15e0 || pdev->device == 0x15e1))
>  		xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x15e5)
> +		xhci->quirks |= XHCI_DISABLE_SPARSE;
> +
>  	if (pdev->vendor == PCI_VENDOR_ID_AMD)
>  		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>  
> @@ -498,6 +503,15 @@ static void xhci_pme_quirk(struct usb_hcd *hcd)
>  	readl(reg);
>  }
>  
> +static void xhci_sparse_control_quirk(struct usb_hcd *hcd)
> +{
> +	u32 reg;
> +
> +	reg = readl(hcd->regs + SPARSE_CNTL_ENABLE);
> +	reg &= ~BIT(SPARSE_DISABLE_BIT);
> +	writel(reg, hcd->regs + SPARSE_CNTL_ENABLE);
> +}
> +
>  static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
>  {
>  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> @@ -517,6 +531,9 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
>  	if (xhci->quirks & XHCI_SSIC_PORT_UNUSED)
>  		xhci_ssic_port_unused_quirk(hcd, true);
>  
> +	if (xhci->quirks & XHCI_DISABLE_SPARSE)
> +		xhci_sparse_control_quirk(hcd);
> +
>  	ret = xhci_suspend(xhci, do_wakeup);
>  	if (ret && (xhci->quirks & XHCI_SSIC_PORT_UNUSED))
>  		xhci_ssic_port_unused_quirk(hcd, false);
> -- 
> 2.25.1
> 

Does this build?  There is no XHCI_DISABLE_SPARSE in the kernel tree at
the moment...

greg k-h
