Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D8C280F51
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgJBI4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBI4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:56:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E52C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 01:56:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k10so891931wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 01:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rm0gp7zsjs/Pb6mKuHm8E7eDeyA4zTnaJea3hkfs65s=;
        b=p91v9RDz6QmSx7lfwIeTrIp82Fj8mDfnoybf2gboFAwtXrjKg7c3dzWMQT7iAJQWlo
         Q8kv+cW0jsv4d0VTt7cJjtxo0edU5OrWevnCR6zx9AxtGcBfVMhHA9PTP0d+HNHes2x9
         51/h3AGMRE1SMh2Ed3GVvHGbJCiu6MFZa/G+R0gpGZ9Q0YSYt/mIGUKlrsDcLR0s9k4m
         RuRrU205Cq60vu4xwwZhiYk0Tq8Z3q7FcE9Nbz3JUcBQGMgNyYXZa4I1X8hvfvq2m7lI
         mlluifpsH48ScqI1gxl2gVf0BqunE5J5qUBxARLdYngp27JpdLwi/DxjJjKKWRnlUWaI
         Xb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rm0gp7zsjs/Pb6mKuHm8E7eDeyA4zTnaJea3hkfs65s=;
        b=cggi2op0p3CiAWLKO0jO4wpGBS8899WotZG/MbHxETUikmoqL8YtbwD6fsl7MxP1/y
         vb9AFPcpXa8XFDBYrtL6Vx1spdWPnEufXOzcGc0+psQ4eVPzs4aemxGhExRfqFQAbX30
         LmdfefmHw+G4sdPKIeUd+MrUE4+7pe4EPvLlrjQcOyelNVY22GQ9nMGfvC+2DiwzWkiy
         Ko82LvjzLaD1Qd2llg8cxX3jkw1M2YfM1d8bamVNusXCF87ODyhVn3cWfQlTQYKVL3HI
         MQ674iu/UpHLXLhUcH3Em1NPkzAk0z+ItJ5bkCqJrHO7gupFtJYUsxthi/yMBxy6jnz2
         FTXw==
X-Gm-Message-State: AOAM531cI6Z06FetyXpIWtZObBs+R2EwDjn8ESxUOE6l3GZdLJ4WQ94G
        5GhfWkAPAedgtoUE4dvqDt4=
X-Google-Smtp-Source: ABdhPJz9ko43LO8DPoVhNKFsXPp6ZkJpbJQcjHpNeEz+tOZqHCyj7T7NzjTf4FKj+0bDmIjzHHdrhw==
X-Received: by 2002:a5d:69c2:: with SMTP id s2mr1774239wrw.389.1601628965912;
        Fri, 02 Oct 2020 01:56:05 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id v9sm1089396wrv.35.2020.10.02.01.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 01:56:05 -0700 (PDT)
Subject: Re: [PATCH v2 06/12] soc: mediatek: pm-domains: Add SMI block as bus
 protection block
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
 <20201001160154.3587848-7-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <ee2b40c3-b565-22ed-34f4-4259d546a623@gmail.com>
Date:   Fri, 2 Oct 2020 10:56:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001160154.3587848-7-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2020 18:01, Enric Balletbo i Serra wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Apart from the infracfg block, the SMI block is used to enable the bus
> protection for some power domains. Add support for this block.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2: None
> 
>   drivers/soc/mediatek/mtk-pm-domains.c | 64 ++++++++++++++++++++-------
>   include/linux/soc/mediatek/infracfg.h |  6 +++
>   2 files changed, 53 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index b5e7c9846c34..38f2630bdd0a 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -56,8 +56,25 @@
>   
>   #define SPM_MAX_BUS_PROT_DATA		3
>   
> +#define _BUS_PROT(_mask, _set, _clr, _sta, _update) {	\
> +		.bus_prot_mask = (_mask),		\
> +		.bus_prot_set = _set,			\
> +		.bus_prot_clr = _clr,			\
> +		.bus_prot_sta = _sta,			\
> +		.bus_prot_reg_update = _update,		\
> +	}
> +
> +#define BUS_PROT_WR(_mask, _set, _clr, _sta)		\
> +		_BUS_PROT(_mask, _set, _clr, _sta, false)
> +
> +#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
> +		_BUS_PROT(_mask, _set, _clr, _sta, true)
> +
>   struct scpsys_bus_prot_data {
>   	u32 bus_prot_mask;
> +	u32 bus_prot_set;
> +	u32 bus_prot_clr;
> +	u32 bus_prot_sta;
>   	bool bus_prot_reg_update;
>   };
>   
> @@ -69,6 +86,7 @@ struct scpsys_bus_prot_data {
>    * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>    * @caps: The flag for active wake-up action.
>    * @bp_infracfg: bus protection for infracfg subsystem
> + * @bp_smi: bus protection for smi subsystem
>    */
>   struct scpsys_domain_data {
>   	u32 sta_mask;
> @@ -77,6 +95,7 @@ struct scpsys_domain_data {
>   	u32 sram_pdn_ack_bits;
>   	u8 caps;
>   	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
> +	const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
>   };
>   
>   struct scpsys_domain {
> @@ -86,6 +105,7 @@ struct scpsys_domain {
>   	int num_clks;
>   	struct clk_bulk_data *clks;
>   	struct regmap *infracfg;
> +	struct regmap *smi;
>   };
>   
>   struct scpsys_soc_data {
> @@ -175,9 +195,9 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
>   		if (bpd[i].bus_prot_reg_update)
>   			regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, mask);
>   		else
> -			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_SET, mask);
> +			regmap_write(regmap, bpd[i].bus_prot_set, mask);
>   
> -		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
> +		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
>   					       val, (val & mask) == mask,
>   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>   		if (ret)
> @@ -193,7 +213,11 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>   	int ret;
>   
>   	ret = _scpsys_bus_protect_enable(bpd, pd->infracfg);
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	bpd = pd->data->bp_smi;
> +	return _scpsys_bus_protect_enable(bpd, pd->smi);
>   }
>   
>   static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
> @@ -208,11 +232,11 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
>   			return 0;
>   
>   		if (bpd[i].bus_prot_reg_update)
> -			regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, 0);
> +			regmap_update_bits(regmap, bpd[i].bus_prot_set, mask, 0);
>   		else
> -			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_CLR, mask);
> +			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
>   
> -		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
> +		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
>   					       val, !(val & mask),
>   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>   		if (ret)
> @@ -228,7 +252,11 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>   	int ret;
>   
>   	ret = _scpsys_bus_protect_disable(bpd, pd->infracfg);
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	bpd = pd->data->bp_smi;
> +	return _scpsys_bus_protect_disable(bpd, pd->smi);

