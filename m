Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACB26BEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgIPIFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgIPIFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:05:38 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D379206F7;
        Wed, 16 Sep 2020 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600243536;
        bh=PXonysa+tT/6CqDi5Z+eq6VJBEer1HQVn8ZiwBcB57M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLq2lKlywQO2jxnJJq9gXYTahJFQ76wP04GoHJi/71nfdHgEloCs+tzftumEmQATF
         8h5qdNE5qtBDoUNkaWCmXbEAhBGEIrDHSgsWNHdvpa5VRQiJfglQJcPYdB9d1KziNa
         zl8I+tUhIKg2dnW/eKQ8Vt7+rAKwI1WQwVzpG4A4=
Date:   Wed, 16 Sep 2020 10:06:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sandeep.Singh@amd.com,
        yuanmei@lenovo.com
Subject: Re: [PATCH] xhci: workaround for S3 issue on AMD SNPS 3.0 xHC
Message-ID: <20200916080611.GA486670@kroah.com>
References: <20200831065246.1166470-1-Nehal-bakulchandra.Shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831065246.1166470-1-Nehal-bakulchandra.Shah@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 06:52:46AM +0000, Nehal Bakulchandra Shah wrote:
> From: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
> 
> On some platform of AMD, S3 fails with HCE and SRE errors.To fix this,
> sparse controller enable bit has to be disabled.
> 
> Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
> ---
>  drivers/usb/host/xhci-pci.c | 12 ++++++++++++
>  drivers/usb/host/xhci.h     |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 3feaafebfe58..865a16e6c1ed 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -160,6 +160,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  	    (pdev->device == 0x15e0 || pdev->device == 0x15e1))
>  		xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x15e5)
> +		xhci->quirks |= XHCI_DISABLE_SPARSE;
> +
>  	if (pdev->vendor == PCI_VENDOR_ID_AMD)
>  		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>  
> @@ -371,6 +374,15 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	/* USB 2.0 roothub is stored in the PCI device now. */
>  	hcd = dev_get_drvdata(&dev->dev);
>  	xhci = hcd_to_xhci(hcd);
> +
> +	if (xhci->quirks & XHCI_DISABLE_SPARSE) {
> +		u32 reg;
> +
> +		reg = readl(hcd->regs + 0xC12C);
> +		reg &=  ~BIT(17);

Odd spacing :(

Anyway, what is magic bit 17?  Shouldn't that be documented somewhere?

And you forgot to handle endian issues here, right?

> +		writel(reg, hcd->regs + 0xC12C);

Same for this magic address, shouldn't you document that here please?

And is this the proper place to be testing for quirks and applying them?
Why not do the above in the xhci_pci_quirks() call?

thanks,

greg k-h
