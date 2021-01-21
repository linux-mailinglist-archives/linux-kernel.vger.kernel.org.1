Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22582FF24E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389033AbhAURq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:46:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2393 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733263AbhAURpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:45:45 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DM8ld71H0z67RJF;
        Fri, 22 Jan 2021 01:39:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 18:44:59 +0100
Received: from [10.210.167.120] (10.210.167.120) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 17:44:58 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 1/3] perf vendor events: Add cache refill and DCZVA
 events
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
CC:     <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <leo.yan@linaro.org>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
 <20210121105425.2695843-2-nakamura.shun@jp.fujitsu.com>
 <b00bf252-e31f-b0eb-d0aa-0a62bcaee22e@hisilicon.com>
Message-ID: <0be33a5d-98a1-d2e1-704e-83334063888d@huawei.com>
Date:   Thu, 21 Jan 2021 17:43:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <b00bf252-e31f-b0eb-d0aa-0a62bcaee22e@hisilicon.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.167.120]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2021 11:39, Shaokun Zhang wrote:
> Hi,
> 
> ÔÚ 2021/1/21 18:54, Shunsuke Nakamura Ð´µÀ:
>> Adds L1 data cache refill prefetch, L2 data cache refill prefetch,
>> and DCZVA instruction events.
> 
> A silly question, Does Arm define these events? I checked Arm ARM
> document(DDI0487Fc) that these event numbers are reserved. Or maybe
> I miss something.

For events which are reserved (see k3-1), like 0x9f, prob should not be 
putting in this file, but rather the CPU JSON.

Cheers,
John

> 
>>
>> Signed-off-by: Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
>> ---
>>   .../perf/pmu-events/arch/arm64/armv8-recommended.json  | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json b/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
>> index d0a1986..ee0e67d 100644
>> --- a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
>> +++ b/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
>> @@ -54,6 +54,12 @@
>>           "BriefDescription": "L1D cache invalidate"
>>       },
>>       {
>> +        "PublicDescription": "This event counts L1D_CACHE_REFILL caused by software or hardware prefetch.",
>> +        "EventCode": "0x49",
>> +        "EventName": "L1D_CACHE_REFILL_PRF",
>> +        "BriefDescription": "This event counts L1D_CACHE_REFILL caused by software or hardware prefetch."
>> +    },
>> +    {
>>           "PublicDescription": "Attributable Level 1 data TLB refill, read",
>>           "EventCode": "0x4C",
>>           "EventName": "L1D_TLB_REFILL_RD",
>> @@ -120,6 +126,12 @@
>>           "BriefDescription": "L2D cache invalidate"
>>       },
>>       {
>> +        "PublicDescription": "This event counts L2D_CACHE_REFILL caused by software or hardware prefetch.",
>> +        "EventCode": "0x59",
>> +        "EventName": "L2D_CACHE_REFILL_PRF",
>> +        "BriefDescription": "This event counts L2D_CACHE_REFILL caused by software or hardware prefetch."
>> +    },
>> +    {
>>           "PublicDescription": "Attributable Level 2 data or unified TLB refill, read",
>>           "EventCode": "0x5c",
>>           "EventName": "L2D_TLB_REFILL_RD",
>> @@ -408,6 +420,12 @@
>>           "BriefDescription": "Release consistency operation speculatively executed, Store-Release"
>>      },
>>      {
>> +         "PublicDescription": "This event counts architecturally executed zero blocking operations due to the 'DC ZVA' instruction.",
>> +         "EventCode": "0x9f",
>> +         "EventName": "DCZVA_SPEC",
>> +         "BriefDescription": "This event counts architecturally executed zero blocking operations due to the 'DC ZVA' instruction."
>> +   },
>> +   {
>>           "PublicDescription": "Attributable Level 3 data or unified cache access, read",
>>           "EventCode": "0xa0",
>>           "EventName": "L3D_CACHE_RD",
>>
> .
> 

