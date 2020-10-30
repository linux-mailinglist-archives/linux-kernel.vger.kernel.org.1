Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66702A0370
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgJ3K4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:56:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58580 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgJ3K4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:56:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4081F1F45E6C
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v3 06/16] soc: mediatek: pm-domains: Add SMI block as bus
 protection block
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
 <20201026175526.2915399-7-enric.balletbo@collabora.com>
 <CANMq1KCDNH1w+jo5kjyhusLdzCR0hF8QUi3a+jkkDvv75uGK5A@mail.gmail.com>
Message-ID: <adbcc9a6-d101-62e1-265c-146b38c3165a@collabora.com>
Date:   Fri, 30 Oct 2020 11:56:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CANMq1KCDNH1w+jo5kjyhusLdzCR0hF8QUi3a+jkkDvv75uGK5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thank you for your comments.

On 27/10/20 3:44, Nicolas Boichat wrote:
> On Tue, Oct 27, 2020 at 1:55 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> Apart from the infracfg block, the SMI block is used to enable the bus
>> protection for some power domains. Add support for this block.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v3:
>> - Do not reuse bpd for 2 different things.
>> - Disable pd->smi first and after that pd->infracfg.
>> - Rename BUT_PROT_UPDATE_MT8173 to BUS_PROT_UPDATE_TOPAXI as in all the
>>   other SoCs TOPAXI is mapped to the same address.
>>
> [snip]
>>  static int scpsys_power_on(struct generic_pm_domain *genpd)
>> @@ -266,6 +271,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>>         if (IS_ERR(pd->infracfg))
>>                 pd->infracfg = NULL;
>>
>> +       pd->smi = syscon_regmap_lookup_by_phandle(node, "mediatek,smi");
>> +       if (IS_ERR(pd->smi))
>> +               pd->smi = NULL;
> 
> This is the second time I see this pattern, I think.
> 
> Do we want to create a new syscon_regmap_lookup_by_phandle_optional wrapper?
> 

I think could be useful, yes. So I sent a patch to add this wrapper, let's see
what the MFD maintainers think.

> Also, are we ok with ignoring all errors? I agree we can ignore
> -ENODEV if optional, but I'm not sure about the others.
> 

Right, we shouldn't ignore the other errors.

>> +
>>         pd->num_clks = of_clk_get_parent_count(node);
>>         if (pd->num_clks > 0) {
>>                 pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
>> index e428fe23a7e3..7b1abcfc4ba3 100644
>> --- a/drivers/soc/mediatek/mtk-pm-domains.h
>> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
>> @@ -34,8 +34,31 @@
>>
>>  #define SPM_MAX_BUS_PROT_DATA          3
>>
>> +#define _BUS_PROT(_mask, _set, _clr, _sta, _update) {  \
>> +               .bus_prot_mask = (_mask),               \
>> +               .bus_prot_set = _set,                   \
>> +               .bus_prot_clr = _clr,                   \
>> +               .bus_prot_sta = _sta,                   \
>> +               .bus_prot_reg_update = _update,         \
>> +       }
>> +
>> +#define BUS_PROT_WR(_mask, _set, _clr, _sta)           \
>> +               _BUS_PROT(_mask, _set, _clr, _sta, false)
>> +
>> +#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)               \
>> +               _BUS_PROT(_mask, _set, _clr, _sta, true)
>> +
>> +#define BUS_PROT_UPDATE_TOPAXI(_mask)                          \
>> +               BUS_PROT_UPDATE(_mask,                          \
>> +                               INFRA_TOPAXI_PROTECTEN,         \
>> +                               INFRA_TOPAXI_PROTECTEN_CLR,     \
>> +                               INFRA_TOPAXI_PROTECTSTA1)
>> +
>>  struct scpsys_bus_prot_data {
>>         u32 bus_prot_mask;
>> +       u32 bus_prot_set;
>> +       u32 bus_prot_clr;
>> +       u32 bus_prot_sta;
>>         bool bus_prot_reg_update;
>>  };
>>
>> @@ -47,6 +70,7 @@ struct scpsys_bus_prot_data {
>>   * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>>   * @caps: The flag for active wake-up action.
>>   * @bp_infracfg: bus protection for infracfg subsystem
>> + * @bp_smi: bus protection for smi subsystem
>>   */
>>  struct scpsys_domain_data {
>>         u32 sta_mask;
>> @@ -55,6 +79,7 @@ struct scpsys_domain_data {
>>         u32 sram_pdn_ack_bits;
>>         u8 caps;
>>         const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
>> +       const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
>>  };
>>
>>  struct scpsys_soc_data {
>> --
>> 2.28.0
>>
