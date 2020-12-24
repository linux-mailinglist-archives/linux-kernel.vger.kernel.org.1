Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C932E26F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 13:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgLXMyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 07:54:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbgLXMyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 07:54:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E618122285;
        Thu, 24 Dec 2020 12:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608814430;
        bh=DPmuKa+XW+D99Zt0CU3k7puC0GjdGxPYMIOIjI0hVS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lb5/Ho9mH379xmeZbpfRfNXJbUl7IDnOiPKTBl9/JU0FwYlWBTe3yFlaxxre0lbTd
         4hyM5C3+Y1eXTpJNK+RwDZLF3UlAJQCH6llMbkzAm9qbMhZTKIv7SRLApDA4+KbqMn
         EBQE2bmpz9zmuz/XHtK4oQ1dFB6yZMFJKvuMDYxA3zcf7TcFpH8YQPHSvTghtvdv/s
         8wZyoL9OXehqCzcBacCTbA5Qxq7JHclkIPLyfyxEdOUbwlzNKXJfhjbmXVUptclmV1
         JPUYJxy+Mo0INm89syKdIbQvmlPy2hqlgoEGUofOpaz9VDHvBI83bquz00QIgSjJXB
         KsHNqQcQR8KOQ==
Received: by pali.im (Postfix)
        id 9D21E829; Thu, 24 Dec 2020 13:53:47 +0100 (CET)
Date:   Thu, 24 Dec 2020 13:53:47 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
Message-ID: <20201224125347.z2ka7itpxuvboghq@pali>
References: <20201223162403.10897-1-pali@kernel.org>
 <20201224055425.GA27629@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201224055425.GA27629@b29397-desktop>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 December 2020 05:54:55 Peter Chen wrote:
