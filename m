Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3AB2F583D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbhANCQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:16:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38516 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbhAMVQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:16:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0176C1F44F75
Subject: Re: [PATCH 2/3] soc: mediatek: pm-domains: Add domain regulator
 supply
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20210107104915.2888408-1-hsinyi@chromium.org>
 <20210107104915.2888408-3-hsinyi@chromium.org>
 <CANMq1KAWCbtpJWMG2nE6k1hOzA=hCWYJxzC7RXb_voEri0v2=g@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <a6cea5be-f7ee-a09c-8300-69792cfa02bb@collabora.com>
Date:   Wed, 13 Jan 2021 22:16:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CANMq1KAWCbtpJWMG2nE6k1hOzA=hCWYJxzC7RXb_voEri0v2=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for the patch.

On 10/1/21 2:49, Nicolas Boichat wrote:
> On Thu, Jan 7, 2021 at 6:49 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>
>> Some power domains (eg. mfg) needs to turn on power supply before power
>> on.
>>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> 
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> 

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


>> ---
>>  drivers/soc/mediatek/mt8183-pm-domains.h |  1 +
>>  drivers/soc/mediatek/mtk-pm-domains.c    | 36 +++++++++++++++++++++++-
>>  drivers/soc/mediatek/mtk-pm-domains.h    |  1 +
>>  3 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/soc/mediatek/mt8183-pm-domains.h
>> index 8d996c5d2682d..aa5230e6c12f8 100644
>> --- a/drivers/soc/mediatek/mt8183-pm-domains.h
>> +++ b/drivers/soc/mediatek/mt8183-pm-domains.h
>> @@ -38,6 +38,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>>                 .ctl_offs = 0x0338,
>>                 .sram_pdn_bits = GENMASK(8, 8),
>>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>> +               .caps = MTK_SCPD_DOMAIN_SUPPLY,
>>         },
>>         [MT8183_POWER_DOMAIN_MFG_CORE0] = {
>>                 .sta_mask = BIT(7),
>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
>> index fb70cb3b07b36..ae255aa7b1a97 100644
>> --- a/drivers/soc/mediatek/mtk-pm-domains.c
>> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> [snip]
>> @@ -275,6 +295,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>>  {
>>         const struct scpsys_domain_data *domain_data;
>>         struct scpsys_domain *pd;
>> +       struct device_node *np = scpsys->dev->of_node;
>>         struct property *prop;
>>         const char *clk_name;
>>         int i, ret, num_clks;
>> @@ -307,6 +328,19 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>>         pd->data = domain_data;
>>         pd->scpsys = scpsys;
>>
>> +       if (MTK_SCPD_CAPS(pd, MTK_SCPD_DOMAIN_SUPPLY)) {
>> +               /* Find regulator in current power domain node */
>> +               scpsys->dev->of_node = node;
>> +               pd->supply = devm_regulator_get(scpsys->dev, "domain");
>> +               scpsys->dev->of_node = np;
> 
> This pattern is a bit strange to me. But Hsin-Yi pointed out that
> there are precedents:
> https://elixir.bootlin.com/linux/v5.11-rc2/source/drivers/iio/adc/rcar-gyroadc.c#L397
> .

nit: Strange to me too. Maybe it needs a better comment/explanation and/or use
child/parent as a temporal of_node names to make a bit more readable. Looks like
[devm_]regulator_get only accepts a device as argument and will look into child
nodes.


> 
>> +               if (IS_ERR(pd->supply)) {
>> +                       dev_err_probe(scpsys->dev, PTR_ERR(pd->supply),
>> +                                     "%pOF: failed to get power supply.\n",
>> +                                     node);
>> +                       return ERR_CAST(pd->supply);
>> +               }
>> +       }
>> +
>>         pd->infracfg = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg");
>>         if (IS_ERR(pd->infracfg))
>>                 return ERR_CAST(pd->infracfg);
>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
>> index a2f4d8f97e058..b2770b5266dba 100644
>> --- a/drivers/soc/mediatek/mtk-pm-domains.h
>> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
>> @@ -7,6 +7,7 @@
>>  #define MTK_SCPD_FWAIT_SRAM            BIT(1)
>>  #define MTK_SCPD_SRAM_ISO              BIT(2)
>>  #define MTK_SCPD_KEEP_DEFAULT_OFF      BIT(3)
>> +#define MTK_SCPD_DOMAIN_SUPPLY         BIT(4)
>>  #define MTK_SCPD_CAPS(_scpd, _x)       ((_scpd)->data->caps & (_x))
>>
>>  #define SPM_VDE_PWR_CON                        0x0210
>> --
>> 2.29.2.729.g45daf8777d-goog
>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
