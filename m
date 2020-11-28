Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7269A2C713A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391518AbgK1VzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:55:06 -0500
Received: from foss.arm.com ([217.140.110.172]:37318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387575AbgK1TkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:40:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A75D30E;
        Sat, 28 Nov 2020 11:39:24 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 916ED3F23F;
        Sat, 28 Nov 2020 11:39:22 -0800 (PST)
Subject: Re: [RESEND PATCH 13/19] phy: sun4i-usb: add support for A100 USB PHY
To:     Frank Lee <frank@allwinnertech.com>, tiny.windzz@gmail.com
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <b323d8c7ea4eb6bc325f6a6465cb2547cc6be757.1604988979.git.frank@allwinnertech.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <ba05fb05-f1de-8a8f-c771-f82f25ad4da5@arm.com>
Date:   Sat, 28 Nov 2020 19:39:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b323d8c7ea4eb6bc325f6a6465cb2547cc6be757.1604988979.git.frank@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2020 06:40, Frank Lee wrote:

Hi,

> From: Yangtao Li <frank@allwinnertech.com>
> 
> Add support for a100's usb phy, which with 2 PHYs.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> index a6900495baa5..1a0e403131e7 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -107,6 +107,7 @@ enum sun4i_usb_phy_type {
>  	sun8i_r40_phy,
>  	sun8i_v3s_phy,
>  	sun50i_a64_phy,
> +	sun50i_a100_phy,

But with that patch fixing the H6 support you don't need a new name, do you?
Because below you just add the sun50i_a100_phy name next to every place
with a sun50i_h6_phy check.

>  	sun50i_h6_phy,
>  };
>  
> @@ -289,7 +290,13 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>  	}
>  
>  	if (data->cfg->type == sun8i_a83t_phy ||
> +	    data->cfg->type == sun50i_a100_phy ||
>  	    data->cfg->type == sun50i_h6_phy) {
> +		if (phy->pmu && data->cfg->enable_pmu_unk1) {
> +			val = readl(phy->pmu + REG_PMU_UNK1);
> +			writel(val & ~BIT(3), phy->pmu + REG_PMU_UNK1);
> +		}
> +
>  		if (phy->index == 0) {
>  			val = readl(data->base + data->cfg->phyctl_offset);
>  			val |= PHY_CTL_VBUSVLDEXT;
> @@ -339,6 +346,7 @@ static int sun4i_usb_phy_exit(struct phy *_phy)
>  
>  	if (phy->index == 0) {
>  		if (data->cfg->type == sun8i_a83t_phy ||
> +		    data->cfg->type == sun50i_a100_phy ||
>  		    data->cfg->type == sun50i_h6_phy) {
>  			void __iomem *phyctl = data->base +
>  				data->cfg->phyctl_offset;
> @@ -960,6 +968,16 @@ static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
>  	.phy0_dual_route = true,
>  };
>  
> +static const struct sun4i_usb_phy_cfg sun50i_a100_cfg = {
> +	.num_phys = 2,
> +	.type = sun50i_a100_phy,

So you could just use the sun50i_h6_phy type here.

Cheers,
Andre

> +	.disc_thresh = 3,
> +	.phyctl_offset = REG_PHYCTL_A33,
> +	.dedicated_clocks = true,
> +	.enable_pmu_unk1 = true,
> +	.phy0_dual_route = true,
> +};
> +
>  static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
>  	.num_phys = 4,
>  	.type = sun50i_h6_phy,
> @@ -983,6 +1001,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
>  	{ .compatible = "allwinner,sun8i-v3s-usb-phy", .data = &sun8i_v3s_cfg },
>  	{ .compatible = "allwinner,sun50i-a64-usb-phy",
>  	  .data = &sun50i_a64_cfg},
> +	{ .compatible = "allwinner,sun50i-a100-usb-phy", .data = &sun50i_a100_cfg },
>  	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data = &sun50i_h6_cfg },
>  	{ },
>  };
> 

