Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26B22D8F42
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 19:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgLMS0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 13:26:53 -0500
Received: from relay2.mymailcheap.com ([151.80.165.199]:35411 "EHLO
        relay2.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgLMS0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 13:26:46 -0500
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id E1C4B3EDEC;
        Sun, 13 Dec 2020 19:25:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id BBCEF2A469;
        Sun, 13 Dec 2020 19:25:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607883912;
        bh=+LGuRIW3w+rBMNLbodKIkSob5p2vS5X84LMEHhm63h4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Matee/aurcgUQoYEzq0yilpUBRDroe3ZzciQJzky2b4QY3hHSTtes5ulqXp65agKd
         vbaREuMCAdWrQPYL5zyIa3MLkcWu2Fld1kJFNSpfyukeznp39dtnL/XKZysb2bctmc
         DCJzelu9VAR9XlO7n1GX6CMpo0Fy1E8RCJuy0+X0=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tbhHbOZexxxR; Sun, 13 Dec 2020 19:25:11 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sun, 13 Dec 2020 19:25:11 +0100 (CET)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 0F6DA41A53;
        Sun, 13 Dec 2020 18:25:11 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="MG8O1fCx";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.162.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 9A10641A53;
        Sun, 13 Dec 2020 18:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607883906; bh=+LGuRIW3w+rBMNLbodKIkSob5p2vS5X84LMEHhm63h4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MG8O1fCxMafOPgABaOZ210gqOOl3BAEDZGIbKRqO1gGi3r3HSBRcUoI/N8j/Ijfwx
         CtnituWlrJH+UQsS8nSfhxDBbxQdn0D2l0/IQLeQb0CqoLzDMn4jQ1U2tYF5YuV+SN
         EE6DrP/WhaxGhcbrquKgW9CHNjNiHLVM/FwuNCC8=
Message-ID: <02cbecddf07dc46f8fb7e0d93b7532e3c239084e.camel@aosc.io>
Subject: Re: [PATCH v2 14/21] phy: sun4i-usb: Rework "pmu_unk1" handling
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Date:   Mon, 14 Dec 2020 02:24:58 +0800
In-Reply-To: <20201211011934.6171-15-andre.przywara@arm.com>
References: <20201211011934.6171-1-andre.przywara@arm.com>
         <20201211011934.6171-15-andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_TWELVE(0.00)[15];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.162.102:received];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         FREEMAIL_CC(0.00)[aosc.xyz,linaro.org,kernel.org,gmail.com,allwinnertech.com,lists.infradead.org,vger.kernel.org,googlegroups.com,ti.com];
         SUSPICIOUS_RECIPS(1.50)[];
         RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Queue-Id: 0F6DA41A53
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-12-11星期五的 01:19 +0000，Andre Przywara写道：
> Newer SoCs (A100, H616) need to clear a different bit in our
> "unknown"
> PMU PHY register.

It looks like that the unknown PHY register is PHYCTL register for each
individual PHY, and the bit that is cleared is
called SUNXI_HCI_PHY_CTRL_SIDDQ in the BSP (similar to
the USBC_PHY_CTL_SIDDQ we cleared for main PHYCTL).

