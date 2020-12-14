Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB9E2D9199
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 02:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437747AbgLNBgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 20:36:33 -0500
Received: from foss.arm.com ([217.140.110.172]:43084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgLNBgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 20:36:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB201FB;
        Sun, 13 Dec 2020 17:35:46 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60E7F3F66E;
        Sun, 13 Dec 2020 17:35:44 -0800 (PST)
Subject: Re: [PATCH v2 14/21] phy: sun4i-usb: Rework "pmu_unk1" handling
To:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20201211011934.6171-1-andre.przywara@arm.com>
 <20201211011934.6171-15-andre.przywara@arm.com>
 <02cbecddf07dc46f8fb7e0d93b7532e3c239084e.camel@aosc.io>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <86fd61f1-9bdd-5004-758b-8e21134fadd2@arm.com>
Date:   Mon, 14 Dec 2020 01:35:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <02cbecddf07dc46f8fb7e0d93b7532e3c239084e.camel@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2020 18:24, Icenowy Zheng wrote:
> 在 2020-12-11星期五的 01:19 +0000，Andre Przywara写道：
>> Newer SoCs (A100, H616) need to clear a different bit in our
>> "unknown"
>> PMU PHY register.
> 
> It looks like that the unknown PHY register is PHYCTL register for each
> individual PHY, and the bit that is cleared is
> called SUNXI_HCI_PHY_CTRL_SIDDQ in the BSP (similar to
> the USBC_PHY_CTL_SIDDQ we cleared for main PHYCTL).

Oh, right, somehow I failed to find this in the BSP, I guess I got
confused over that similar symbol. I will put proper names to it.

Thanks!
Andre

>>
>> Generalise the existing code by allowing configs to specify a bitmask
>> of bits to clear.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  drivers/phy/allwinner/phy-sun4i-usb.c | 28 +++++++++++------------
>> ----
>>  1 file changed, 11 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c
>> b/drivers/phy/allwinner/phy-sun4i-usb.c
>> index 651d5e2a25ce..4ba0699e0bb4 100644
>> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
>> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
>> @@ -115,9 +115,9 @@ struct sun4i_usb_phy_cfg {
>>  	int hsic_index;
>>  	enum sun4i_usb_phy_type type;
>>  	u32 disc_thresh;
>> +	u32 pmu_unk1_clrbits;
>>  	u8 phyctl_offset;
>>  	bool dedicated_clocks;
>> -	bool enable_pmu_unk1;
>>  	bool phy0_dual_route;
>>  	int missing_phys;
>>  };
>> @@ -288,6 +288,12 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>>  		return ret;
>>  	}
>>  
>> +	if (phy->pmu && data->cfg->pmu_unk1_clrbits) {
>> +		val = readl(phy->pmu + REG_PMU_UNK1);
>> +		val &= ~data->cfg->pmu_unk1_clrbits;
>> +		writel(val, phy->pmu + REG_PMU_UNK1);
>> +	}
>> +
>>  	if (data->cfg->type == sun8i_a83t_phy ||
>>  	    data->cfg->type == sun50i_h6_phy) {
>>  		if (phy->index == 0) {
>> @@ -297,11 +303,6 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>>  			writel(val, data->base + data->cfg-
>>> phyctl_offset);
>>  		}
>>  	} else {
>> -		if (phy->pmu && data->cfg->enable_pmu_unk1) {
>> -			val = readl(phy->pmu + REG_PMU_UNK1);
>> -			writel(val & ~2, phy->pmu + REG_PMU_UNK1);
>> -		}
>> -
>>  		/* Enable USB 45 Ohm resistor calibration */
>>  		if (phy->index == 0)
>>  			sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN,
>> 0x01, 1);
>> @@ -867,7 +868,6 @@ static const struct sun4i_usb_phy_cfg
>> sun4i_a10_cfg = {
>>  	.disc_thresh = 3,
>>  	.phyctl_offset = REG_PHYCTL_A10,
>>  	.dedicated_clocks = false,
>> -	.enable_pmu_unk1 = false,
>>  };
>>  
>>  static const struct sun4i_usb_phy_cfg sun5i_a13_cfg = {
>> @@ -876,7 +876,6 @@ static const struct sun4i_usb_phy_cfg
>> sun5i_a13_cfg = {
>>  	.disc_thresh = 2,
>>  	.phyctl_offset = REG_PHYCTL_A10,
>>  	.dedicated_clocks = false,
>> -	.enable_pmu_unk1 = false,
>>  };
>>  
>>  static const struct sun4i_usb_phy_cfg sun6i_a31_cfg = {
>> @@ -885,7 +884,6 @@ static const struct sun4i_usb_phy_cfg
>> sun6i_a31_cfg = {
>>  	.disc_thresh = 3,
>>  	.phyctl_offset = REG_PHYCTL_A10,
>>  	.dedicated_clocks = true,
>> -	.enable_pmu_unk1 = false,
>>  };
>>  
>>  static const struct sun4i_usb_phy_cfg sun7i_a20_cfg = {
>> @@ -894,7 +892,6 @@ static const struct sun4i_usb_phy_cfg
>> sun7i_a20_cfg = {
>>  	.disc_thresh = 2,
>>  	.phyctl_offset = REG_PHYCTL_A10,
>>  	.dedicated_clocks = false,
>> -	.enable_pmu_unk1 = false,
>>  };
>>  
>>  static const struct sun4i_usb_phy_cfg sun8i_a23_cfg = {
>> @@ -903,7 +900,6 @@ static const struct sun4i_usb_phy_cfg
>> sun8i_a23_cfg = {
>>  	.disc_thresh = 3,
>>  	.phyctl_offset = REG_PHYCTL_A10,
>>  	.dedicated_clocks = true,
>> -	.enable_pmu_unk1 = false,
>>  };
>>  
>>  static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
>> @@ -912,7 +908,6 @@ static const struct sun4i_usb_phy_cfg
>> sun8i_a33_cfg = {
>>  	.disc_thresh = 3,
>>  	.phyctl_offset = REG_PHYCTL_A33,
>>  	.dedicated_clocks = true,
>> -	.enable_pmu_unk1 = false,
>>  };
>>  
>>  static const struct sun4i_usb_phy_cfg sun8i_a83t_cfg = {
>> @@ -929,7 +924,7 @@ static const struct sun4i_usb_phy_cfg
>> sun8i_h3_cfg = {
>>  	.disc_thresh = 3,
>>  	.phyctl_offset = REG_PHYCTL_A33,
>>  	.dedicated_clocks = true,
>> -	.enable_pmu_unk1 = true,
>> +	.pmu_unk1_clrbits = BIT(1),
>>  	.phy0_dual_route = true,
>>  };
>>  
>> @@ -939,7 +934,7 @@ static const struct sun4i_usb_phy_cfg
>> sun8i_r40_cfg = {
>>  	.disc_thresh = 3,
>>  	.phyctl_offset = REG_PHYCTL_A33,
>>  	.dedicated_clocks = true,
>> -	.enable_pmu_unk1 = true,
>> +	.pmu_unk1_clrbits = BIT(1),
>>  	.phy0_dual_route = true,
>>  };
>>  
>> @@ -949,7 +944,7 @@ static const struct sun4i_usb_phy_cfg
>> sun8i_v3s_cfg = {
>>  	.disc_thresh = 3,
>>  	.phyctl_offset = REG_PHYCTL_A33,
>>  	.dedicated_clocks = true,
>> -	.enable_pmu_unk1 = true,
>> +	.pmu_unk1_clrbits = BIT(1),
>>  	.phy0_dual_route = true,
>>  };
>>  
>> @@ -959,7 +954,7 @@ static const struct sun4i_usb_phy_cfg
>> sun50i_a64_cfg = {
>>  	.disc_thresh = 3,
>>  	.phyctl_offset = REG_PHYCTL_A33,
>>  	.dedicated_clocks = true,
>> -	.enable_pmu_unk1 = true,
>> +	.pmu_unk1_clrbits = BIT(1),
>>  	.phy0_dual_route = true,
>>  };
>>  
>> @@ -969,7 +964,6 @@ static const struct sun4i_usb_phy_cfg
>> sun50i_h6_cfg = {
>>  	.disc_thresh = 3,
>>  	.phyctl_offset = REG_PHYCTL_A33,
>>  	.dedicated_clocks = true,
>> -	.enable_pmu_unk1 = true,
>>  	.phy0_dual_route = true,
>>  	.missing_phys = BIT(1) | BIT(2),
>>  };

