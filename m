Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999932C518A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbgKZJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgKZJnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:43:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139DDC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 01:43:46 -0800 (PST)
Received: from [2a0a:edc0:0:900:6245:cbff:fea0:1793] (helo=kresse.office.stw.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kiDoQ-0000Nm-52; Thu, 26 Nov 2020 10:43:38 +0100
Message-ID: <47fb9966f3f633a5ec8297500d26f1c571bc26b2.camel@pengutronix.de>
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 26 Nov 2020 10:43:36 +0100
In-Reply-To: <20201125103909.16548-1-laurentiu.palcu@oss.nxp.com>
References: <20201125103909.16548-1-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:6245:cbff:fea0:1793
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=4.0 tests=AWL,BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] arm64: dts: imx8mq: add DCSS node
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2020-11-25 at 12:39 +0200, Laurentiu Palcu wrote:
> This patch adds the node for iMX8MQ Display Controller Subsystem.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Hi,
> 
> This is, actually, a resend of the patch because we decided to drop it
> from the main DCSS patchset until the driver gets merged.
> 
> Now that the driver is in mainline, we can finally add DCSS node in DTS.
> 
> Thanks,
> laurentiu
> 
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 5e0e7d0f1bc4..5a617f9ed8b5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1103,6 +1103,29 @@
>  			#size-cells = <1>;
>  			ranges = <0x32c00000 0x32c00000 0x400000>;
>  
> +			dcss: display-controller@32e00000 {
> +				compatible = "nxp,imx8mq-dcss";
> +				reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
> +				interrupts = <6>, <8>, <9>;
> +				interrupt-names = "ctxld", "ctxld_kick", "vblank";
> +				interrupt-parent = <&irqsteer>;
> +				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>,
> +					 <&clk IMX8MQ_CLK_DISP_AXI_ROOT>,
> +					 <&clk IMX8MQ_CLK_DISP_RTRM_ROOT>,
> +					 <&clk IMX8MQ_VIDEO2_PLL_OUT>,
> +					 <&clk IMX8MQ_CLK_DISP_DTRC>;
> +				clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
> +				assigned-clocks = <&clk IMX8MQ_CLK_DISP_AXI>,
> +						  <&clk IMX8MQ_CLK_DISP_RTRM>,
> +						  <&clk IMX8MQ_VIDEO2_PLL1_REF_SEL>;
> +				assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
> +							 <&clk IMX8MQ_SYS1_PLL_800M>,
> +							 <&clk IMX8MQ_CLK_27M>;
> +				assigned-clock-rates = <800000000>,
> +						       <400000000>;
> +				status = "disabled";
> +			};
> +
>  			irqsteer: interrupt-controller@32e2d000 {
>  				compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";
>  				reg = <0x32e2d000 0x1000>;

