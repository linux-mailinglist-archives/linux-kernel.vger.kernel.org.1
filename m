Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273F32A6288
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgKDKv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:51:28 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41252 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbgKDKv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:51:28 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kaGNp-00054b-Sv; Wed, 04 Nov 2020 11:51:17 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dianders@chromium.org
Subject: Re: [PATCH] arm64: dts: rockchip: Assign a fixed index to mmc devices on rk3399-roc-pc boards.
Date:   Wed, 04 Nov 2020 11:51:17 +0100
Message-ID: <4984701.vSXMUKeAfh@diego>
In-Reply-To: <20201104094950.2096-1-m.reichl@fivetechno.de>
References: <20201104094950.2096-1-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Am Mittwoch, 4. November 2020, 10:49:45 CET schrieb Markus Reichl:
> Recently introduced async probe on mmc devices can shuffle block IDs.
> Pin them to fixed values to ease booting in evironments where UUIDs
> are not practical. Use newly introduced aliases for mmcblk devices from [1].
> 
> [1]
> https://patchwork.kernel.org/patch/11747669/
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> index e7a459fa4322..bc9482b59428 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> @@ -13,6 +13,11 @@ / {
>  	model = "Firefly ROC-RK3399-PC Board";
>  	compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
>  
> +	aliases {
> +		mmc0 = &sdmmc;
> +		mmc1 = &sdhci;
> +	};
> +

Any reason for this odering?

I.e. some previous incarnations had it ordered as (emmc, mmc, sdio).
This is also true for the ChromeOS out-of-tree usage of those, the
rk3399 dts in the chromeos-4.4 tree also orders this as sdhci, sdmmc, sdio.

And I guess a further question would be when we're doing arbitary orderings
anyway, why is this not in rk3399.dtsi ;-) ?


Heiko


