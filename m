Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08682E3707
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 13:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgL1MMt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Dec 2020 07:12:49 -0500
Received: from lists.nic.cz ([217.31.204.67]:52734 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgL1MMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 07:12:48 -0500
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id CBC77140A3F;
        Mon, 28 Dec 2020 13:12:06 +0100 (CET)
Date:   Mon, 28 Dec 2020 13:11:49 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
Message-ID: <20201228131149.30907b44@nic.cz>
In-Reply-To: <20201223162403.10897-1-pali@kernel.org>
References: <20201223162403.10897-1-pali@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali and Miquel,

On Wed, 23 Dec 2020 17:24:03 +0100
Pali Rohár <pali@kernel.org> wrote:

>  int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
>  {
>  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> +	struct device *dev = hcd->self.controller;
> +	struct phy *phy;
> +	int ret;
>  
>  	/* Without reset on resume, the HC won't work at all */
>  	xhci->quirks |= XHCI_RESET_ON_RESUME;
>  
> +	/* Old bindings miss the PHY handle */
> +	phy = of_phy_get(dev->of_node, "usb3-phy");
> +	if (IS_ERR(phy) && PTR_ERR(phy) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	else if (IS_ERR(phy))
> +		goto phy_out;
> +
> +	ret = phy_init(phy);
> +	if (ret)
> +		goto phy_put;
> +
> +	ret = phy_set_mode(phy, PHY_MODE_USB_HOST_SS);
> +	if (ret)
> +		goto phy_exit;
> +
> +	ret = phy_power_on(phy);
> +	if (ret == -EOPNOTSUPP) {
> +		/* Skip initializatin of XHCI PHY when it is unsupported by firmware */
> +		dev_warn(dev, "PHY unsupported by firmware\n");
> +		xhci->quirks |= XHCI_SKIP_PHY_INIT;
> +	}
> +	if (ret)
> +		goto phy_exit;

I am not sure if this is the correct way to check whether PHY_INIT
should be skipped.

Moreover the subsequent phy_power_off:

> +
> +	phy_power_off(phy);

won't power off the PHY, because the corresponding handler in ATF is
currently empty. 

I guess the patch needs to be in kernel if users are unwilling to upgrade
ATF firmware.

The SMC calls for Marvell's comphy are designed to be generic for
several Marvell platforms (the constants are the same and so one), but
we still have different drivers for them anyway.

Maybe it would be better to just not use the ATF implementation at all,
and implement the comphy driver for A3720 entirely in kernel...

Miquel, what do you think?

Marek
