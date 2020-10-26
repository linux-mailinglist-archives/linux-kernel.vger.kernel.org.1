Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5972990D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783566AbgJZPQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:16:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60404 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783559AbgJZPQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:16:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 27E241F44A65
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 07/12] soc: mediatek: pm-domains: Add extra sram control
To:     Matthias Brugger <mbrugger@suse.com>, linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-8-enric.balletbo@collabora.com>
 <277b1656-4a64-4fdd-865d-88cf253b7b0e@suse.com>
Message-ID: <59d2decc-029a-709b-7796-fc9f370b67c6@collabora.com>
Date:   Mon, 26 Oct 2020 16:16:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <277b1656-4a64-4fdd-865d-88cf253b7b0e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 10/9/20 20:27, Matthias Brugger wrote:
> 
> 
> On 10/09/2020 19:28, Enric Balletbo i Serra wrote:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> For some power domains like vpu_core on MT8183 whose sram need to do clock
>> and internal isolation while power on/off sram. We add a cap
>> "MTK_SCPD_SRAM_ISO" to judge if we need to do the extra sram isolation
>> control or not.
>>
>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>   drivers/soc/mediatek/mtk-pm-domains.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c
>> b/drivers/soc/mediatek/mtk-pm-domains.c
>> index 3aa430a60602..0802eccc3a0b 100644
>> --- a/drivers/soc/mediatek/mtk-pm-domains.c
>> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
>> @@ -21,6 +21,7 @@
>>     #define MTK_SCPD_ACTIVE_WAKEUP        BIT(0)
>>   #define MTK_SCPD_FWAIT_SRAM        BIT(1)
>> +#define MTK_SCPD_SRAM_ISO        BIT(2)
>>   #define MTK_SCPD_CAPS(_scpd, _x)    ((_scpd)->data->caps & (_x))
>>     #define SPM_VDE_PWR_CON            0x0210
>> @@ -42,6 +43,8 @@
>>   #define PWR_ON_BIT            BIT(2)
>>   #define PWR_ON_2ND_BIT            BIT(3)
>>   #define PWR_CLK_DIS_BIT            BIT(4)
>> +#define PWR_SRAM_CLKISO_BIT        BIT(5)
>> +#define PWR_SRAM_ISOINT_B_BIT        BIT(6)
>>     #define PWR_STATUS_DISP            BIT(3)
>>   #define PWR_STATUS_MFG            BIT(4)
>> @@ -162,6 +165,14 @@ static int scpsys_sram_enable(struct scpsys_domain *pd,
>> void __iomem *ctl_addr)
>>       if (ret < 0)
>>           return ret;
>>   +    if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_ISO))    {
>> +        val = readl(ctl_addr) | PWR_SRAM_ISOINT_B_BIT;
>> +        writel(val, ctl_addr);
>> +        udelay(1);
>> +        val &= ~PWR_SRAM_CLKISO_BIT;
>> +        writel(val, ctl_addr);
>> +    }
>> +
>>       return 0;
>>   }
>>   @@ -171,8 +182,15 @@ static int scpsys_sram_disable(struct scpsys_domain
>> *pd, void __iomem *ctl_addr)
>>       u32 val;
>>       int tmp;
>>   -    val = readl(ctl_addr);
>> -    val |= pd->data->sram_pdn_bits;
>> +    if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_ISO))    {
>> +        val = readl(ctl_addr) | PWR_SRAM_CLKISO_BIT;
>> +        writel(val, ctl_addr);
>> +        val &= ~PWR_SRAM_ISOINT_B_BIT;
>> +        writel(val, ctl_addr);
>> +        udelay(1);
>> +    }
>> +
>> +    val = readl(ctl_addr) | pd->data->sram_pdn_bits;
> 
> Nit, I'd prefer:
> val = readl(ctl_addr);
> val |= pd->data->sram_pdn_bits;
> 

done in next version.

> 
>>       writel(val, ctl_addr);
>>         /* Either wait until SRAM_PDN_ACK all 1 or 0 */
>>
