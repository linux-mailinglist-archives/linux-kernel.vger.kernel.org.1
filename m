Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0100E2E080D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 10:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgLVJYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 04:24:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgLVJYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 04:24:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C88DF23103;
        Tue, 22 Dec 2020 09:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608629009;
        bh=qCqELfT57AvpMFFVLIkE1zpXaxirvic0pVHoJrdiDf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXG6q1jDnolpc2Kco5fiYlkd1rYrT7BhErvPLh1wTOdPE3UaR8NT5QnzffHEX5/Y3
         3Mq4rBK4Q4NVT/7dMsnRGi9seBbVZhH1wlEfWRgffmC/7H3AgoVcUKpRjjWTDELEbU
         yPmZb+25uO9fYz8uhk1Yx6j/YrkntiJGSx3DNrPY8tBBvV0ayJiTR5BoAQmtjs6n2i
         CGmxviehaIdo/3+OZC90LSBzdi7XHGPd8sccX5LV9An1akhAlMUJo4CS8PbHZHfP6m
         XIUF0vPu0AkFve+KcXryLWhkKVFDpG1Wu8JULU3qT6V4ZIUl3OjhTR6nj6mkNdPH3M
         nbqooLM6dhBPA==
Received: by pali.im (Postfix)
        id 7CA6C848; Tue, 22 Dec 2020 10:23:27 +0100 (CET)
Date:   Tue, 22 Dec 2020 10:23:27 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: xhci-plat: fix support for XHCI_SKIP_PHY_INIT
 quirk
Message-ID: <20201222092327.jq5b7g4bffeccq3o@pali>
References: <20201221150903.26630-1-pali@kernel.org>
 <20201222021416.GB4706@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201222021416.GB4706@b29397-desktop>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 December 2020 02:14:45 Peter Chen wrote:
> On 20-12-21 16:09:03, Pali Rohár wrote:
> > Currently init_quirk callbacks for xhci platform drivers are called
> > xhci_plat_setup() function which is called after chip reset completes.
> > It happens in the middle of the usb_add_hcd() function.
> > 
> > But XHCI_SKIP_PHY_INIT quirk is checked in the xhci_plat_probe() function
> > prior calling usb_add_hcd() function. Therefore this XHCI_SKIP_PHY_INIT
> > currently does nothing as prior xhci_plat_setup() it is not set.
> > 
> > Quirk XHCI_SKIP_PHY_INIT is only setting hcd->skip_phy_initialization value
> > which really needs to be set prior calling usb_add_hcd() as this function
> > at its beginning skips PHY init if this member is set.
> > 
> > This patch fixes implementation of the XHCI_SKIP_PHY_INIT quirk by calling
> > init_quirk callbacks (via xhci_priv_init_quirk()) prior checking if
> > XHCI_SKIP_PHY_INIT is set.
> > 
> > Fixes: f768e718911e0 ("usb: host: xhci-plat: add priv quirk for skip PHY initialization")
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/usb/host/xhci-plat.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index 4d34f6005381..58704c5b002b 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -89,13 +89,6 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
> >  /* called during probe() after chip reset completes */
> >  static int xhci_plat_setup(struct usb_hcd *hcd)
> >  {
> > -	int ret;
> > -
> > -
> > -	ret = xhci_priv_init_quirk(hcd);
> > -	if (ret)
> > -		return ret;
> > -
> >  	return xhci_gen_setup(hcd, xhci_plat_quirks);
> >  }
> >  
> > @@ -330,6 +323,13 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >  
> >  	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
> >  	xhci->shared_hcd->tpl_support = hcd->tpl_support;
> > +
> > +	if (priv) {
> > +		ret = xhci_priv_init_quirk(hcd);
> > +		if (ret)
> > +			goto disable_usb_phy;
> > +	}
> > +
> >  	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
> >  		hcd->skip_phy_initialization = 1;
> >  
> 
> Hi Pali,
> 
> What's problem you have met? In structure xhci_plat_priv, the quirks are
> defined at .quirks entry which is got at below code. .init_quirk is the
> routine if special initializations are needed.

Hello!

I'm talking about .init_quirk. And if XHCI_SKIP_PHY_INIT quirk is set in
this function then has no effect.

I'm working currently on patch for xhci mvebu which conditionally enable
or disable XHCI_SKIP_PHY_INIT quirk (it is going to fix existing
regression since v5.1 kernel) and without this patch XHCI_SKIP_PHY_INIT
quirk from the init_quirk does not work.

> 	if (pdev->dev.of_node)
> 		priv_match = of_device_get_match_data(&pdev->dev);
> 	else
> 		priv_match = dev_get_platdata(&pdev->dev);
> 
> 	if (priv_match) {
> 		priv = hcd_to_xhci_priv(hcd);
> 		/* Just copy data for now */
> 		*priv = *priv_match;
> 	}
> -- 
> 
> Thanks,
> Peter Chen
