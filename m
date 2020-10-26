Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4832990D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783605AbgJZPSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:18:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60502 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783164AbgJZPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:18:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E7C251F44A89
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2 06/12] soc: mediatek: pm-domains: Add SMI block as bus
 protection block
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
 <20201001160154.3587848-7-enric.balletbo@collabora.com>
 <ee2b40c3-b565-22ed-34f4-4259d546a623@gmail.com>
Message-ID: <728d3c36-0f89-c3f9-e9f8-88a3a671cd02@collabora.com>
Date:   Mon, 26 Oct 2020 16:18:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ee2b40c3-b565-22ed-34f4-4259d546a623@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thank you for your review.

On 2/10/20 10:56, Matthias Brugger wrote:
> 
> 
> On 01/10/2020 18:01, Enric Balletbo i Serra wrote:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> Apart from the infracfg block, the SMI block is used to enable the bus
>> protection for some power domains. Add support for this block.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v2: None
>>
>>   drivers/soc/mediatek/mtk-pm-domains.c | 64 ++++++++++++++++++++-------
>>   include/linux/soc/mediatek/infracfg.h |  6 +++
>>   2 files changed, 53 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c
>> b/drivers/soc/mediatek/mtk-pm-domains.c
>> index b5e7c9846c34..38f2630bdd0a 100644
>> --- a/drivers/soc/mediatek/mtk-pm-domains.c
>> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
>> @@ -56,8 +56,25 @@
>>     #define SPM_MAX_BUS_PROT_DATA        3
>>   +#define _BUS_PROT(_mask, _set, _clr, _sta, _update) {    \
>> +        .bus_prot_mask = (_mask),        \
>> +        .bus_prot_set = _set,            \
>> +        .bus_prot_clr = _clr,            \
>> +        .bus_prot_sta = _sta,            \
>> +        .bus_prot_reg_update = _update,        \
>> +    }
>> +
>> +#define BUS_PROT_WR(_mask, _set, _clr, _sta)        \
>> +        _BUS_PROT(_mask, _set, _clr, _sta, false)
>> +
>> +#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)        \
>> +        _BUS_PROT(_mask, _set, _clr, _sta, true)
>> +
>>   struct scpsys_bus_prot_data {
>>       u32 bus_prot_mask;
>> +    u32 bus_prot_set;
>> +    u32 bus_prot_clr;
>> +    u32 bus_prot_sta;
>>       bool bus_prot_reg_update;
>>   };
>>   @@ -69,6 +86,7 @@ struct scpsys_bus_prot_data {
>>    * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>>    * @caps: The flag for active wake-up action.
>>    * @bp_infracfg: bus protection for infracfg subsystem
>> + * @bp_smi: bus protection for smi subsystem
>>    */
>>   struct scpsys_domain_data {
>>       u32 sta_mask;
>> @@ -77,6 +95,7 @@ struct scpsys_domain_data {
>>       u32 sram_pdn_ack_bits;
>>       u8 caps;
>>       const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
>> +    const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
>>   };
>>     struct scpsys_domain {
>> @@ -86,6 +105,7 @@ struct scpsys_domain {
>>       int num_clks;
>>       struct clk_bulk_data *clks;
>>       struct regmap *infracfg;
>> +    struct regmap *smi;
>>   };
>>     struct scpsys_soc_data {
>> @@ -175,9 +195,9 @@ static int _scpsys_bus_protect_enable(const struct
>> scpsys_bus_prot_data *bpd, st
>>           if (bpd[i].bus_prot_reg_update)
>>               regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, mask);
>>           else
>> -            regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_SET, mask);
>> +            regmap_write(regmap, bpd[i].bus_prot_set, mask);
>>   -        ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
>> +        ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
>>                              val, (val & mask) == mask,
>>                              MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>           if (ret)
>> @@ -193,7 +213,11 @@ static int scpsys_bus_protect_enable(struct scpsys_domain
>> *pd)
>>       int ret;
>>         ret = _scpsys_bus_protect_enable(bpd, pd->infracfg);
>> -    return ret;
>> +    if (ret)
>> +        return ret;
>> +
>> +    bpd = pd->data->bp_smi;
>> +    return _scpsys_bus_protect_enable(bpd, pd->smi);
>>   }
>>     static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data
>> *bpd,
>> @@ -208,11 +232,11 @@ static int _scpsys_bus_protect_disable(const struct
>> scpsys_bus_prot_data *bpd,
>>               return 0;
>>             if (bpd[i].bus_prot_reg_update)
>> -            regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, 0);
>> +            regmap_update_bits(regmap, bpd[i].bus_prot_set, mask, 0);
>>           else
>> -            regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_CLR, mask);
>> +            regmap_write(regmap, bpd[i].bus_prot_clr, mask);
>>   -        ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
>> +        ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
>>                              val, !(val & mask),
>>                              MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>           if (ret)
>> @@ -228,7 +252,11 @@ static int scpsys_bus_protect_disable(struct
>> scpsys_domain *pd)
>>       int ret;
>>         ret = _scpsys_bus_protect_disable(bpd, pd->infracfg);
>> -    return ret;
>> +    if (ret)
>> +        return ret;
>> +
>> +    bpd = pd->data->bp_smi;
>> +    return _scpsys_bus_protect_disable(bpd, pd->smi);
> 
> Also it seems not to break the system we should disable pd->smi first and after
> that pd->infracfg (just the other way round as we did in enable).
> 

Done in next version.


>>   }
>>     static int scpsys_power_on(struct generic_pm_domain *genpd)
>> @@ -358,6 +386,10 @@ static int scpsys_add_one_domain(struct scpsys *scpsys,
>> struct device_node *node
>>       if (IS_ERR(pd->infracfg))
>>           pd->infracfg = NULL;
>>   +    pd->smi = syscon_regmap_lookup_by_phandle(node, "mediatek,smi");
>> +    if (IS_ERR(pd->smi))
>> +        pd->smi = NULL;
>> +
>>       pd->num_clks = of_clk_get_parent_count(node);
>>       if (pd->num_clks > 0) {
>>           pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks,
>> sizeof(*pd->clks), GFP_KERNEL);
>> @@ -528,10 +560,9 @@ static const struct scpsys_domain_data
>> scpsys_domain_data_mt8173[] = {
>>           .ctl_offs = SPM_DIS_PWR_CON,
>>           .sram_pdn_bits = GENMASK(11, 8),
>>           .sram_pdn_ack_bits = GENMASK(12, 12),
>> -        .bp_infracfg[0] = {
>> -            .bus_prot_reg_update = true,
>> -            .bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
>> -                MT8173_TOP_AXI_PROT_EN_MM_M1,
>> +        .bp_infracfg = {
>> +            BUS_PROT_UPDATE_MT8173(MT8173_TOP_AXI_PROT_EN_MM_M0 |
>> +                           MT8173_TOP_AXI_PROT_EN_MM_M1),
>>           },
>>       },
>>       [MT8173_POWER_DOMAIN_VENC_LT] = {
>> @@ -570,12 +601,11 @@ static const struct scpsys_domain_data
>> scpsys_domain_data_mt8173[] = {
>>           .ctl_offs = SPM_MFG_PWR_CON,
>>           .sram_pdn_bits = GENMASK(13, 8),
>>           .sram_pdn_ack_bits = GENMASK(21, 16),
>> -        .bp_infracfg[0] = {
>> -            .bus_prot_reg_update = true,
>> -            .bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
>> -                MT8173_TOP_AXI_PROT_EN_MFG_M0 |
>> -                MT8173_TOP_AXI_PROT_EN_MFG_M1 |
>> -                MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
>> +        .bp_infracfg = {
>> +            BUS_PROT_UPDATE_MT8173(MT8173_TOP_AXI_PROT_EN_MFG_S |
>> +                           MT8173_TOP_AXI_PROT_EN_MFG_M0 |
>> +                           MT8173_TOP_AXI_PROT_EN_MFG_M1 |
>> +                           MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
>>           },
>>       },
>>   };
>> diff --git a/include/linux/soc/mediatek/infracfg.h
>> b/include/linux/soc/mediatek/infracfg.h
>> index f967d02cc2ff..3f18cddffb44 100644
>> --- a/include/linux/soc/mediatek/infracfg.h
>> +++ b/include/linux/soc/mediatek/infracfg.h
>> @@ -37,6 +37,12 @@
>>   #define INFRA_TOPAXI_PROTECTEN_SET    0x0260
>>   #define INFRA_TOPAXI_PROTECTEN_CLR    0x0264
>>   +#define BUS_PROT_UPDATE_MT8173(_mask)            \
> 
> While at it, could you update this to call it:
> BUS_PROT_UPDATE_TOPAXI as in all the other SoCs TOPAXI is mapped to the same
> address.
> 

Sure, done in next version.

> Thanks!
> Matthias
> 
>> +    BUS_PROT_UPDATE(_mask,                \
>> +            INFRA_TOPAXI_PROTECTEN,        \
>> +            INFRA_TOPAXI_PROTECTEN_CLR,    \
>> +            INFRA_TOPAXI_PROTECTSTA1)
>> +
>>   int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
>>           bool reg_update);
>>   int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
>>
