Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0472833FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJEK2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:28:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:58894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgJEK2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:28:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601893693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/JqGd6PalEdATCzl9yAiTh7H5Y1eBidoPeAq7PeqNM=;
        b=Rr9JK0FaMCuS2y4bd4R/YOEGd+voVVRfYx8iRODdcq+ryBjTzQM3+LpUdtSB+dxUCCpV93
        0H0im4IMg/ZYoh3tqRpLSwXgLaGaDDKEVY6Xgg/aqP1H7vkH2WE4922ouoL3NZt3OgfFEP
        ZJzveXys+olPX8oJo9V7ODLWDh21jJw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 997A0AEEF;
        Mon,  5 Oct 2020 10:28:13 +0000 (UTC)
Subject: Re: [PATCH v2 06/12] soc: mediatek: pm-domains: Add SMI block as bus
 protection block
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
 <20201001160154.3587848-7-enric.balletbo@collabora.com>
 <ee2b40c3-b565-22ed-34f4-4259d546a623@gmail.com>
 <CANMq1KDNKsE5oWxsg-zPS1L07dZySjoQc-fRWsXc5ngdi98Kgg@mail.gmail.com>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <8b007805-5fd5-aebe-2ac3-014514173263@suse.com>
Date:   Mon, 5 Oct 2020 12:28:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CANMq1KDNKsE5oWxsg-zPS1L07dZySjoQc-fRWsXc5ngdi98Kgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2020 03:48, Nicolas Boichat wrote:
> On Fri, Oct 2, 2020 at 4:56 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>>
>>
>>
>> On 01/10/2020 18:01, Enric Balletbo i Serra wrote:
>>> From: Matthias Brugger <mbrugger@suse.com>
>>>
>>> Apart from the infracfg block, the SMI block is used to enable the bus
>>> protection for some power domains. Add support for this block.
>>>
>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>
>>> Changes in v2: None
>>>
>>>    drivers/soc/mediatek/mtk-pm-domains.c | 64 ++++++++++++++++++++-------
>>>    include/linux/soc/mediatek/infracfg.h |  6 +++
>>>    2 files changed, 53 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
>>> index b5e7c9846c34..38f2630bdd0a 100644
>>> --- a/drivers/soc/mediatek/mtk-pm-domains.c
>>> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
>>> @@ -56,8 +56,25 @@
>>>
>>>    #define SPM_MAX_BUS_PROT_DATA               3
>>>
>>> +#define _BUS_PROT(_mask, _set, _clr, _sta, _update) {        \
>>> +             .bus_prot_mask = (_mask),               \
>>> +             .bus_prot_set = _set,                   \
>>> +             .bus_prot_clr = _clr,                   \
>>> +             .bus_prot_sta = _sta,                   \
>>> +             .bus_prot_reg_update = _update,         \
>>> +     }
>>> +
>>> +#define BUS_PROT_WR(_mask, _set, _clr, _sta)         \
>>> +             _BUS_PROT(_mask, _set, _clr, _sta, false)
>>> +
>>> +#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)             \
>>> +             _BUS_PROT(_mask, _set, _clr, _sta, true)
>>> +
>>>    struct scpsys_bus_prot_data {
>>>        u32 bus_prot_mask;
>>> +     u32 bus_prot_set;
>>> +     u32 bus_prot_clr;
>>> +     u32 bus_prot_sta;
>>>        bool bus_prot_reg_update;
>>>    };
>>>
>>> @@ -69,6 +86,7 @@ struct scpsys_bus_prot_data {
>>>     * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>>>     * @caps: The flag for active wake-up action.
>>>     * @bp_infracfg: bus protection for infracfg subsystem
>>> + * @bp_smi: bus protection for smi subsystem
>>>     */
>>>    struct scpsys_domain_data {
>>>        u32 sta_mask;
>>> @@ -77,6 +95,7 @@ struct scpsys_domain_data {
>>>        u32 sram_pdn_ack_bits;
>>>        u8 caps;
>>>        const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
>>> +     const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
>>>    };
>>>
>>>    struct scpsys_domain {
>>> @@ -86,6 +105,7 @@ struct scpsys_domain {
>>>        int num_clks;
>>>        struct clk_bulk_data *clks;
>>>        struct regmap *infracfg;
>>> +     struct regmap *smi;
>>>    };
>>>
>>>    struct scpsys_soc_data {
>>> @@ -175,9 +195,9 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
>>>                if (bpd[i].bus_prot_reg_update)
>>>                        regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, mask);
>>>                else
>>> -                     regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_SET, mask);
>>> +                     regmap_write(regmap, bpd[i].bus_prot_set, mask);
>>>
>>> -             ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
>>> +             ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
>>>                                               val, (val & mask) == mask,
>>>                                               MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>>                if (ret)
>>> @@ -193,7 +213,11 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>>>        int ret;
>>>
>>>        ret = _scpsys_bus_protect_enable(bpd, pd->infracfg);
>>> -     return ret;
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     bpd = pd->data->bp_smi;
>>> +     return _scpsys_bus_protect_enable(bpd, pd->smi);
> 
> Not a huge fan or reusing bpd for 2 different things.
> 
> I think this is easier to follow:
> 
> _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
> ...
> _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
> 

Sounds reasonable, yes :)
