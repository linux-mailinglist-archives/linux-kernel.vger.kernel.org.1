Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7837278581
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgIYLBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:01:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:51576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbgIYLBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:01:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601031668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5oE6+yR6zGJba+lKIyto8XkckM+FKf5fOJNPN9/S2ss=;
        b=m8+QssIOi54sJ+FxaT/aLrWScH46iZDYh1IgzCa7SbS+dHKNeMOe4Unbd+0ZVQLuqJda1D
        dMg2ps1pFUBOSXHj4d7lYJmx4a7sLRGSRGUDd3IRhaXZQS5/BEGCEpxxjdr0kslVMGds8C
        CWckeSyLLYQppIZw0xoPLufDwBmFASc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53271AD1B;
        Fri, 25 Sep 2020 11:01:08 +0000 (UTC)
Subject: Re: [PATCH 06/12] soc: mediatek: pm-domains: Add SMI block as bus
 protection block
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-7-enric.balletbo@collabora.com>
 <1601030747.1346.63.camel@mtksdaap41>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <64b78b9f-1e9d-6178-ec13-7f354716928e@suse.com>
Date:   Fri, 25 Sep 2020 13:01:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1601030747.1346.63.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/09/2020 12:45, Weiyi Lu wrote:
> On Thu, 2020-09-10 at 19:28 +0200, Enric Balletbo i Serra wrote:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> Apart from the infracfg block, the SMI block is used to enable the bus
>> protection for some power domains. Add support for this block.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>   drivers/soc/mediatek/mtk-pm-domains.c | 64 ++++++++++++++++++++-------
>>   include/linux/soc/mediatek/infracfg.h |  6 +++
>>   2 files changed, 53 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
>> index f609c2d454fa..3aa430a60602 100644
>> --- a/drivers/soc/mediatek/mtk-pm-domains.c
>> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
>> @@ -56,8 +56,25 @@
>>   
>>   #define SPM_MAX_BUS_PROT_DATA		3
>>   
>> +#define _BUS_PROT(_mask, _set, _clr, _sta, _update) {	\
>> +		.bus_prot_mask = (_mask),		\
>> +		.bus_prot_set = _set,			\
>> +		.bus_prot_clr = _clr,			\
>> +		.bus_prot_sta = _sta,			\
>> +		.bus_prot_reg_update = _update,		\
>> +	}
>> +
>> +#define BUS_PROT_WR(_mask, _set, _clr, _sta)		\
>> +		_BUS_PROT(_mask, _set, _clr, _sta, false)
>> +
>> +#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
>> +		_BUS_PROT(_mask, _set, _clr, _sta, true)
>> +
>>   struct scpsys_bus_prot_data {
>>   	u32 bus_prot_mask;
>> +	u32 bus_prot_set;
>> +	u32 bus_prot_clr;
>> +	u32 bus_prot_sta;
>>   	bool bus_prot_reg_update;
>>   };
>>   
>> @@ -69,6 +86,7 @@ struct scpsys_bus_prot_data {
>>    * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>>    * @caps: The flag for active wake-up action.
>>    * @bp_infracfg: bus protection for infracfg subsystem
>> + * @bp_smi: bus protection for smi subsystem
>>    */
>>   struct scpsys_domain_data {
>>   	u32 sta_mask;
>> @@ -77,6 +95,7 @@ struct scpsys_domain_data {
>>   	u32 sram_pdn_ack_bits;
>>   	u8 caps;
>>   	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
>> +	const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
>>   };
>>   
>>   struct scpsys_domain {
>> @@ -86,6 +105,7 @@ struct scpsys_domain {
>>   	int num_clks;
>>   	struct clk_bulk_data *clks;
>>   	struct regmap *infracfg;
>> +	struct regmap *smi;
>>   };
>>   
>>   struct scpsys_soc_data {
>> @@ -173,9 +193,9 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
>>   		if (bpd[i].bus_prot_reg_update)
>>   			regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, mask);
>>   		else
>> -			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_SET, mask);
>> +			regmap_write(regmap, bpd[i].bus_prot_set, mask);
>>   
> 
> Could it be?
> 
> if (bpd[i].bus_prot_set)
> 	regmap_write(regmap, bpd[i].bus_prot_set, mask);
> else
> 	regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, mask);
> 

Nice catch. That's a bug here:
regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, mask)
should be
regmap_update_bits(regmap, bpd[i].bus_prot_set, mask, mask)

Regarding your question. No we can't do that as we use bus_prot_set variable for 
write and update and decide on bus_prot_reg_update which method to use.