> 
> Generalise the existing code by allowing configs to specify a bitmask
> of bits to clear.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c | 28 +++++++++++------------
> ----
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c
> b/drivers/phy/allwinner/phy-sun4i-usb.c
> index 651d5e2a25ce..4ba0699e0bb4 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -115,9 +115,9 @@ struct sun4i_usb_phy_cfg {
>  	int hsic_index;
>  	enum sun4i_usb_phy_type type;
>  	u32 disc_thresh;
> +	u32 pmu_unk1_clrbits;
>  	u8 phyctl_offset;
>  	bool dedicated_clocks;
> -	bool enable_pmu_unk1;
>  	bool phy0_dual_route;
>  	int missing_phys;
>  };
> @@ -288,6 +288,12 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>  		return ret;
>  	}
>  
> +	if (phy->pmu && data->cfg->pmu_unk1_clrbits) {
> +		val = readl(phy->pmu + REG_PMU_UNK1);
> +		val &= ~data->cfg->pmu_unk1_clrbits;
> +		writel(val, phy->pmu + REG_PMU_UNK1);
> +	}
> +
>  	if (data->cfg->type == sun8i_a83t_phy ||
>  	    data->cfg->type == sun50i_h6_phy) {
>  		if (phy->index == 0) {
> @@ -297,11 +303,6 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>  			writel(val, data->base + data->cfg-
> >phyctl_offset);
>  		}
>  	} else {
> -		if (phy->pmu && data->cfg->enable_pmu_unk1) {
> -			val = readl(phy->pmu + REG_PMU_UNK1);
> -			writel(val & ~2, phy->pmu + REG_PMU_UNK1);
> -		}
> -
>  		/* Enable USB 45 Ohm resistor calibration */
>  		if (phy->index == 0)
>  			sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN,
> 0x01, 1);
> @@ -867,7 +868,6 @@ static const struct sun4i_usb_phy_cfg
> sun4i_a10_cfg = {
>  	.disc_thresh = 3,
>  	.phyctl_offset = REG_PHYCTL_A10,
>  	.dedicated_clocks = false,
> -	.enable_pmu_unk1 = false,
>  };
>  
>  static const struct sun4i_usb_phy_cfg sun5i_a13_cfg = {
> @@ -876,7 +876,6 @@ static const struct sun4i_usb_phy_cfg
> sun5i_a13_cfg = {
>  	.disc_thresh = 2,
>  	.phyctl_offset = REG_PHYCTL_A10,
>  	.dedicated_clocks = false,
> -	.enable_pmu_unk1 = false,
>  };
>  
>  static const struct sun4i_usb_phy_cfg sun6i_a31_cfg = {
> @@ -885,7 +884,6 @@ static const struct sun4i_usb_phy_cfg
> sun6i_a31_cfg = {
>  	.disc_thresh = 3,
>  	.phyctl_offset = REG_PHYCTL_A10,
>  	.dedicated_clocks = true,
> -	.enable_pmu_unk1 = false,
>  };
>  
>  static const struct sun4i_usb_phy_cfg sun7i_a20_cfg = {
> @@ -894,7 +892,6 @@ static const struct sun4i_usb_phy_cfg
> sun7i_a20_cfg = {
>  	.disc_thresh = 2,
>  	.phyctl_offset = REG_PHYCTL_A10,
>  	.dedicated_clocks = false,
> -	.enable_pmu_unk1 = false,
>  };
>  
>  static const struct sun4i_usb_phy_cfg sun8i_a23_cfg = {
> @@ -903,7 +900,6 @@ static const struct sun4i_usb_phy_cfg
> sun8i_a23_cfg = {
>  	.disc_thresh = 3,
>  	.phyctl_offset = REG_PHYCTL_A10,
>  	.dedicated_clocks = true,
> -	.enable_pmu_unk1 = false,
>  };
>  
>  static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
> @@ -912,7 +908,6 @@ static const struct sun4i_usb_phy_cfg
> sun8i_a33_cfg = {
>  	.disc_thresh = 3,
>  	.phyctl_offset = REG_PHYCTL_A33,
>  	.dedicated_clocks = true,
> -	.enable_pmu_unk1 = false,
>  };
>  
>  static const struct sun4i_usb_phy_cfg sun8i_a83t_cfg = {
> @@ -929,7 +924,7 @@ static const struct sun4i_usb_phy_cfg
> sun8i_h3_cfg = {
>  	.disc_thresh = 3,
>  	.phyctl_offset = REG_PHYCTL_A33,
>  	.dedicated_clocks = true,
> -	.enable_pmu_unk1 = true,
> +	.pmu_unk1_clrbits = BIT(1),
>  	.phy0_dual_route = true,
>  };
>  
> @@ -939,7 +934,7 @@ static const struct sun4i_usb_phy_cfg
> sun8i_r40_cfg = {
>  	.disc_thresh = 3,
>  	.phyctl_offset = REG_PHYCTL_A33,
>  	.dedicated_clocks = true,
> -	.enable_pmu_unk1 = true,
> +	.pmu_unk1_clrbits = BIT(1),
>  	.phy0_dual_route = true,
>  };
>  
> @@ -949,7 +944,7 @@ static const struct sun4i_usb_phy_cfg
> sun8i_v3s_cfg = {
>  	.disc_thresh = 3,
>  	.phyctl_offset = REG_PHYCTL_A33,
>  	.dedicated_clocks = true,
> -	.enable_pmu_unk1 = true,
> +	.pmu_unk1_clrbits = BIT(1),
>  	.phy0_dual_route = true,
>  };
>  
> @@ -959,7 +954,7 @@ static const struct sun4i_usb_phy_cfg
> sun50i_a64_cfg = {
>  	.disc_thresh = 3,
>  	.phyctl_offset = REG_PHYCTL_A33,
>  	.dedicated_clocks = true,
> -	.enable_pmu_unk1 = true,
> +	.pmu_unk1_clrbits = BIT(1),
>  	.phy0_dual_route = true,
>  };
>  
> @@ -969,7 +964,6 @@ static const struct sun4i_usb_phy_cfg
> sun50i_h6_cfg = {
>  	.disc_thresh = 3,
>  	.phyctl_offset = REG_PHYCTL_A33,
>  	.dedicated_clocks = true,
> -	.enable_pmu_unk1 = true,
>  	.phy0_dual_route = true,
>  	.missing_phys = BIT(1) | BIT(2),
>  };
