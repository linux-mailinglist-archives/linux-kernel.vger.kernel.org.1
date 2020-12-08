Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C092D29CE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 12:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgLHLan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 06:30:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9035 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgLHLam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:30:42 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cqyd41XvCzhnJb;
        Tue,  8 Dec 2020 19:29:28 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 8 Dec 2020
 19:29:48 +0800
Subject: Re: [PATCH v2 1/3] reset: hisilicon: correct vendor prefix
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20201204014236.1158-1-thunder.leizhen@huawei.com>
 <20201204014236.1158-2-thunder.leizhen@huawei.com>
 <07c0b7a0caf47ddef27e55e6d6887fa55305d9d5.camel@pengutronix.de>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <abdb7179-5187-b515-7a9d-5a4d13608e40@huawei.com>
Date:   Tue, 8 Dec 2020 19:29:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <07c0b7a0caf47ddef27e55e6d6887fa55305d9d5.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/12/8 17:25, Philipp Zabel wrote:
> Hi Zhen,
> 
> On Fri, 2020-12-04 at 09:42 +0800, Zhen Lei wrote:
>> The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
>> stated in "vendor-prefixes.yaml".
>>
>> Fixes: 1527058736fa ("reset: hisilicon: add reset-hi3660")
>> Fixes: 35ca8168133c ("arm64: dts: Add dts files for Hisilicon Hi3660 SoC")
>> Fixes: dd8c7b78c11b ("arm64: dts: Add devicetree for Hisilicon Hi3670 SoC")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Cc: Chen Feng <puck.chen@hisilicon.com>
>> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
>>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 2 +-
>>  drivers/reset/hisilicon/reset-hi3660.c    | 2 +-
> 
> Please keep device tree patches and reset driver patch separate, as they
> were in v1.

OK

> 
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> index 49c19c6879f95ce..bfb1375426d2b58 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> @@ -345,7 +345,7 @@
>>  		crg_rst: crg_rst_controller {
>>  			compatible = "hisilicon,hi3660-reset";
>>  			#reset-cells = <2>;
>> -			hisi,rst-syscon = <&crg_ctrl>;
>> +			hisilicon,rst-syscon = <&crg_ctrl>;
>>  		};
>>  
>>  
>> @@ -376,7 +376,7 @@
>>  
>>  		iomcu_rst: reset {
>>  			compatible = "hisilicon,hi3660-reset";
>> -			hisi,rst-syscon = <&iomcu>;
>> +			hisilicon,rst-syscon = <&iomcu>;
>>  			#reset-cells = <2>;
>>  		};
>>  
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
>> index 85b0dfb35d6d396..5c5a5dc964ea848 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
>> @@ -155,7 +155,7 @@
>>  			compatible = "hisilicon,hi3670-reset",
>>  				     "hisilicon,hi3660-reset";
>>  			#reset-cells = <2>;
>> -			hisi,rst-syscon = <&crg_ctrl>;
>> +			hisilicon,rst-syscon = <&crg_ctrl>;
>>  		};
>>  
>>  		pctrl: pctrl@e8a09000 {
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
> This should fall back to the deprecated compatible, for example:
> 
> 	rc->map = syscon_regmap_lookup_by_phandle(np, "hisilicon,rst-syscon");
> 	if (PTR_ERR(rc->map) == -ENODEV)
> 		rc->map = syscon_regmap_lookup_by_phandle(np, "hisi,rst-
> syscon");

Oh, thanks. I misunderstood your suggestion the other day. I'll fix it right away.

> 
>>  	if (IS_ERR(rc->map)) {
>>  		dev_err(dev, "failed to get hi3660,rst-syscon\n");
>>  		return PTR_ERR(rc->map);
> 
> regards
> Philipp
> 
> .
> 

