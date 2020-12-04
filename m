Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D96B2CE521
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgLDB2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:28:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9006 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgLDB2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:28:52 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CnFSZ5vXMzhkTw;
        Fri,  4 Dec 2020 09:27:42 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Dec 2020
 09:28:04 +0800
Subject: Re: [PATCH 1/4] reset: hisilicon: correct vendor prefix
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20201203120212.1105-1-thunder.leizhen@huawei.com>
 <20201203120212.1105-2-thunder.leizhen@huawei.com>
 <9277bc82766d26d840dbd0a7b4041cd267862a39.camel@pengutronix.de>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <15efa527-0dc3-10a5-9ace-79ccc76a0689@huawei.com>
Date:   Fri, 4 Dec 2020 09:28:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9277bc82766d26d840dbd0a7b4041cd267862a39.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/12/3 20:54, Philipp Zabel wrote:
> On Thu, 2020-12-03 at 20:02 +0800, Zhen Lei wrote:
>> The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
>> stated in "vendor-prefixes.yaml".
>>
>> Fixes: 1527058736fa ("reset: hisilicon: add reset-hi3660")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>  drivers/reset/hisilicon/reset-hi3660.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
>> index a7d4445924e558c..8f1953159a65b31 100644
>> --- a/drivers/reset/hisilicon/reset-hi3660.c
>> +++ b/drivers/reset/hisilicon/reset-hi3660.c
>> @@ -83,7 +83,7 @@ static int hi3660_reset_probe(struct platform_device *pdev)
>>  	if (!rc)
>>  		return -ENOMEM;
>>  
>> -	rc->map = syscon_regmap_lookup_by_phandle(np, "hisi,rst-syscon");
>> +	rc->map = syscon_regmap_lookup_by_phandle(np, "hisilicon,rst-syscon");
> 
> What about those that don't upgrade kernel and DT in lock-step?
> It would be easy to fall back to the old compatible if the new one
> fails.

All right, I'll combine them. I thought they belonged to different maintainers,
and I had to break them apart.

> 
> regards
> Philipp
> 
> .
> 

