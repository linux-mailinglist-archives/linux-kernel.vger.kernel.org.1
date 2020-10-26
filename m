Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677FC2990D6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783601AbgJZPRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:17:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60442 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783154AbgJZPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:17:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 513961F44A65
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2 08/12] soc: mediatek: pm-domains: Add subsystem clocks
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
 <20201001160154.3587848-9-enric.balletbo@collabora.com>
 <d6d132ba-1ce1-f537-57ba-4b6bed784b48@gmail.com>
Message-ID: <e9809057-20b6-b72e-0320-1131fc37fae8@collabora.com>
Date:   Mon, 26 Oct 2020 16:17:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d6d132ba-1ce1-f537-57ba-4b6bed784b48@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thank you for your review.

On 2/10/20 11:04, Matthias Brugger wrote:
> 
> 
> On 01/10/2020 18:01, Enric Balletbo i Serra wrote:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> For the bus protection operations, some subsystem clocks need to be enabled
>> before releasing the protection. This patch identifies the subsystem clocks
>> by it's name.
>>
>> Suggested-by: Weiyi Lu <weiyi.lu@mediatek.com>
>> [Adapted the patch to the mtk-pm-domains driver]
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v2:
>> - Use dev_err_probe if getting clocks fails, so an error is not printed
>>    if is deferred.
>>
>>   drivers/soc/mediatek/mtk-pm-domains.c | 89 ++++++++++++++++++++++-----
>>   1 file changed, 75 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c
>> b/drivers/soc/mediatek/mtk-pm-domains.c
>> index e0a52d489fea..2075072f16da 100644
>> --- a/drivers/soc/mediatek/mtk-pm-domains.c
>> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> [...]
>>   +    for (i = 0; i < pd->num_subsys_clks; i++) {
>> +        struct clk *clk = of_clk_get(node, i + clk_ind);
>> +
>> +        if (IS_ERR(clk)) {
>> +            ret = PTR_ERR(clk);
>> +            dev_err_probe(scpsys->dev, PTR_ERR(clk),
>> +                      "%pOFn: failed to get clk at index %d: %d\n",
>> +                      node, i + clk_ind, ret);
>> +            goto err_put_subsys_clocks;
>> +        }
>> +
>> +        pd->subsys_clks[i].clk = clk;
>> +    }
>> +
>> +    ret = clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
>> +    if (ret)
>> +        goto err_put_subsys_clocks;
>> +
> 
> Not sure if it really matters, but logically we should prepare the basic clocks
> before we prepare the subsystem clocks. And fix the error handling accordingly.
> 

Changed in next version.

> Regards,
> Matthias
> 
>>       ret = clk_bulk_prepare(pd->num_clks, pd->clks);
>>       if (ret)
>> -        goto err_put_clocks;
>> +        goto err_unprepare_subsys_clocks;
>>         /*
>>        * Initially turn on all domains to make the domains usable
>> @@ -462,6 +513,12 @@ static int scpsys_add_one_domain(struct scpsys *scpsys,
>> struct device_node *node
>>     err_unprepare_clocks:
>>       clk_bulk_unprepare(pd->num_clks, pd->clks);
>> +err_unprepare_subsys_clocks:
>> +    clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>> +err_put_subsys_clocks:
>> +    clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
>> +    devm_kfree(scpsys->dev, pd->subsys_clks);
>> +    pd->num_subsys_clks = 0;
>>   err_put_clocks:
>>       clk_bulk_put(pd->num_clks, pd->clks);
>>       devm_kfree(scpsys->dev, pd->clks);
>> @@ -541,6 +598,10 @@ static void scpsys_remove_one_domain(struct scpsys_domain
>> *pd)
>>       clk_bulk_unprepare(pd->num_clks, pd->clks);
>>       clk_bulk_put(pd->num_clks, pd->clks);
>>       pd->num_clks = 0;
>> +
>> +    clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>> +    clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
>> +    pd->num_subsys_clks = 0;
>>   }
>>     static void scpsys_domain_cleanup(struct scpsys *scpsys)
>>
