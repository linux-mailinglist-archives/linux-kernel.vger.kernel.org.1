Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4226A22F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIOJaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIOJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:30:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D4C06174A;
        Tue, 15 Sep 2020 02:30:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so2656254wmj.2;
        Tue, 15 Sep 2020 02:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6m9hGzpScNpe0b56EBK2dWXWtQbNdPaZy32XpIfUzGI=;
        b=tcTDpc01riv8x8bw9x6N+eXB9D0KSc8hBff90p2TcIddrEXpagnvQwoOfHIiq2QEZe
         4/XbDryeHTGZmotZzpbphwEpZXdn+HaPgtHeP6jyGcEBjuQyGqGgNwQ9ZJDxt85KjCLy
         o4z236CGZfSaN6XwGWaUtvbe+8zMnoEgnegftz69F3rMtBGyqa8ZsqirnPtfnaJwE5ff
         AkyM8GXqOTJPS09pSdKAwzkzMQ1zNqx67y//6IF5EC7cU8P2UJJ11fI00GF+ULwVCT79
         9pidFOHnR9a0poTLnJzd4FjIlTey6nOuD3xXPFtK/rjc94UqwQLVKkGRvwuztD90ItPu
         5Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6m9hGzpScNpe0b56EBK2dWXWtQbNdPaZy32XpIfUzGI=;
        b=BGNRtww2rHXAJne1rOrvYjrFC3zwfVmU4Y31nZCT8Zpgg/65OE/LR+hUOaIX5Q/OcI
         3hJewFdT4ml2svXtZKZAAj73QfkkbDx+6CbG4VQYUnusKHE9EGLpZ7uSZSfNfGl3Vm7G
         ld3jVFYZ5mIOAGJmYuQgneQarxNiFrk/zzs3PrcQxkmeGW+NKPhiGmE7as5QzbZVqkTo
         BGsZq8XsuWEzkRtx2j/5zBS1nKf9HdgUA0/j5dmFhiEZQNWoEMJHLQK4iH4Mbz/Lw66p
         lbfuKshjaPkE50IfS4UBjWiSRZ0HuWFYvGEv4gY/MKnQ+VBb482xEVP+mylz0h/XerO5
         OrSg==
X-Gm-Message-State: AOAM532v8ByzzLlMWOKTqgs2qjvCL6R1P85KmRmn7J7mWbqjWi++Dsl2
        4HDzJEJhe2wDATrHRqUAQYI=
X-Google-Smtp-Source: ABdhPJzwyWXM3j+1zKJzsaZddm6XEeqWVpwu4h1mo5BPsGyBZnXitccFClJ0eyb6nO5CQ99v3t3EEQ==
X-Received: by 2002:a1c:818f:: with SMTP id c137mr1724589wmd.0.1600162232889;
        Tue, 15 Sep 2020 02:30:32 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id l18sm19934057wrp.84.2020.09.15.02.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 02:30:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] soc: mediatek: add SCPSYS power dmain for MT8167 SoC
To:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     krzk@kernel.org, mars.cheng@mediatek.com, owen.chen@mediatek.com,
        macpaul.lin@mediatek.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20200906172337.1052933-1-fparent@baylibre.com>
 <20200906172337.1052933-2-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e0819b9c-4dfd-a36e-3ead-4a375fb244d0@gmail.com>
Date:   Tue, 15 Sep 2020 11:30:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200906172337.1052933-2-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

On 06/09/2020 19:23, Fabien Parent wrote:
> Add SCPSYS power domain support for MT8167 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

First of all, thanks for your patch!

The actual scpsys driver has some limitations. Enric and I are working on a new 
driver [1]. My idea is to deprecate the old scpsys driver in favor of this new one.

Would you mind to resend your series on top of [1]? From what I can see the 
changes in the driver will be minimal (change the bus protection macros and drop 
the clock ID). The DTS (which is not part of this series) would need some more 
work then.

Regards,
Matthias

[1] 
https://lore.kernel.org/linux-mediatek/20200910172826.3074357-1-enric.balletbo@collabora.com/T/#t

