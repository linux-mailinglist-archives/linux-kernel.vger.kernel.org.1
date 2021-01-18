Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F23D2F99FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbhARGdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732470AbhARGdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:33:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEFBF227C3;
        Mon, 18 Jan 2021 06:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610951578;
        bh=6N01wzOWjD4rcN3F+PsOZ2+FEiqBi+1ijLv2TWHWy1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZhxDTkH4wOiwmQkjydK2eMj9TNaaYJmpx+GAz3q49VqQbiljqZ7R4DIpakgbcF6Y
         T8r5mtoerAun0V4Aq06ChEmL0Tdci7RmiFkFIci1mKJDy9jimnRqEEeuC654YQAEUM
         AUwdIzGyafW7ZD+C1NWNwdf8GMR7hAhQuBl9hx2xKwx7QmZwX22H+5MKS8w8iDzgAh
         oyms8zIjaL3/SB9RP5D917Y/ru5sdAMdAcU6mgMvoZt/Lyl7ABJXAr1ejU0YiFq43O
         jKWj754opqG8+X2S4t5jjzYjj1+kDO4H1HBcDgrMIq0GfUugUja7Sv2L++2iL8hmVn
         dS/mKQujjh3MA==
Date:   Mon, 18 Jan 2021 14:32:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bruno Thomsen <bth@kamstrup.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] ARM: dts: imx7d-flex-concentrator: fix pcf2127 reset
Message-ID: <20210118063252.GJ28365@dragon>
References: <20210111151537.12530-1-bruno.thomsen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111151537.12530-1-bruno.thomsen@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 04:15:37PM +0100, Bruno Thomsen wrote:
> RTC pcf2127 device driver has changed default behaviour of the watchdog
> feature in v5.11-rc1. Now you need to explicitly enable it with a
> device tree property, "reset-source", when used in the board design.

It sound that the existing DTBs are broken by this default behaviour
change?

> 
> Fixes: 71ac13457d9d ("rtc: pcf2127: only use watchdog when explicitly available")
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> Cc: Bruno Thomsen <bth@kamstrup.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied, thanks.

Shawn

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
