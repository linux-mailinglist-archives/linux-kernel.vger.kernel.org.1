Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA426C0F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgIPJrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgIPJqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:46:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2289C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:46:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e11so1843181wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Fkj8wM5yKsC66SuEjUDzuKRYwhCBNReGicCTVS1Nys=;
        b=Yd0XMxNgdeEVFS6Lmf+We78L1hwP+qj31BJWYueFnM1J9OLvSOMmddmDRuXwTNv+J4
         tn6r5fGZL80nR/RSli+w8eNFW16y7jtIxsMSFZ9ZYayO+WV5FA/W/G25jkbusCh4YJYb
         eqE1aE/9hmGuktu7we9Kc8ryGIsAFce2E+pqWYBTDhSQ4kNpdMj421Q5IkUwInnWOyef
         8BTXh9gtSsF29GDSyMycCDZWy8niQqujry1Iu9YA0VQ/V7Orohm0/rBVKHXrngfRrlOD
         FvyOKfOGE47d/6WaQjApuCCQRpKBra2c54QcFD/x3YI32nBPQn9tvTLthB+EPqpVEIFn
         UXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Fkj8wM5yKsC66SuEjUDzuKRYwhCBNReGicCTVS1Nys=;
        b=hZTy5FohBK8BKywgexdoUWzUQlq3wJMapgkuI7RUl6bZP6NOc5ixZN+hYvKvGDCe9h
         5rtel5l0CvX5GSz2Ic2lgni5wHeldd7pfMvl76k41ecCyynkxOZqzMVgKMewNCNfhR65
         Q+rg5+jQo2MjKheGOOniTMbro1DBjf3cnUThbG/p1czkFr6mFAB5hlh/mi2Zu4cgz+O7
         4hxg6Pjdn9vDj4wOk5gSbJRFfNOjio7sxiquhHOGscbAC6lHUJmcS9z4XaK3oZ3kzzgP
         ynIBpRCtK1mCdaWx+jGKK3g9Fokx/IAdbC6QaFNcPvq6RyAv61G/cQofAOsKf1IxL8i2
         /TJg==
X-Gm-Message-State: AOAM530ADZQ7qix9zuDnCqam+gKcqWNxQPooa7MmhrKGNeQeLbDEqugP
        lb7KIaNMTntFomGr4aqFCWc=
X-Google-Smtp-Source: ABdhPJxPzUKf1K5YwPYcd6/6eV/PrHqUKjHJmhaTTGrryBOLqbu52jYYoK1GQAIKfXsa+u5reoNWNA==
X-Received: by 2002:a1c:a953:: with SMTP id s80mr3741146wme.70.1600249602514;
        Wed, 16 Sep 2020 02:46:42 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id s17sm33391388wrr.40.2020.09.16.02.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 02:46:41 -0700 (PDT)
