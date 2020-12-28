Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A53E2E3970
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 14:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbgL1NXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:23:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388533AbgL1NXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:23:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 848C622583;
        Mon, 28 Dec 2020 13:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609161777;
        bh=DhYUTYqHNosTc9hXftPIlKWAxz5GzU0HqicuYZ4+dsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dv9t8sSmKMfPY1gp3cCkqHcigqi13922EdFdrt2sCrconibtsVexm7c1sfqtPbonN
         T0Xk4mRWf+p9VeUspsFLoGycOBdzTRknucTvvHi+CVS3jYIN5WXt2aLbkHrQeeiBtT
         OZ9P3+6P4PErQjcQltkyoQQ0n6ACUey9Tr5IBag4QrKuejBoFW3zWUA3X/Ov22/skX
         69OSME5l6ayllIyhX5WJQrETdb6flIWWpr/WCGl8LI9Xo5oMyqwK5G9ILZ6GTYAcRH
         V3EaOq0ewFTcSOJ4YjRWmV8AhmtA6kCmJ+zxx89F5WpJ7dGe8ce48intDiOLIpckle
         +WBzjGPKPTwGQ==
Received: by pali.im (Postfix)
        id 92715843; Mon, 28 Dec 2020 14:22:55 +0100 (CET)
Date:   Mon, 28 Dec 2020 14:22:55 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
Message-ID: <20201228132255.yqhpjifgbccp4gfe@pali>
References: <20201223162403.10897-1-pali@kernel.org>
 <20201228131149.30907b44@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201228131149.30907b44@nic.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Monday 28 December 2020 13:11:49 Marek Behun wrote:
> Hi Pali and Miquel,
> 
> On Wed, 23 Dec 2020 17:24:03 +0100
> Pali Rohár <pali@kernel.org> wrote:
> 
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
> 
> I am not sure if this is the correct way to check whether PHY_INIT
> should be skipped.

I do not have a better idea how to fix described issue for Armada 3720
boards without touching other usb/core/hdc code. I wanted to put these
Armada 3720 changes only into xhci-mvebu/xhci_mvebu_a3700_init_quirk
code so it does not "pollute" other usb generic code.

> Moreover the subsequent phy_power_off:
> 
> > +
> > +	phy_power_off(phy);
> 
> won't power off the PHY, because the corresponding handler in ATF is
> currently empty. 

This is not an issue as the usb core will later power on PHY during
initialization. So I can remove this line, it has no effect on
functionality.

> I guess the patch needs to be in kernel if users are unwilling to upgrade
> ATF firmware.

Yes. If distributions which are running stable kernels (4.14, 4.19)
start updating their kernels to new stable versions (5.4+) then this
upgrade can break support for USB. Similarly for SATA and PCIe (already
fixed and backported to stable kernels). This is relevant e.g. to Debian
which stable version is on 4.19 and therefore is not affected by this
issue yet.

So my opinion is that such thing is a regression if kernel starts
depending on a new firmware version and cause malfunctions of some
subsystems.

Updating kernel on Espressobin or Turris MOX (both A3720) when using
Debian, OpenWRT (or any similar distribution) is relatively easy as
kernel is stored on SD card on rootfs filesystem. Package manager will
update it easily and can do it automatically (without user interation).

But updating ATF firmware is harder as it is stored in nand and on
Espressobin it is part of another M3 secure firmware image. I do not
know any distribution which can do it automatically, it needs to be done
by user.

> The SMC calls for Marvell's comphy are designed to be generic for
> several Marvell platforms (the constants are the same and so one), but
> we still have different drivers for them anyway.
> 
> Maybe it would be better to just not use the ATF implementation at all,
> and implement the comphy driver for A3720 entirely in kernel...

Globalscaletechnolgies already implemented something in their kernel:
https://github.com/globalscaletechnologies/linux/commit/86fa2470c3a867ca9a78e5521a7af037617f5b3b

I do not like too an idea to depends on external RPC API in kernel.
I think that it is better to have native driver in linux kernel instead
of current RPC driver. Bugs in our kernel drivers can be fixed and
backported to stable kernels. But bugs in firmware we cannot fix and we
have to deal with them (in case we are using it).

I think that in past Linus said that Linux kernel does not use nor
depend on x86 BIOS routines/interrupts for similar reasons.

> Miquel, what do you think?
> 
> Marek
