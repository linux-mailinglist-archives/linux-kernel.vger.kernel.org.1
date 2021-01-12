Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8162F3726
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392760AbhALRab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:30:31 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:45783 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388033AbhALRab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:30:31 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A87CF40015;
        Tue, 12 Jan 2021 17:29:48 +0000 (UTC)
Date:   Tue, 12 Jan 2021 18:29:48 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bruno Thomsen <bth@kamstrup.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] ARM: dts: imx7d-flex-concentrator: fix pcf2127 reset
Message-ID: <20210112172948.GI3654@piout.net>
References: <20210111151537.12530-1-bruno.thomsen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111151537.12530-1-bruno.thomsen@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2021 16:15:37+0100, Bruno Thomsen wrote:
> RTC pcf2127 device driver has changed default behaviour of the watchdog
> feature in v5.11-rc1. Now you need to explicitly enable it with a
> device tree property, "reset-source", when used in the board design.
> 
> Fixes: 71ac13457d9d ("rtc: pcf2127: only use watchdog when explicitly available")
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> Cc: Bruno Thomsen <bth@kamstrup.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  arch/arm/boot/dts/imx7d-flex-concentrator.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-flex-concentrator.dts b/arch/arm/boot/dts/imx7d-flex-concentrator.dts
> index 84b095279e65..bd6b5285aa8d 100644
> --- a/arch/arm/boot/dts/imx7d-flex-concentrator.dts
> +++ b/arch/arm/boot/dts/imx7d-flex-concentrator.dts
> @@ -115,6 +115,7 @@ pcf2127: rtc@0 {
>  		compatible = "nxp,pcf2127";
>  		reg = <0>;
>  		spi-max-frequency = <2000000>;
> +		reset-source;
>  	};
>  };
>  
> 
> base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
> -- 
> 2.29.2
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
