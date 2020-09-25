Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3593278299
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgIYIVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:21:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41130 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgIYIV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:21:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9FD0E29D0E8
Subject: Re: [PATCH 11/12] soc: mediatek: pm-domains: Add support for mt8183
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Nicolas Boichat <drinkcat@chromium.org>, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-12-enric.balletbo@collabora.com>
 <730273b4-914a-8a7a-1583-351e6f20df5b@gmail.com>
 <5e1510f4-b0c4-2cff-b3f8-b6715d228149@gmail.com>
 <CAJMQK-jFwToRxBdVgtHT3wJ970M0NYGu3kLtkGRBDKMMNOHkJw@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2a52c8e7-59db-9ed9-dd35-fc74738c152d@collabora.com>
Date:   Fri, 25 Sep 2020 10:21:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJMQK-jFwToRxBdVgtHT3wJ970M0NYGu3kLtkGRBDKMMNOHkJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi and Matthias,

Hsin-Yi, many thanks to provide the register names.

On 25/9/20 9:37, Hsin-Yi Wang wrote:
> On Wed, Sep 16, 2020 at 8:19 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>>
>>
>>
>> On 16/09/2020 11:46, Matthias Brugger wrote:
>>>
>>>
>>> On 10/09/2020 19:28, Enric Balletbo i Serra wrote:
>>>> From: Matthias Brugger <mbrugger@suse.com>
>>>>
>>>> Add the needed board data to support mt8183 SoC.
>>>>
>>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> ---
>>>>
>>>>   drivers/soc/mediatek/mtk-pm-domains.c | 162 ++++++++++++++++++++++++++
>>>>   include/linux/soc/mediatek/infracfg.h |  28 +++++
>>>>   2 files changed, 190 insertions(+)
>>>>
>>>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c
>>>> b/drivers/soc/mediatek/mtk-pm-domains.c
>>>> index 29e88adc8ea6..aa434f616fee 100644
>>>> --- a/drivers/soc/mediatek/mtk-pm-domains.c
>>>> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
>>> [...]
>>>> +/*
>>>> + * MT8183 power domain support
>>>> + */
>>>> +static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>>>> +    [MT8183_POWER_DOMAIN_AUDIO] = {
>>>> +        .sta_mask = PWR_STATUS_AUDIO,
>>>> +        .ctl_offs = 0x0314,
>>>> +        .sram_pdn_bits = GENMASK(11, 8),
>>>> +        .sram_pdn_ack_bits = GENMASK(15, 12),
>>>> +    },
>>>> +    [MT8183_POWER_DOMAIN_CONN] = {
>>>> +        .sta_mask = PWR_STATUS_CONN,
>>>> +        .ctl_offs = 0x032c,
>>>> +        .sram_pdn_bits = 0,
>>>> +        .sram_pdn_ack_bits = 0,
>>>> +        .bp_infracfg = {
>>>> +            BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_CONN, 0x2a0, 0x2a4, 0x228),
>>>
>>> We have repeating values triplets for set, clear and status register in infracfg
>>> and SMI.
>>>
>>> Weiyi can you help to get names to this registers? I wasn't able to find
>>> anything in the datasheet.
>>
>> I think for the infracfg part I figured it out:
>>
>> #define INFRA_TOPAXI_PROTECTEN_SET      0x2a0
>> #define INFRA_TOPAXI_PROTECTEN_CLR      0x2a4
>> #define INFRA_TOPAXI_PROTECTEN_STA1     0x228
>>
>> #define INFRA_TOPAXI_PROTECTEN_1_SET    0x2a8
>> #define INFRA_TOPAXI_PROTECTEN_1_CLR    0x2ac
>> #define INFRA_TOPAXI_PROTECTEN_STA1_1   0x258
>>
>> #define INFRA_TOPAXI_PROTECTEN_MCU_SET  0x2d4
>> #define INFRA_TOPAXI_PROTECTEN_MCU_CLR  0x2d8
>> #define INFRA_TOPAXI_PROTECTEN_MM_STA1  0x2ec
>>

I think this is SoC specific, right? So, I should add the MT8183_ prefix.

>> Weiyi, can you still provide the register names for the SMI?
>>
>> Thanks in advance!
>> Matthias
>>
> Hi Matthias,
> 
> SMI names are
> #define SMI_COMMON_CLAMP_EN 0x3c0
> #define SMI_COMMON_CLAMP_EN_SET 0x3c4
> #define SMI_COMMON_CLAMP_EN_CLR 0x3c8
> 

The same here, this is specific for MT8183, right?

Thanks,
  Enric

> Thanks
> 
