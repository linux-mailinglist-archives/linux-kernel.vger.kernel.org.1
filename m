Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C6626C8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgIPS6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgIPRxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:53:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2FC00214B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:25:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kIYNQ-0002Ex-5F; Wed, 16 Sep 2020 16:25:40 +0200
Subject: Re: [PATCH] ARM: dts: stm32: declare device tree syscon node for TAMP
 peripheral
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200916142216.25142-1-a.fatoum@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <a6038c13-45e1-1d30-9766-db3370557584@pengutronix.de>
Date:   Wed, 16 Sep 2020 16:25:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916142216.25142-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/20 4:22 PM, Ahmad Fatoum wrote:
> The stm32mp1 TAMP (Tamper and backup registers) does tamper detection
> and features 32 backup registers that, being in the RTC domain, may
> survive even with Vdd switched off.
> 
> We don't have a driver for the peripheral, but handling it as syscon
> allows using it with existing drivers that work with them, in particular
> a syscon-reboot-mode child node can be defined in board.dts (or fixed up
> by the bootloader) to exchange reboot mode information with the bootloader.
> 

Looking at the title, I see now that there is nothing stm32mp specific in it.
I will rename the patch to
"ARM: dts: stm32: declare syscon node for TAMP peripheral in stm32mp151.dtsi"
when I send out v2.

> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  arch/arm/boot/dts/stm32mp151.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index bfe29023fbd5..fa4eb96c95af 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1144,6 +1144,11 @@ syscfg: syscon@50020000 {
>  			clocks = <&rcc SYSCFG>;
>  		};
>  
> +		tamp: tamp@5c00a000 {
> +			compatible = "simple-bus", "syscon", "simple-mfd";
> +			reg = <0x5c00a000 0x400>;
> +		};
> +
>  		lptimer2: timer@50021000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