Also it seems not to break the system we should disable pd->smi first and after 
that pd->infracfg (just the other way round as we did in enable).

>   }
>   
>   static int scpsys_power_on(struct generic_pm_domain *genpd)
> @@ -358,6 +386,10 @@ static int scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node
>   	if (IS_ERR(pd->infracfg))
>   		pd->infracfg = NULL;
>   
> +	pd->smi = syscon_regmap_lookup_by_phandle(node, "mediatek,smi");
> +	if (IS_ERR(pd->smi))
> +		pd->smi = NULL;
> +
>   	pd->num_clks = of_clk_get_parent_count(node);
>   	if (pd->num_clks > 0) {
>   		pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
> @@ -528,10 +560,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>   		.ctl_offs = SPM_DIS_PWR_CON,
>   		.sram_pdn_bits = GENMASK(11, 8),
>   		.sram_pdn_ack_bits = GENMASK(12, 12),
> -		.bp_infracfg[0] = {
> -			.bus_prot_reg_update = true,
> -			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
> -				MT8173_TOP_AXI_PROT_EN_MM_M1,
> +		.bp_infracfg = {
> +			BUS_PROT_UPDATE_MT8173(MT8173_TOP_AXI_PROT_EN_MM_M0 |
> +					       MT8173_TOP_AXI_PROT_EN_MM_M1),
>   		},
>   	},
>   	[MT8173_POWER_DOMAIN_VENC_LT] = {
> @@ -570,12 +601,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>   		.ctl_offs = SPM_MFG_PWR_CON,
>   		.sram_pdn_bits = GENMASK(13, 8),
>   		.sram_pdn_ack_bits = GENMASK(21, 16),
> -		.bp_infracfg[0] = {
> -			.bus_prot_reg_update = true,
> -			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
> -				MT8173_TOP_AXI_PROT_EN_MFG_M0 |
> -				MT8173_TOP_AXI_PROT_EN_MFG_M1 |
> -				MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
> +		.bp_infracfg = {
> +			BUS_PROT_UPDATE_MT8173(MT8173_TOP_AXI_PROT_EN_MFG_S |
> +					       MT8173_TOP_AXI_PROT_EN_MFG_M0 |
> +					       MT8173_TOP_AXI_PROT_EN_MFG_M1 |
> +					       MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
>   		},
>   	},
>   };
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> index f967d02cc2ff..3f18cddffb44 100644
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ b/include/linux/soc/mediatek/infracfg.h
> @@ -37,6 +37,12 @@
>   #define INFRA_TOPAXI_PROTECTEN_SET	0x0260
>   #define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
>   
> +#define BUS_PROT_UPDATE_MT8173(_mask)			\

While at it, could you update this to call it:
BUS_PROT_UPDATE_TOPAXI as in all the other SoCs TOPAXI is mapped to the same 
address.

Thanks!
Matthias

> +	BUS_PROT_UPDATE(_mask,				\
> +			INFRA_TOPAXI_PROTECTEN,		\
> +			INFRA_TOPAXI_PROTECTEN_CLR,	\
> +			INFRA_TOPAXI_PROTECTSTA1)
> +
>   int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
>   		bool reg_update);
>   int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> 
