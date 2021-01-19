Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DC02FB4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 10:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbhASJDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:03:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731626AbhASI5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:57:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0470123103;
        Tue, 19 Jan 2021 08:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611046628;
        bh=FNcY0Ysa8mRAba5iHcXtcfQOnny/W/mDvHOHe7GEF0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lpWQ49TouWfPuvM/2l87PgVTet3UyKx9kXsMTe8IcUcaf9NJxOooNf55QuaBflm58
         QtF0WcrMXJmRPkbd7faM2Aw/41mG6G36eD2+EAnbZuue6Z0NXQj4j9L92zthdmTgKh
         NjMDIVXk0DbnDgTGYH0CwfV+hRtqAeDnlgTTabeSUiO9E0gdsb704cuh6v8+T/qBjP
         aWeD6T/T2YDup+KzPU5qCL0r8GEAA7FPfzb5zTNJeOUoVWuPdUJWlnM0+3EydtYUXv
         N9LwHz3PMt5IWA2K5VgrzUfwr5uvSMekCEQtqGJk/ArYj+1P+zxClXmjRshvDA2Ars
         2FkRPfNS12rHw==
Date:   Tue, 19 Jan 2021 16:57:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ARM: dts: imx6qdl: specify vcc-supply for NOP USB
 PHYs
Message-ID: <20210119085700.GB4356@dragon>
References: <20201113152856.3758-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113152856.3758-1-a.fatoum@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:28:55PM +0100, Ahmad Fatoum wrote:
> The SoC dtsi lists a NOP USB PHY for each of the two HSIC-only USB
> controllers. Their device tree node doesn't indicate a vcc-supply
> resulting in:
> 
>   usb_phy_generic usbphynop1: supply vcc not found, using dummy regulator
>   usb_phy_generic usbphynop2: supply vcc not found, using dummy regulator

So the patch is all for removing this kernel message, with introducing
the following potential breakage?

Shawn

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
> -- 
> 2.28.0
> 