> ---
>   drivers/soc/mediatek/mtk-scpsys.c     | 99 +++++++++++++++++++++++++++
>   include/linux/soc/mediatek/infracfg.h |  8 +++
>   2 files changed, 107 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index f669d3754627..ce897720ef17 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -18,6 +18,7 @@
>   #include <dt-bindings/power/mt6797-power.h>
>   #include <dt-bindings/power/mt7622-power.h>
>   #include <dt-bindings/power/mt7623a-power.h>
> +#include <dt-bindings/power/mt8167-power.h>
>   #include <dt-bindings/power/mt8173-power.h>
>   
>   #define MTK_POLL_DELAY_US   10
> @@ -89,6 +90,7 @@ enum clk_id {
>   	CLK_HIFSEL,
>   	CLK_JPGDEC,
>   	CLK_AUDIO,
> +	CLK_AXI_MFG,
>   	CLK_MAX,
>   };
>   
> @@ -103,6 +105,7 @@ static const char * const clk_names[] = {
>   	"hif_sel",
>   	"jpgdec",
>   	"audio",
> +	"axi_mfg",
>   	NULL,
>   };
>   
> @@ -911,6 +914,87 @@ static const struct scp_domain_data scp_domain_data_mt7623a[] = {
>   	},
>   };
>   
> +/*
> + * MT8167 power domain support
> + */
> +#define PWR_STATUS_MFG_2D_MT8167	BIT(24)
> +#define PWR_STATUS_MFG_ASYNC_MT8167	BIT(25)
> +
> +static const struct scp_domain_data scp_domain_data_mt8167[] = {
> +	[MT8167_POWER_DOMAIN_DISP] = {
> +		.name = "disp",
> +		.sta_mask = PWR_STATUS_DISP,
> +		.ctl_offs = SPM_DIS_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.bus_prot_mask = MT8167_TOP_AXI_PROT_EN_MM_EMI |
> +				 MT8167_TOP_AXI_PROT_EN_MCU_MM,
> +		.clk_id = {CLK_MM},
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
> +	[MT8167_POWER_DOMAIN_VDEC] = {
> +		.name = "vdec",
> +		.sta_mask = PWR_STATUS_VDEC,
> +		.ctl_offs = SPM_VDE_PWR_CON,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.clk_id = {CLK_MM, CLK_VDEC},
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
> +	[MT8167_POWER_DOMAIN_ISP] = {
> +		.name = "isp",
> +		.sta_mask = PWR_STATUS_ISP,
> +		.ctl_offs = SPM_ISP_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +		.clk_id = {CLK_MM},
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
> +	[MT8167_POWER_DOMAIN_MFG_ASYNC] = {
> +		.name = "mfg_async",
> +		.sta_mask = PWR_STATUS_MFG_ASYNC_MT8167,
> +		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +		.bus_prot_mask = MT8167_TOP_AXI_PROT_EN_MCU_MFG |
> +				 MT8167_TOP_AXI_PROT_EN_MFG_EMI,
> +		.clk_id = {CLK_MFG, CLK_AXI_MFG},
> +	},
> +	[MT8167_POWER_DOMAIN_MFG_2D] = {
> +		.name = "mfg_2d",
> +		.sta_mask = PWR_STATUS_MFG_2D_MT8167,
> +		.ctl_offs = SPM_MFG_2D_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +		.clk_id = {CLK_NONE},
> +	},
> +	[MT8167_POWER_DOMAIN_MFG] = {
> +		.name = "mfg",
> +		.sta_mask = PWR_STATUS_MFG,
> +		.ctl_offs = SPM_MFG_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +		.clk_id = {CLK_NONE},
> +	},
> +	[MT8167_POWER_DOMAIN_CONN] = {
> +		.name = "conn",
> +		.sta_mask = PWR_STATUS_CONN,
> +		.ctl_offs = SPM_CONN_PWR_CON,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = 0,
> +		.bus_prot_mask = MT8167_TOP_AXI_PROT_EN_CONN_EMI |
> +				 MT8167_TOP_AXI_PROT_EN_CONN_MCU |
> +				 MT8167_TOP_AXI_PROT_EN_MCU_CONN,
> +		.clk_id = {CLK_NONE},
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
> +};
> +
> +static const struct scp_subdomain scp_subdomain_mt8167[] = {
> +	{MT8167_POWER_DOMAIN_MFG_ASYNC, MT8167_POWER_DOMAIN_MFG_2D},
> +	{MT8167_POWER_DOMAIN_MFG_2D, MT8167_POWER_DOMAIN_MFG},
> +};
> +
>   /*
>    * MT8173 power domain support
>    */
> @@ -1064,6 +1148,18 @@ static const struct scp_soc_data mt7623a_data = {
>   	.bus_prot_reg_update = true,
>   };
>   
> +static const struct scp_soc_data mt8167_data = {
> +	.domains = scp_domain_data_mt8167,
> +	.num_domains = ARRAY_SIZE(scp_domain_data_mt8167),
> +	.subdomains = scp_subdomain_mt8167,
> +	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt8167),
> +	.regs = {
> +		.pwr_sta_offs = SPM_PWR_STATUS,
> +		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> +	},
> +	.bus_prot_reg_update = true,
> +};
> +
>   static const struct scp_soc_data mt8173_data = {
>   	.domains = scp_domain_data_mt8173,
>   	.num_domains = ARRAY_SIZE(scp_domain_data_mt8173),
> @@ -1096,6 +1192,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
>   	}, {
>   		.compatible = "mediatek,mt7623a-scpsys",
>   		.data = &mt7623a_data,
> +	}, {
> +		.compatible = "mediatek,mt8167-scpsys",
> +		.data = &mt8167_data,
>   	}, {
>   		.compatible = "mediatek,mt8173-scpsys",
>   		.data = &mt8173_data,
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> index fd25f0148566..6ee49bf90acf 100644
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ b/include/linux/soc/mediatek/infracfg.h
> @@ -2,6 +2,14 @@
>   #ifndef __SOC_MEDIATEK_INFRACFG_H
>   #define __SOC_MEDIATEK_INFRACFG_H
>   
> +#define MT8167_TOP_AXI_PROT_EN_MM_EMI		BIT(1)
> +#define MT8167_TOP_AXI_PROT_EN_MCU_MFG		BIT(2)
> +#define MT8167_TOP_AXI_PROT_EN_CONN_EMI		BIT(4)
> +#define MT8167_TOP_AXI_PROT_EN_MFG_EMI		BIT(5)
> +#define MT8167_TOP_AXI_PROT_EN_CONN_MCU		BIT(8)
> +#define MT8167_TOP_AXI_PROT_EN_MCU_CONN		BIT(9)
> +#define MT8167_TOP_AXI_PROT_EN_MCU_MM		BIT(11)
> +
>   #define MT8173_TOP_AXI_PROT_EN_MCI_M2		BIT(0)
>   #define MT8173_TOP_AXI_PROT_EN_MM_M0		BIT(1)
>   #define MT8173_TOP_AXI_PROT_EN_MM_M1		BIT(2)
> 
