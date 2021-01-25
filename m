Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F86303223
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 03:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbhAYO2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 09:28:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbhAYOVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:21:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4006322D04;
        Mon, 25 Jan 2021 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611584431;
        bh=sEglrBhCkTFr5BdNLgbZgDjh5fXwZi1Z90ubhU0dnxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHaee/tFDk2oBtwNZNxOv2toWxPRC7RtqEsPPCqloeARzFvyr6Qc+tnwSnuX7EJWQ
         Z0rGkfVxMeyBGKtbdpG648HGxwLL8XwQhtIZBsKumPBvYqU8RwhLI/QCtL5zEkUOkr
         zAaFCXgL+nOmeztOZGp2OuBZL/zpF6+SqNXJ5kC8lFS4rjoqASr8+Ya8y0mzwPDFBD
         68iNvmmgu4I9M6KOgK96ZGVOG0ZkpFwm5F3QOAd8oyWbAeyJCpqs58/Q0yxLxaXBQZ
         zUjsfIxSRT7IGzxod+MQZT9hE1E8ee4NbpjqzmqcfWywUuyoWdOP0vEZLAQpZe0pI/
         jPvVylhfU1ZHQ==
Received: by pali.im (Postfix)
        id D08B4768; Mon, 25 Jan 2021 15:20:28 +0100 (CET)
Date:   Mon, 25 Jan 2021 15:20:28 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Peter Chen <peter.chen@nxp.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v2] usb: host: xhci-plat: fix support for
 XHCI_SKIP_PHY_INIT quirk
Message-ID: <20210125142028.th4sscs27arhihm2@pali>
References: <20201221150903.26630-1-pali@kernel.org>
 <20201223161847.10811-1-pali@kernel.org>
 <20201224055836.GB27629@b29397-desktop>
 <20210113232057.niqamgsqlaw7gojw@pali>
 <88b48c61-65e4-cc24-d90d-5fba92f05f27@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88b48c61-65e4-cc24-d90d-5fba92f05f27@linux.intel.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 January 2021 15:32:30 Mathias Nyman wrote:
> On 14.1.2021 1.20, Pali Rohár wrote:
> > On Thursday 24 December 2020 05:59:05 Peter Chen wrote:
> >> On 20-12-23 17:18:47, Pali Rohár wrote:
> >>> Currently init_quirk callbacks for xhci platform drivers are called
> >>> xhci_plat_setup() function which is called after chip reset completes.
> >>> It happens in the middle of the usb_add_hcd() function.
> >>>
> >>> But XHCI_SKIP_PHY_INIT quirk is checked in the xhci_plat_probe() function
> >>> prior calling usb_add_hcd() function. Therefore this XHCI_SKIP_PHY_INIT
> >>> currently does nothing as prior xhci_plat_setup() it is not set.
> >>>
> >>> Quirk XHCI_SKIP_PHY_INIT is only setting hcd->skip_phy_initialization value
> >>> which really needs to be set prior calling usb_add_hcd() as this function
> >>> at its beginning skips PHY init if this member is set.
> >>>
> >>> This patch fixes implementation of the XHCI_SKIP_PHY_INIT quirk by calling
> >>> init_quirk callbacks (via xhci_priv_init_quirk()) prior checking if
> >>> XHCI_SKIP_PHY_INIT is set. Also checking if either xhci->quirks or
> >>> priv->quirks contains this XHCI_SKIP_PHY_INIT quirk.
> >>>
> >>> Signed-off-by: Pali Rohár <pali@kernel.org>
> >>>
> >>> ---
> >>> Changes in v2:
> >>> * Check also xhci->quirks as xhci_priv_init_quirk() callbacks are setting xhci->quirks
> >>> * Tested with "usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada 3720" patch
> >>> * Removed Fixes: line
> >>> ---
> >>>  drivers/usb/host/xhci-plat.c | 16 ++++++++--------
> >>>  1 file changed, 8 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> >>> index 4d34f6005381..0eab7cb5a767 100644
> >>> --- a/drivers/usb/host/xhci-plat.c
> >>> +++ b/drivers/usb/host/xhci-plat.c
> >>> @@ -89,13 +89,6 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
> >>>  /* called during probe() after chip reset completes */
> >>>  static int xhci_plat_setup(struct usb_hcd *hcd)
> >>>  {
> >>> -	int ret;
> >>> -
> >>> -
> >>> -	ret = xhci_priv_init_quirk(hcd);
> >>> -	if (ret)
> >>> -		return ret;
> >>> -
> >>>  	return xhci_gen_setup(hcd, xhci_plat_quirks);
> >>>  }
> >>>  
> >>> @@ -330,7 +323,14 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >>>  
> >>>  	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
> >>>  	xhci->shared_hcd->tpl_support = hcd->tpl_support;
> >>> -	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
> >>> +
> >>> +	if (priv) {
> >>> +		ret = xhci_priv_init_quirk(hcd);
> >>> +		if (ret)
> >>> +			goto disable_usb_phy;
> >>> +	}
> >>> +
> >>> +	if ((xhci->quirks & XHCI_SKIP_PHY_INIT) || (priv && (priv->quirks & XHCI_SKIP_PHY_INIT)))
> >>>  		hcd->skip_phy_initialization = 1;
> >>
> >> I am not sure if others agree with you move the position of
> >> xhci_priv_init_quirk, Let's see Mathias opinion.
> > 
> > Hello! Do you have an opinion how to handle this issue? As currently it
> > is needed for another patch which is fixing issue/regression in xhci-mvebu:
> > https://lore.kernel.org/linux-usb/20201223162403.10897-1-pali@kernel.org/
> > 
> 
> I can see the benefit in this. 
> In the xhci-plat case usb_create_hcd and usb_add_hcd are separate steps, and
> we could both copy the xhci_plat_priv .quirks and run the .init_qurks before
> adding the hcd.
> I guess the current way is inherited from pci case where the earliest place
> to do this after hcd is created is the hcd->driver->reset callback (which is
> set to xhci_pci_setup() or xhci_plat_setup()).
> 
> xhci-rcar.c is using the .init_quirk to load firmware, we need to check with
> them if this change is ok. (added Yoshihiro Shimoda to cc)

Yoshihiro, is this change OK?

Can we move forward? I really need to now how to handle regression in
xhci-mvebu driver. And one option is with this patch...

> Their firmware would be loaded before phy parts are initialized, usb bus
> registered, or roothub device allocated.
> 
> Thanks
> -Mathias
