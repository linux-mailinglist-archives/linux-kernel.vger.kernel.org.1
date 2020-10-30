Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E116E2A03EB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgJ3LRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgJ3LRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:17:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFDCC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:17:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 473B91F45EAF
Subject: Re: [PATCH v3 15/16] soc: mediatek: pm-domains: Add default power off
 flag
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        hsinyi@chromium.org, Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
 <20201026175526.2915399-16-enric.balletbo@collabora.com>
 <05be2a94-d6e6-36e5-2c14-6d971e4a7677@gmail.com>
 <1603797517.25228.3.camel@mtksdaap41>
 <83197162-6bfc-b861-653e-4fd21035b5ae@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <51cfbada-0ced-56d1-2836-8446fa8957b9@collabora.com>
Date:   Fri, 30 Oct 2020 12:17:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <83197162-6bfc-b861-653e-4fd21035b5ae@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weilyi and Matthias,

On 29/10/20 15:51, Matthias Brugger wrote:
> 
> 
> On 27/10/2020 12:18, Weiyi Lu wrote:
>> On Tue, 2020-10-27 at 11:53 +0100, Matthias Brugger wrote:
>>>
>>> On 26/10/2020 18:55, Enric Balletbo i Serra wrote:
>>>> From: Weiyi Lu <weiyi.lu@mediatek.com>
>>>>
>>>> For some power domain, like conn on MT8192, it should be default OFF.
>>>> Because the power on/off control relies the function of connectivity chip
>>>> and its firmware. And if project choose other chip vendor solution,
>>>> those necessary connectivity functions will not provided.
>>>>
>>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> ---
>>>>
>>>> Changes in v3: None
>>>> Changes in v2: None
>>>>
>>>>    drivers/soc/mediatek/mtk-pm-domains.c | 23 +++++++++++++++++------
>>>>    drivers/soc/mediatek/mtk-pm-domains.h |  1 +
>>>>    2 files changed, 18 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c
>>>> b/drivers/soc/mediatek/mtk-pm-domains.c
>>>> index 63993076a544..fe0e955076a0 100644
>>>> --- a/drivers/soc/mediatek/mtk-pm-domains.c
>>>> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
>>>> @@ -378,10 +378,16 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys
>>>> *scpsys, struct device_no
>>>>         * software.  The unused domains will be switched off during
>>>>         * late_init time.
>>>>         */
>>>> -    ret = scpsys_power_on(&pd->genpd);
>>>> -    if (ret < 0) {
>>>> -        dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node,
>>>> ret);
>>>> -        goto err_unprepare_clocks;
>>>> +    if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF)) {
>>>> +        if (scpsys_domain_is_on(pd))
>>>> +            dev_warn(scpsys->dev,
>>>> +                 "%pOF: A default off power domain has been ON\n", node);
>>>> +    } else {
>>>> +        ret = scpsys_power_on(&pd->genpd);
>>>> +        if (ret < 0) {
>>>> +            dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n",
>>>> node, ret);
>>>> +            goto err_unprepare_clocks;
>>>> +        }
>>>>        }
>>>>           if (scpsys->domains[id]) {
>>>> @@ -395,7 +401,11 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys
>>>> *scpsys, struct device_no
>>>>        pd->genpd.power_off = scpsys_power_off;
>>>>        pd->genpd.power_on = scpsys_power_on;
>>>>    -    pm_genpd_init(&pd->genpd, NULL, false);
>>>> +    if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
>>>> +        pm_genpd_init(&pd->genpd, NULL, true);
>>>> +    else
>>>> +        pm_genpd_init(&pd->genpd, NULL, false);
>>>> +
>>>>        scpsys->domains[id] = &pd->genpd;
>>>>           return scpsys->pd_data.domains[id];
>>>> @@ -478,7 +488,8 @@ static void scpsys_remove_one_domain(struct
>>>> scpsys_domain *pd)
>>>>                "failed to remove domain '%s' : %d - state may be
>>>> inconsistent\n",
>>>>                pd->genpd.name, ret);
>>>>    -    scpsys_power_off(&pd->genpd);
>>>> +    if (!MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
>>>> +        scpsys_power_off(&pd->genpd);
>>>
>>> OK, so you merged Weiyi's patches in this series :)
>>>
>>> So same comment here: Does it really hurt if we turn-off a already turned-off
>>> power domain? Or can we get rid of this check?
>>>
>>
>> We do need this check here. If you try to turn-off this power domain,
>> you might make the clock or regulator reference count unbalanced.
>>
> 
> Correct. Could we check via scpsys_domain_is_on() instead? I'd like to avoid
> MTK_SCPD_KEEP_DEFAULT_OFF use here.
> 

So, I'm using scpsys_domain_is_on() now for this check and moved before
pm_genpd_remove call. I'll let you both to decide if is fine or not.

> Regards,
> Matthias
> 
>>> Regards,
>>> Matthias
>>>
>>>>           clk_bulk_unprepare(pd->num_clks, pd->clks);
>>>>        clk_bulk_put(pd->num_clks, pd->clks);
>>>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h
>>>> b/drivers/soc/mediatek/mtk-pm-domains.h
>>>> index 2ad213be84a5..0fa6a938b40c 100644
>>>> --- a/drivers/soc/mediatek/mtk-pm-domains.h
>>>> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
>>>> @@ -6,6 +6,7 @@
>>>>    #define MTK_SCPD_ACTIVE_WAKEUP        BIT(0)
>>>>    #define MTK_SCPD_FWAIT_SRAM        BIT(1)
>>>>    #define MTK_SCPD_SRAM_ISO        BIT(2)
>>>> +#define MTK_SCPD_KEEP_DEFAULT_OFF    BIT(3)
>>>>    #define MTK_SCPD_CAPS(_scpd, _x)    ((_scpd)->data->caps & (_x))
>>>>       #define SPM_VDE_PWR_CON            0x0210
>>>>
>>
