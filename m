Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C702E275E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 14:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgLXNa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 08:30:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgLXNa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 08:30:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E99C22210;
        Thu, 24 Dec 2020 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608816586;
        bh=b+MKS0YXpwXIZAtxx6PxhWkrhKXzG0lI7tMEuHK6RXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLNAfzVPcNm9yylAyq7f2p4xuiuWNOLmQl1aWMwbTXOwx8USG4Ezziv4dmh+g2QBr
         oukyHxwGfj7QGsA31s1RZC3iBN++1Du5Qj7tOyW66OWPaAhRqQ4k1ypNiUVxtbjyuO
         nF3ryeGnDe2WGp97bY1Iv7KBiLGawgyFy5fbGTHK8b72Wv0tqVPKqhg6FGNKiGUci+
         Ihi2VSKrIJe0xcHWKRC1Y8J0RDmYgvzYwKSHIuAk0CBw06JhdJZ1dnpHMbOyv3iFCE
         KFuOJi/gtcn/CPCk66g7LOC164FFYAR7dVgCFx/R7OstkyUyISYy/c4xfCkTI0Vbqy
         gH9rGmkoUvD0Q==
Received: by pali.im (Postfix)
        id 66F2C829; Thu, 24 Dec 2020 14:29:44 +0100 (CET)
Date:   Thu, 24 Dec 2020 14:29:44 +0100
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
Message-ID: <20201224132944.5odphwxtnzhvkeg7@pali>
References: <20201223162403.10897-1-pali@kernel.org>
 <20201224055425.GA27629@b29397-desktop>
 <20201224125347.z2ka7itpxuvboghq@pali>
 <DBBPR04MB797907A4C3D7666B867AE2F08BDD0@DBBPR04MB7979.eurprd04.prod.outlook.com>
 <20201224132401.7inh5ae7aaqvooxe@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201224132401.7inh5ae7aaqvooxe@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 December 2020 14:24:01 Pali Rohár wrote:
> On Thursday 24 December 2020 13:15:21 Peter Chen wrote:
> >  
> > > > > +	/* Old bindings miss the PHY handle */
> > > > > +	phy = of_phy_get(dev->of_node, "usb3-phy");
> > > > > +	if (IS_ERR(phy) && PTR_ERR(phy) == -EPROBE_DEFER)
> > > > > +		return -EPROBE_DEFER;
> > > >
> > > > Doesn't need to judge IS_ERR(phy).
> > > 
> > > Ok, I can remove it. I used same condition which is already in SATA and PCIe
> > > phy code.
> > > 
> > > > > +	else if (IS_ERR(phy))
> > > > > +		goto phy_out;
> > > > > +
> > > > > +	ret = phy_init(phy);
> > > > > +	if (ret)
> > > > > +		goto phy_put;
> > > > > +
> > > > > +	ret = phy_set_mode(phy, PHY_MODE_USB_HOST_SS);
> > > > > +	if (ret)
> > > > > +		goto phy_exit;
> > > > > +
> > > > > +	ret = phy_power_on(phy);
> > > > > +	if (ret == -EOPNOTSUPP) {
> > > > > +		/* Skip initializatin of XHCI PHY when it is unsupported by
> > > firmware */
> > > > > +		dev_warn(dev, "PHY unsupported by firmware\n");
> > > > > +		xhci->quirks |= XHCI_SKIP_PHY_INIT;
> > > > > +	}
> > > > > +	if (ret)
> > > > > +		goto phy_exit;
> > > > > +
> > > > > +	phy_power_off(phy);
> > > > > +phy_exit:
> > > > > +	phy_exit(phy);
> > > > > +phy_put:
> > > > > +	of_phy_put(phy);
> > > > > +phy_out:
> > > > > +
> > > >
> > > > You do power on and off again only want to know if PHY has already
> > > > powered at ATF, right?
> > > 
> > > I need to know if power on/off procedure is supported by ATF. And if not
> > > (indicated by -EOPNOTSUPP) then I need to ensure that usb hdc code would not
> > > try to call phy_power_on() as it would cause failure as described in the commit
> > > message. You can look at those other two commits for PCIe and SATA. Same
> > > thing is needed for USB.
> > 
> > If not supported by ATF, then where to power on and off PHY since no other place calls PHY APIs? Is it always on?
> 
> Yes, in this case (when -EOPNOTSUPP is returned) SMC API is not
> supported by ATF, and PHY is always on.

To make it clear, core/hcd.c function usb_add_hcd() when
hcd->skip_phy_initialization is false is calling
usb_phy_roothub_power_on() which calls phy_power_on(). If this call
fails then error is propagated back to the usb_add_hcd() and this
function fails too.

But on boards with older ATF (which do not support PHY power on SMC API)
is phy_power_on() returning error -EOPNOTSUPP and therefore whole USB
3.0 initialization fails.

This patch is adding init hook to detect if ATF supports PHY power
on/off functions and in case it does not support it, code sets
XHCI_SKIP_PHY_INIT flag to instruct xhci-plat code to set
hcd->skip_phy_initialization flag to instruct core/hcd.c to skip calling
usb_phy_roothub_power_on() function as it is know that it would fail.