> On 20-12-23 17:24:03, Pali Rohár wrote:
> > Older ATF does not provide SMC call for USB 3.0 phy power on functionality
> > and therefore initialization of xhci-hcd is failing when older version of
> > ATF is used. In this case phy_power_on() function returns -EOPNOTSUPP.
> > 
> > [    3.108467] mvebu-a3700-comphy d0018300.phy: unsupported SMC call, try updating your firmware
> > [    3.117250] phy phy-d0018300.phy.0: phy poweron failed --> -95
> > [    3.123465] xhci-hcd: probe of d0058000.usb failed with error -95
> > 
> > This patch calls phy_power_on() in xhci_mvebu_a3700_init_quirk() function
> > and in case it returns -EOPNOTSUPP then XHCI_SKIP_PHY_INIT quirk is set to
> > instruct xhci-plat to skip PHY initialization.
> > 
> > This patch fixes above failure by ignoring 'not supported' error in
> > aardvark driver. In this case it is expected that phy is already power on.
> > 
> > It fixes initialization of xhci-hcd on Espressobin boards where is older
> > Marvell's Arm Trusted Firmware without SMC call for USB 3.0 phy power.
> > 
> > This is regression introduced in commit bd3d25b07342 ("arm64: dts: marvell:
> > armada-37xx: link USB hosts with their PHYs") where USB 3.0 phy was defined
> > and therefore xhci-hcd on Espressobin with older ATF started failing.
> > 
> > Fixes: bd3d25b07342 ("arm64: dts: marvell: armada-37xx: link USB hosts with their PHYs")
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Cc: <stable@vger.kernel.org> # 5.1+: ea17a0f153af: phy: marvell: comphy: Convert internal SMCC firmware return codes to errno
> > Cc: <stable@vger.kernel.org> # 5.1+: f768e718911e: usb: host: xhci-plat: add priv quirk for skip PHY initialization
> > 
> > ---
> > 
> > When applying this patch, please include additional line
> > 
> > Cc: <stable@vger.kernel.org> # 5.1+: <COMMIT_ID>: usb: host: xhci-plat: fix support for XHCI_SKIP_PHY_INIT quirk
> > 
> > with correct COMMIT_ID of mentioned patch which is available in the thread:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20201221150903.26630-1-pali%40kernel.org%2FT%2F%23u&amp;data=04%7C01%7Cpeter.chen%40nxp.com%7Ccc158fcd30104268b27008d8a75f32e1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637443374600182963%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vjuJxi9Kg1C7ZHJLB7rsct0kr93JSo4aYkitFubkLao%3D&amp;reserved=0
> > 
> > As mentioned patch is required for change in this patch to work. Above
> > mentioned patch is prerequisite for this patch and therefore needs to be
> > reviewed and applied prior this patch.
> > 
> > Note that same issue as in this USB 3.0 PHY patch was already resolved and
> > applied also for SATA PHY and PCIe PHY on A3720 SOC in following commits:
> > 
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fid%3D45aefe3d2251e4e229d7662052739f96ad1d08d9&amp;data=04%7C01%7Cpeter.chen%40nxp.com%7Ccc158fcd30104268b27008d8a75f32e1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637443374600182963%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2FIULc1sakzNVWjbVPA2TRYZAMv72DGOhmYv4NGijrT8%3D&amp;reserved=0
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fid%3Db0c6ae0f8948a2be6bf4e8b4bbab9ca1343289b6&amp;data=04%7C01%7Cpeter.chen%40nxp.com%7Ccc158fcd30104268b27008d8a75f32e1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637443374600182963%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=2mLHMBc9lgpB4BCrlJYBfO7OJk%2BCi%2Bq3AgpxJxfiCSU%3D&amp;reserved=0
> > 
> > And these commits were also backported to stable kernel versions (where
> > were affected commits which broke drivers initialization).
> > ---
> >  drivers/usb/host/xhci-mvebu.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
> > index 60651a50770f..ec4f6d6e44cf 100644
> > --- a/drivers/usb/host/xhci-mvebu.c
> > +++ b/drivers/usb/host/xhci-mvebu.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/mbus.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/phy/phy.h>
> >  
> >  #include <linux/usb.h>
> >  #include <linux/usb/hcd.h>
> > @@ -77,9 +78,43 @@ int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
> >  int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
> >  {
> >  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> > +	struct device *dev = hcd->self.controller;
> > +	struct phy *phy;
> > +	int ret;
> >  
> >  	/* Without reset on resume, the HC won't work at all */
> >  	xhci->quirks |= XHCI_RESET_ON_RESUME;
> >  
> > +	/* Old bindings miss the PHY handle */
> > +	phy = of_phy_get(dev->of_node, "usb3-phy");
> > +	if (IS_ERR(phy) && PTR_ERR(phy) == -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> 
> Doesn't need to judge IS_ERR(phy).

Ok, I can remove it. I used same condition which is already in SATA and
PCIe phy code.

> > +	else if (IS_ERR(phy))
> > +		goto phy_out;
> > +
> > +	ret = phy_init(phy);
> > +	if (ret)
> > +		goto phy_put;
> > +
> > +	ret = phy_set_mode(phy, PHY_MODE_USB_HOST_SS);
> > +	if (ret)
> > +		goto phy_exit;
> > +
> > +	ret = phy_power_on(phy);
> > +	if (ret == -EOPNOTSUPP) {
> > +		/* Skip initializatin of XHCI PHY when it is unsupported by firmware */
> > +		dev_warn(dev, "PHY unsupported by firmware\n");
> > +		xhci->quirks |= XHCI_SKIP_PHY_INIT;
> > +	}
> > +	if (ret)
> > +		goto phy_exit;
> > +
> > +	phy_power_off(phy);
> > +phy_exit:
> > +	phy_exit(phy);
> > +phy_put:
> > +	of_phy_put(phy);
> > +phy_out:
> > +
> 
> You do power on and off again only want to know if PHY has already powered at
> ATF, right?

I need to know if power on/off procedure is supported by ATF. And if not
(indicated by -EOPNOTSUPP) then I need to ensure that usb hdc code would
not try to call phy_power_on() as it would cause failure as described in
the commit message. You can look at those other two commits for PCIe and
SATA. Same thing is needed for USB.
