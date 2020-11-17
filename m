Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6172B5E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgKQLMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:12:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7635 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgKQLMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:12:12 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cb3DT4FWBz15LjT;
        Tue, 17 Nov 2020 19:11:53 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Nov 2020 19:11:29 +0800
Subject: Re: [PATCH] iommu: fix return error code in iommu_probe_device()
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20201117025238.3425422-1-yangyingliang@huawei.com>
 <835ab066-b6b8-a211-4941-c01781031de8@linux.intel.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <454f5e3e-c380-e8a5-9283-3f7578eb601e@huawei.com>
Date:   Tue, 17 Nov 2020 19:11:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <835ab066-b6b8-a211-4941-c01781031de8@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/17 17:40, Lu Baolu wrote:
> Hi Yingliang,
>
> On 2020/11/17 10:52, Yang Yingliang wrote:
>> If iommu_group_get() failed, it need return error code
>> in iommu_probe_device().
>>
>> Fixes: cf193888bfbd ("iommu: Move new probe_device path...")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/iommu/iommu.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index b53446bb8c6b..6f4a32df90f6 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -253,8 +253,10 @@ int iommu_probe_device(struct device *dev)
>>           goto err_out;
>>         group = iommu_group_get(dev);
>> -    if (!group)
>> +    if (!group) {
>> +        ret = -ENODEV;
>
> Can you please explain why you use -ENODEV here?

Before 79659190ee97 ("iommu: Don't take group reference in 
iommu_alloc_default_domain()"), in

iommu_alloc_default_domain(), if group is NULL, it will return -ENODEV.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/iommu.c?h=v5.10-rc4&id=70b8170e55d3ca9503a53211967faee6b5f18b19

>
> Best regards,
> baolu
>
>>           goto err_release;
>> +    }
>>         /*
>>        * Try to allocate a default domain - needs support from the
>>
> .