>> -		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
>> +		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
>>   					       val, (val & mask) == mask,
>>   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>   		if (ret)
>> @@ -191,7 +211,11 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>>   	int ret;
>>   
>>   	ret = _scpsys_bus_protect_enable(bpd, pd->infracfg);
>> -	return ret;
>> +	if (ret)
>> +		return ret;
>> +
>> +	bpd = pd->data->bp_smi;
>> +	return _scpsys_bus_protect_enable(bpd, pd->smi);
>>   }
>>   
>>   static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
>> @@ -206,11 +230,11 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
>>   			return 0;
>>   
>>   		if (bpd[i].bus_prot_reg_update)
> 
> ditto.
> 
>> -			regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, 0);
>> +			regmap_update_bits(regmap, bpd[i].bus_prot_set, mask, 0);

As you can see here we use bpd[i].bus_prot_set
You could argue that we could check the bus_prot_clr to decide if we need an 
update or not, but I prefer an explicit variable to flag this. Implicite 
reasoning depending on values for bus_prot_clr will make the code harder to read 
and won't save a lot of memory.

>>   		else
>> -			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_CLR, mask);
>> +			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
>>   
>> -		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
>> +		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
>>   					       val, !(val & mask),
>>   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>   		if (ret)
>> @@ -226,7 +250,11 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>>   	int ret;
>>   
>>   	ret = _scpsys_bus_protect_disable(bpd, pd->infracfg);
>> -	return ret;
>> +	if (ret)
>> +		return ret;
>> +
>> +	bpd = pd->data->bp_smi;
>> +	return _scpsys_bus_protect_disable(bpd, pd->smi);
> 
> It should have a reverse order compared to the enable control. But I'd
> like to make it more flexible to any sequence, like INFRA->SMI->INFRA

Correct, we whould disable first SMI and then infracfg. Good catch!

Right now we don't have any hardware supported that does 
infracfg->SMI->infracfg. When that comes up we will need a good solution for the 
driver :)

Thanks for your review!
Matthias

> 
>>   }
>>   
>>   static int scpsys_power_on(struct generic_pm_domain *genpd)
>> @@ -360,6 +388,10 @@ static int scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node
>>   	if (IS_ERR(pd->infracfg))
>>   		pd->infracfg = NULL;
>>   
>> +	pd->smi = syscon_regmap_lookup_by_phandle(node, "mediatek,smi");
>> +	if (IS_ERR(pd->smi))
>> +		pd->smi = NULL;
>> +
>>   	pd->num_clks = of_clk_get_parent_count(node);
>>   	if (pd->num_clks > 0) {
>>   		pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
>> @@ -532,10 +564,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>>   		.ctl_offs = SPM_DIS_PWR_CON,
>>   		.sram_pdn_bits = GENMASK(11, 8),
>>   		.sram_pdn_ack_bits = GENMASK(12, 12),
>> -		.bp_infracfg[0] = {
>> -			.bus_prot_reg_update = true,
>> -			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
>> -				MT8173_TOP_AXI_PROT_EN_MM_M1,
>> +		.bp_infracfg = {
>> +			BUS_PROT_UPDATE_MT8173(MT8173_TOP_AXI_PROT_EN_MM_M0 |
>> +					       MT8173_TOP_AXI_PROT_EN_MM_M1),
>>   		},
>>   	},
>>   	[MT8173_POWER_DOMAIN_VENC_LT] = {
>> @@ -574,12 +605,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>>   		.ctl_offs = SPM_MFG_PWR_CON,
>>   		.sram_pdn_bits = GENMASK(13, 8),
>>   		.sram_pdn_ack_bits = GENMASK(21, 16),
>> -		.bp_infracfg[0] = {
>> -			.bus_prot_reg_update = true,
>> -			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
>> -				MT8173_TOP_AXI_PROT_EN_MFG_M0 |
>> -				MT8173_TOP_AXI_PROT_EN_MFG_M1 |
>> -				MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
>> +		.bp_infracfg = {
>> +			BUS_PROT_UPDATE_MT8173(MT8173_TOP_AXI_PROT_EN_MFG_S |
>> +					       MT8173_TOP_AXI_PROT_EN_MFG_M0 |
>> +					       MT8173_TOP_AXI_PROT_EN_MFG_M1 |
>> +					       MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
>>   		},
>>   	},
>>   };
>> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
>> index f967d02cc2ff..3f18cddffb44 100644
>> --- a/include/linux/soc/mediatek/infracfg.h
>> +++ b/include/linux/soc/mediatek/infracfg.h
>> @@ -37,6 +37,12 @@
>>   #define INFRA_TOPAXI_PROTECTEN_SET	0x0260
>>   #define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
>>   
>> +#define BUS_PROT_UPDATE_MT8173(_mask)			\
>> +	BUS_PROT_UPDATE(_mask,				\
>> +			INFRA_TOPAXI_PROTECTEN,		\
>> +			INFRA_TOPAXI_PROTECTEN_CLR,	\
>> +			INFRA_TOPAXI_PROTECTSTA1)
>> +
>>   int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
>>   		bool reg_update);
>>   int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> 
