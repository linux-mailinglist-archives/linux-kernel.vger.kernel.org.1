Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EEB26BECB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIPIGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgIPIF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:05:59 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0B2206F7;
        Wed, 16 Sep 2020 08:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600243559;
        bh=YH8QZ45DxgtnpiKJ/g+02MWWK+x7t7YaqSMeQTtf1Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuHKCHK+kHXq6akexAyOujiEs6R/UAx72faSGm0dfOhpNgCuvdXIPViM9o9CUah09
         i0UnGcnqzzeVas7uYLBChzPt8+Xbn5H5l28+G3efZQvX9ryzGJ8rrSycDEz5JBs2LD
         C/aIfqtaaFR4l0PseilWhziDe4O93bK5tiDXuMGg=
Date:   Wed, 16 Sep 2020 10:06:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Singh, Sandeep" <ssingh1@amd.com>
Cc:     Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sandeep.Singh@amd.com,
        yuanmei@lenovo.com
Subject: Re: [PATCH] xhci: workaround for S3 issue on AMD SNPS 3.0 xHC
Message-ID: <20200916080633.GB486670@kroah.com>
References: <20200831065246.1166470-1-Nehal-bakulchandra.Shah@amd.com>
 <1163986b-075f-8d5e-13dc-7141cb25e484@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163986b-075f-8d5e-13dc-7141cb25e484@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:28:40AM +0530, Singh, Sandeep wrote:
> On 8/31/2020 12:22 PM, Nehal Bakulchandra Shah wrote:
> > From: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
> > 
> > On some platform of AMD, S3 fails with HCE and SRE errors.To fix this,
> > sparse controller enable bit has to be disabled.
> > 
> > Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
> > ---
> >   drivers/usb/host/xhci-pci.c | 12 ++++++++++++
> >   drivers/usb/host/xhci.h     |  1 +
> >   2 files changed, 13 insertions(+)
> > 
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index 3feaafebfe58..865a16e6c1ed 100644
> > --- a/drivers/usb/host/xhci-pci.c
> > +++ b/drivers/usb/host/xhci-pci.c
> > @@ -160,6 +160,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
> >   	    (pdev->device == 0x15e0 || pdev->device == 0x15e1))
> >   		xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
> > +	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x15e5)
> > +		xhci->quirks |= XHCI_DISABLE_SPARSE;
> > +
> >   	if (pdev->vendor == PCI_VENDOR_ID_AMD)
> >   		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
> > @@ -371,6 +374,15 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >   	/* USB 2.0 roothub is stored in the PCI device now. */
> >   	hcd = dev_get_drvdata(&dev->dev);
> >   	xhci = hcd_to_xhci(hcd);
> > +
> > +	if (xhci->quirks & XHCI_DISABLE_SPARSE) {
> > +		u32 reg;
> > +
> > +		reg = readl(hcd->regs + 0xC12C);
> > +		reg &=  ~BIT(17);
> > +		writel(reg, hcd->regs + 0xC12C);
> > +	}
> > +
> >   	xhci->shared_hcd = usb_create_shared_hcd(&xhci_pci_hc_driver, &dev->dev,
> >   						 pci_name(dev), hcd);
> >   	if (!xhci->shared_hcd) {
> > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > index ea1754f185a2..ea966d70f1ee 100644
> > --- a/drivers/usb/host/xhci.h
> > +++ b/drivers/usb/host/xhci.h
> > @@ -1874,6 +1874,7 @@ struct xhci_hcd {
> >   #define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
> >   #define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
> >   #define XHCI_RENESAS_FW_QUIRK	BIT_ULL(36)
> > +#define XHCI_DISABLE_SPARSE	BIT_ULL(37)
> >   	unsigned int		num_active_eps;
> >   	unsigned int		limit_active_eps;
> 
> Any feedback on this patch?

Do you agree with it?  If so, can you review it and say so please?

thanks,

greg k-h