Subject: Re: [PATCH 11/12] soc: mediatek: pm-domains: Add support for mt8183
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-12-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <730273b4-914a-8a7a-1583-351e6f20df5b@gmail.com>
Date:   Wed, 16 Sep 2020 11:46:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910172826.3074357-12-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2020 19:28, Enric Balletbo i Serra wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Add the needed board data to support mt8183 SoC.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>   drivers/soc/mediatek/mtk-pm-domains.c | 162 ++++++++++++++++++++++++++
>   include/linux/soc/mediatek/infracfg.h |  28 +++++
>   2 files changed, 190 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 29e88adc8ea6..aa434f616fee 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
[...]
>   
> +/*
> + * MT8183 power domain support
> + */
> +static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
> +	[MT8183_POWER_DOMAIN_AUDIO] = {
> +		.sta_mask = PWR_STATUS_AUDIO,
> +		.ctl_offs = 0x0314,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +	},
> +	[MT8183_POWER_DOMAIN_CONN] = {
> +		.sta_mask = PWR_STATUS_CONN,
> +		.ctl_offs = 0x032c,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +		.bp_infracfg = {
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_CONN, 0x2a0, 0x2a4, 0x228),

We have repeating values triplets for set, clear and status register in infracfg 
and SMI.

Weiyi can you help to get names to this registers? I wasn't able to find 
anything in the datasheet.

Thanks!
Matthias

> +		},
> +	},
> +	[MT8183_POWER_DOMAIN_MFG_ASYNC] = {
> +		.sta_mask = PWR_STATUS_MFG_ASYNC,
> +		.ctl_offs = 0x0334,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +	},
> +	[MT8183_POWER_DOMAIN_MFG] = {
> +		.sta_mask = PWR_STATUS_MFG,
> +		.ctl_offs = 0x0338,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +	},
> +	[MT8183_POWER_DOMAIN_MFG_CORE0] = {
> +		.sta_mask = BIT(7),
> +		.ctl_offs = 0x034c,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +	},
> +	[MT8183_POWER_DOMAIN_MFG_CORE1] = {
> +		.sta_mask = BIT(20),
> +		.ctl_offs = 0x0310,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +	},
> +	[MT8183_POWER_DOMAIN_MFG_2D] = {
> +		.sta_mask = PWR_STATUS_MFG_2D,
> +		.ctl_offs = 0x0348,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.bp_infracfg = {
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_1_MFG, 0x2a8, 0x2ac, 0x258),
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MFG, 0x2a0, 0x2a4, 0x228),
> +		},
> +	},
> +	[MT8183_POWER_DOMAIN_DISP] = {
> +		.sta_mask = PWR_STATUS_DISP,
> +		.ctl_offs = 0x030c,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.bp_infracfg = {
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_1_DISP, 0x2a8, 0x2ac, 0x258),
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_DISP, 0x2a0, 0x2a4, 0x228),
> +		},
> +		.bp_smi = {
> +			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_DISP, 0x3c4, 0x3c8, 0x3c0),
> +		},
> +	},
> +	[MT8183_POWER_DOMAIN_CAM] = {
> +		.sta_mask = BIT(25),
> +		.ctl_offs = 0x0344,
> +		.sram_pdn_bits = GENMASK(9, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +		.bp_infracfg = {
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MM_CAM, 0x2d4, 0x2d8, 0x2ec),
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_CAM, 0x2a0, 0x2a4, 0x228),
> +			BUS_PROT_WR_IGN(MT8183_TOP_AXI_PROT_EN_MM_CAM_2ND, 0x2d4, 0x2d8, 0x2ec),
> +		},
> +		.bp_smi = {
> +			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_CAM, 0x3c4, 0x3c8, 0x3c0),
> +		},
> +	},
> +	[MT8183_POWER_DOMAIN_ISP] = {
> +		.sta_mask = PWR_STATUS_ISP,
> +		.ctl_offs = 0x0308,
> +		.sram_pdn_bits = GENMASK(9, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +		.bp_infracfg = {
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MM_ISP, 0x2d4, 0x2d8, 0x2ec),
> +			BUS_PROT_WR_IGN(MT8183_TOP_AXI_PROT_EN_MM_ISP_2ND, 0x2d4, 0x2d8, 0x2ec),
> +		},
> +		.bp_smi = {
> +			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_ISP, 0x3c4, 0x3c8, 0x3c0),
> +		},
> +	},
> +	[MT8183_POWER_DOMAIN_VDEC] = {
> +		.sta_mask = BIT(31),
> +		.ctl_offs = 0x0300,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.bp_smi = {
> +			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_VDEC, 0x3c4, 0x3c8, 0x3c0),
> +		},
> +	},
> +	[MT8183_POWER_DOMAIN_VENC] = {
> +		.sta_mask = PWR_STATUS_VENC,
> +		.ctl_offs = 0x0304,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +		.bp_smi = {
> +			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_VENC, 0x3c4, 0x3c8, 0x3c0),
> +		},
> +	},
> +	[MT8183_POWER_DOMAIN_VPU_TOP] = {
> +		.sta_mask = BIT(26),
> +		.ctl_offs = 0x0324,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.bp_infracfg = {
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP, 0x2d4, 0x2d8, 0x2ec),
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_VPU_TOP, 0x2a0, 0x2a4, 0x228),
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP_2ND, 0x2d4, 0x2d8, 0x2ec),
> +		},
> +		.bp_smi = {
> +			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_VPU_TOP, 0x3c4, 0x3c8, 0x3c0),
> +		},
> +	},
> +	[MT8183_POWER_DOMAIN_VPU_CORE0] = {
> +		.sta_mask = BIT(27),
> +		.ctl_offs = 0x33c,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +		.bp_infracfg = {
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0, 0x2c4, 0x2c8, 0x2e4),
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0_2ND, 0x2c4, 0x2c8, 0x2e4),
> +		},
> +		.caps = MTK_SCPD_SRAM_ISO,
> +	},
> +	[MT8183_POWER_DOMAIN_VPU_CORE1] = {
> +		.sta_mask = BIT(28),
> +		.ctl_offs = 0x0340,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +		.bp_infracfg = {
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1, 0x2c4, 0x2c8, 0x2e4),
> +			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1_2ND, 0x2c4, 0x2c8, 0x2e4),
> +		},
> +		.caps = MTK_SCPD_SRAM_ISO,
> +	},
> +};
> +
>   static const struct scpsys_soc_data mt8173_scpsys_data = {
>   	.domains = scpsys_domain_data_mt8173,
>   	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8173),
> @@ -705,11 +856,22 @@ static const struct scpsys_soc_data mt8173_scpsys_data = {
>   	.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
>   };
>   
> +static const struct scpsys_soc_data mt8183_scpsys_data = {
> +	.domains = scpsys_domain_data_mt8183,
> +	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8183),
> +	.pwr_sta_offs = 0x0180,
> +	.pwr_sta2nd_offs = 0x0184
> +};
> +
>   static const struct of_device_id scpsys_of_match[] = {
>   	{
>   		.compatible = "mediatek,mt8173-power-controller",
>   		.data = &mt8173_scpsys_data,
>   	},
> +	{
> +		.compatible = "mediatek,mt8183-power-controller",
> +		.data = &mt8183_scpsys_data,
> +	},
>   	{ }
>   };
>   
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> index 3f18cddffb44..2913ede9d734 100644
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ b/include/linux/soc/mediatek/infracfg.h
> @@ -2,6 +2,34 @@
>   #ifndef __SOC_MEDIATEK_INFRACFG_H
>   #define __SOC_MEDIATEK_INFRACFG_H
>   
> +#define MT8183_TOP_AXI_PROT_EN_DISP			(BIT(10) | BIT(11))
> +#define MT8183_TOP_AXI_PROT_EN_CONN			(BIT(13) | BIT(14))
> +#define MT8183_TOP_AXI_PROT_EN_MFG			(BIT(21) | BIT(22))
> +#define MT8183_TOP_AXI_PROT_EN_CAM			BIT(28)
> +#define MT8183_TOP_AXI_PROT_EN_VPU_TOP			BIT(27)
> +#define MT8183_TOP_AXI_PROT_EN_1_DISP			(BIT(16) | BIT(17))
> +#define MT8183_TOP_AXI_PROT_EN_1_MFG			GENMASK(21, 19)
> +#define MT8183_TOP_AXI_PROT_EN_MM_ISP			(BIT(3) | BIT(8))
> +#define MT8183_TOP_AXI_PROT_EN_MM_ISP_2ND		BIT(10)
> +#define MT8183_TOP_AXI_PROT_EN_MM_CAM			(BIT(4) | BIT(5) | \
> +							 BIT(9) | BIT(13))
> +#define MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP		(GENMASK(9, 6) | \
> +							 BIT(12))
> +#define MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP_2ND		(BIT(10) | BIT(11))
> +#define MT8183_TOP_AXI_PROT_EN_MM_CAM_2ND		BIT(11)
> +#define MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0_2ND	(BIT(0) | BIT(2) | \
> +							 BIT(4))
> +#define MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1_2ND	(BIT(1) | BIT(3) | \
> +							 BIT(5))
> +#define MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0		BIT(6)
> +#define MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1		BIT(7)
> +#define MT8183_SMI_COMMON_SMI_CLAMP_DISP		GENMASK(7, 0)
> +#define MT8183_SMI_COMMON_SMI_CLAMP_VENC		BIT(1)
> +#define MT8183_SMI_COMMON_SMI_CLAMP_ISP			BIT(2)
> +#define MT8183_SMI_COMMON_SMI_CLAMP_CAM			(BIT(3) | BIT(4))
> +#define MT8183_SMI_COMMON_SMI_CLAMP_VPU_TOP		(BIT(5) | BIT(6))
> +#define MT8183_SMI_COMMON_SMI_CLAMP_VDEC		BIT(7)
> +
>   #define MT8173_TOP_AXI_PROT_EN_MCI_M2		BIT(0)
>   #define MT8173_TOP_AXI_PROT_EN_MM_M0		BIT(1)
>   #define MT8173_TOP_AXI_PROT_EN_MM_M1		BIT(2)
> 
