Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC272F074E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbhAJMrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:47:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbhAJMrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:47:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3606122D75;
        Sun, 10 Jan 2021 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610282795;
        bh=ojFfiqYWu4ZeUxsxB2S5tHsWT12OD2vCODDjdqUYBE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBWlKr/8ApkTGYv7N3QIV7dataShT0y/OopKRrMaupSt9P9b36cnmWQNSubeZGyy0
         72jmHDZUzAICkD/Vd7swlOfu9CYwpsEgtTexow811b2qN4zSVZcXaIRZw2gkOX1JNp
         iPkpiww7NMa/pu6//Tbeg0bDVMgc32oUVS22h8FeL/SQcpBz/zw6+d3XA8Y6811lPE
         p+L9WhxVcXaBEv/fq0aj3Jff4GDDEi3Zsp7CgiJrUzGE8D/wPKkLLkkFKG9bgivY6l
         x5yjsyEM+PAod/85/Jefkhid8nv330H7RoP0OSfyd7yGA3nXLI4LeSz91/gNiqfhJu
         dZqOUk/C+a1QQ==
Date:   Sun, 10 Jan 2021 20:46:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq: Add clock parents for mipi dphy
Message-ID: <20210110124629.GO28365@dragon>
References: <dd135fa55084d886bd6daf777d76677f232c53c6.1608313793.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd135fa55084d886bd6daf777d76677f232c53c6.1608313793.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 06:50:05PM +0100, Guido Günther wrote:
> This makes sure the clock tree setup for the dphy is not dependent on
> other components.
> 
> Without this change bringing up the display can fail like
> 
>   kernel: phy phy-30a00300.dphy.2: Invalid CM/CN/CO values: 165/217/1
>   kernel: phy phy-30a00300.dphy.2: for hs_clk/ref_clk=451656000/593999998 ~ 165/217
> 
> if LCDIF doesn't set up that part of the clock tree first. This was
> noticed when testing the Librem 5 devkit with defconfig. It doesn't
> happen when modules are built in.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index a841a023e8e0..ca0847e8f13c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1016,9 +1016,14 @@ dphy: dphy@30a00300 {
>  				reg = <0x30a00300 0x100>;
>  				clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
>  				clock-names = "phy_ref";
> -				assigned-clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> -				assigned-clock-parents = <&clk IMX8MQ_VIDEO_PLL1_OUT>;
> -				assigned-clock-rates = <24000000>;
> +				assigned-clocks = <&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
> +						  <&clk IMX8MQ_VIDEO_PLL1_BYPASS>,
> +						  <&clk IMX8MQ_CLK_DSI_PHY_REF>,
> +						  <&clk IMX8MQ_VIDEO_PLL1>;

You do not seem to set parent or rate on IMX8MQ_VIDEO_PLL1.  Why do you
have it here?

Shawn

> +				assigned-clock-parents = <&clk IMX8MQ_CLK_25M>,
> +						  <&clk IMX8MQ_VIDEO_PLL1>,
> +						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
> +				assigned-clock-rates = <0>, <0>, <24000000>;
>  				#phy-cells = <0>;
>  				power-domains = <&pgc_mipi>;
>  				status = "disabled";
> -- 
> 2.29.2
> 
