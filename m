Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58B3273888
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 04:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgIVCc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 22:32:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37054 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729445AbgIVCc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 22:32:29 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 095C3B7D920535714ADE;
        Tue, 22 Sep 2020 10:32:26 +0800 (CST)
Received: from [10.174.179.91] (10.174.179.91) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 10:32:22 +0800
Subject: Re: [PATCH -next] drm: omapdrm: dss: simplify the return expression
 of hdmi_init_pll_data
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20200921131015.91422-1-miaoqinglang@huawei.com>
 <1f22b1c4-d92e-2dc8-7052-f6df23a187a6@ti.com>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <75a43778-c374-89e3-3f5a-8eea028472e9@huawei.com>
Date:   Tue, 22 Sep 2020 10:32:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1f22b1c4-d92e-2dc8-7052-f6df23a187a6@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/9/21 21:39, Tomi Valkeinen 写道:
> Hi,
> 
> On 21/09/2020 16:10, Qinglang Miao wrote:
>> Simplify the return expression.
>>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>   drivers/gpu/drm/omapdrm/dss/hdmi_pll.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
>> index cf2b000f3..c3e85b636 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
>> @@ -131,7 +131,6 @@ static int hdmi_init_pll_data(struct dss_device *dss,
>>   {
>>   	struct dss_pll *pll = &hpll->pll;
>>   	struct clk *clk;
>> -	int r;
>>   
>>   	clk = devm_clk_get(&pdev->dev, "sys_clk");
>>   	if (IS_ERR(clk)) {
>> @@ -151,11 +150,7 @@ static int hdmi_init_pll_data(struct dss_device *dss,
>>   
>>   	pll->ops = &hdmi_pll_ops;
>>   
>> -	r = dss_pll_register(dss, pll);
>> -	if (r)
>> -		return r;
>> -
>> -	return 0;
>> +	return dss_pll_register(dss, pll);
>>   }
>>   
>>   int hdmi_pll_init(struct dss_device *dss, struct platform_device *pdev,
>>
> 
> I like it more when there's a return 0 at the end of the function, especially in functions where
> there are multiple cases of if(...) return r. It's more easily readable, at least to my eyes.
> 
>   Tomi

Hi Tomi,

Glad to know your opnion and it sounds fine to me.

Thanks

> 
