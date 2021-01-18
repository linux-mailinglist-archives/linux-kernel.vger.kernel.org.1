Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9918B2FAB77
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437935AbhARU3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389085AbhARKmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:42:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBC9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:41:45 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1l1Ryg-0002BX-FN; Mon, 18 Jan 2021 11:41:42 +0100
Subject: Re: [RFC PATCH] ARM: dts: imx6qdl: specify vcc-supply for NOP USB
 PHYs
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201113152856.3758-1-a.fatoum@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <f148055b-2456-795a-6afe-ab4f09058803@pengutronix.de>
Date:   Mon, 18 Jan 2021 11:41:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201113152856.3758-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

did this maybe slip through the cracks?

On 13.11.20 16:28, Ahmad Fatoum wrote:
> The SoC dtsi lists a NOP USB PHY for each of the two HSIC-only USB
> controllers. Their device tree node doesn't indicate a vcc-supply
> resulting in:
> 
>   usb_phy_generic usbphynop1: supply vcc not found, using dummy regulator
>   usb_phy_generic usbphynop2: supply vcc not found, using dummy regulator
> 
> warnings on boot up. The USB IP vcc-supply - separate from the vusb - is
> hardwired to LDO_2P5[1], which we already have a device tree node for.
> Reference it for the dummy "phy" as well.
> 
> This will lead to breakage (probe deferment) for kernels that:
>   - Use a HSIC USB controller
>   - Use this new device tree
>   - but have CONFIG_REGULATOR_ANATOP disabled
> 
> Because while the regulator is always-on, it can't be resolved when
> there is no driver for it.
> 
> As there are
> 
>   - no affected upstream device trees
>   - existing device trees are unaffected without recompilation
>   - disabling CONFIG_REGULATOR_ANATOP is explicitly a non-recommended
>     configuration per symbol help text
> 
> this potential breakage is deemed acceptable.
> 
> [1]: i.MX 6Dual/6Quad Reference Manual, Rev. C,
>      Figure 53-1. Power System Overview
> 
> Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 43edbf1156c7..22e4c142de13 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -131,11 +131,13 @@ pmu: pmu {
>  
>  	usbphynop1: usbphynop1 {
>  		compatible = "usb-nop-xceiv";
> +		vcc-supply = <&reg_vdd2p5>;
>  		#phy-cells = <0>;
>  	};
>  
>  	usbphynop2: usbphynop2 {
>  		compatible = "usb-nop-xceiv";
> +		vcc-supply = <&reg_vdd2p5>;
>  		#phy-cells = <0>;
>  	};
>  
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
