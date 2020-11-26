Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB702C4D76
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 03:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbgKZCaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 21:30:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8591 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbgKZCaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 21:30:10 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ChMCg3QWMzLqTs;
        Thu, 26 Nov 2020 10:29:35 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 10:29:58 +0800
Subject: Re: [PATCH] iommu: fix return error code in iommu_probe_device()
To:     Will Deacon <will@kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20201117025238.3425422-1-yangyingliang@huawei.com>
 <835ab066-b6b8-a211-4941-c01781031de8@linux.intel.com>
 <454f5e3e-c380-e8a5-9283-3f7578eb601e@huawei.com>
 <20201117224102.GD524@willie-the-truck>
 <78bee047-ab33-4d81-6f77-af4c5b6e8aaa@huawei.com>
 <20201125113545.GA15451@willie-the-truck>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <9e7481f4-e55e-6c7a-dde9-62912c6e5eb4@huawei.com>
Date:   Thu, 26 Nov 2020 10:29:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201125113545.GA15451@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/25 19:35, Will Deacon wrote:
> On Wed, Nov 25, 2020 at 09:54:34AM +0800, Yang Yingliang wrote:
>> On 2020/11/18 6:41, Will Deacon wrote:
>>> On Tue, Nov 17, 2020 at 07:11:28PM +0800, Yang Yingliang wrote:
>>>> On 2020/11/17 17:40, Lu Baolu wrote:
>>>>> On 2020/11/17 10:52, Yang Yingliang wrote:
>>>>>> If iommu_group_get() failed, it need return error code
>>>>>> in iommu_probe_device().
>>>>>>
>>>>>> Fixes: cf193888bfbd ("iommu: Move new probe_device path...")
>>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>>>>> ---
>>>>>>     drivers/iommu/iommu.c | 4 +++-
>>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>>> index b53446bb8c6b..6f4a32df90f6 100644
>>>>>> --- a/drivers/iommu/iommu.c
>>>>>> +++ b/drivers/iommu/iommu.c
>>>>>> @@ -253,8 +253,10 @@ int iommu_probe_device(struct device *dev)
>>>>>>             goto err_out;
>>>>>>           group = iommu_group_get(dev);
>>>>>> -    if (!group)
>>>>>> +    if (!group) {
>>>>>> +        ret = -ENODEV;
>>>>> Can you please explain why you use -ENODEV here?
>>>> Before 79659190ee97 ("iommu: Don't take group reference in
>>>> iommu_alloc_default_domain()"), in
>>>>
>>>> iommu_alloc_default_domain(), if group is NULL, it will return -ENODEV.
>>> Hmm. While I think the patch is ok, I'm not sure it qualifies as a fix.
>>> Has iommu_probe_device() ever propagated this error? The commit you
>>> identify in the 'Fixes:' tag doesn't seem to change this afaict.
>> I think after this commit 439945e74a4b ("iommu: Move default domain
>> allocation to iommu_probe_device()"),
> That SHA doesn't exist in my tree (maybe you mean 6e1aa2049154?). But even
> then, I'm not sure 6e1aa2049154 is actually broken if you look at the
> interaction with group creation in __iommu_probe_device().
>
> In fact, isn't that the case in mainline too? If __iommu_probe_device()
> returns 0, then we _know_ a group exists and so iommu_group_get() will
> succeed. I'm still happy with the patch in case this changes in future,
> but it doesn't appear to be fixing anything. Do you agree?

Yes, I look into the __iommu_probe_device(), if it can't get group, it 
will return error

first.  Do I need send a v2 without the fix tag ?

>
> Will
> .
