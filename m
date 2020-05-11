Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E51CE4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 21:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgEKTvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 15:51:06 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59711 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729501AbgEKTvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:51:06 -0400
Received: (qmail 19143 invoked by uid 500); 11 May 2020 15:51:05 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 May 2020 15:51:05 -0400
Date:   Mon, 11 May 2020 15:51:05 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Al Cooper <alcooperx@gmail.com>
cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v9 4/5] usb: ehci: Add new EHCI driver for Broadcom STB
 SoC's
In-Reply-To: <20200511193643.30926-5-alcooperx@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2005111542310.11417-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020, Al Cooper wrote:

> Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
> was created instead of adding support to the existing ehci platform
> driver because of the code required to work around bugs in the EHCI
> controller. The primary workaround is for a bug where the Core
> violates the SOF interval between the first two SOFs transmitted after
> resume. This only happens if the resume occurs near the end of a
> microframe. The fix is to intercept the ehci-hcd request to complete
> RESUME and align it to the start of the next microframe.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

I hate to point this out...

> +static int ehci_brcm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res_mem;
> +	struct brcm_priv *priv;
> +	struct usb_hcd *hcd;
> +	int irq;
> +	int err;
> +
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	if (err)
> +		return err;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0)
> +		return irq ? irq : EINVAL;

That should be -EINVAL.

To tell the truth, I'm not sure it's worthwhile checking for irq == 0.  
That's up to Greg to decide.

Anyway, as far as I'm concerned you can either change EINVAL to -EINVAL
or change the whole thing back to "if (irq < 0) return irq;".  Either
way, you may add:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

