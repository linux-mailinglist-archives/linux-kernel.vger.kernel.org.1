Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A14304E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404355AbhA0AcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:32:04 -0500
Received: from foss.arm.com ([217.140.110.172]:49436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387609AbhAZRZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:25:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53A0331B;
        Tue, 26 Jan 2021 09:24:52 -0800 (PST)
Received: from [10.57.43.46] (unknown [10.57.43.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 207543F66E;
        Tue, 26 Jan 2021 09:24:51 -0800 (PST)
Subject: Re: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
References: <20210126130629.8928-1-shameerali.kolothum.thodi@huawei.com>
 <20210126135039.000039a0@arm.com>
 <8654e506fa26443f8f4413ec8fd96bf7@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5828b2f9-e1d3-fd96-ebf3-2a38c903c9c3@arm.com>
Date:   Tue, 26 Jan 2021 17:24:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <8654e506fa26443f8f4413ec8fd96bf7@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-26 16:40, Shameerali Kolothum Thodi wrote:
> Hi Robin,
> 
>> -----Original Message-----
>> From: Robin Murphy [mailto:robin.murphy@arm.com]
>> Sent: 26 January 2021 13:51
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
>> jean-philippe@linaro.org; will@kernel.org; linuxarm@openeuler.org; Zengtao
>> (B) <prime.zeng@hisilicon.com>
>> Subject: Re: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
>>
>> On Tue, 26 Jan 2021 13:06:29 +0000
>> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>>
>>> The device iommu probe/attach might have failed leaving dev->iommu to
>>> NULL and device drivers may still invoke these functions resulting a
>>> crash in iommu vendor driver code. Hence make sure we check that.
>>>
>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>   drivers/iommu/iommu.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
>>> ffeebda8d6de..cb68153c5cc0 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -2867,7 +2867,7 @@ bool iommu_dev_has_feature(struct device *dev,
>>> enum iommu_dev_features feat) {
>>>   	const struct iommu_ops *ops = dev->bus->iommu_ops;
>>>
>>> -	if (ops && ops->dev_has_feat)
>>> +	if (dev->iommu && ops && ops->dev_has_feat)
>>>   		return ops->dev_has_feat(dev, feat);
>>
>> Might make sense to make these more self-contained, e.g.:
>>
>> 	if (dev->iommu && dev->iommu->ops->foo)
>> 		dev->iommu->ops->foo()
> 
> Right. Does that mean adding ops to "struct dev_iommu" or retrieve ops like
> below,
> 
> if (dev->iommu && dev->iommu->iommu_dev->ops->foo)
>   		dev->iommu->iommu_dev->ops->foo()
>   
> Sorry, not clear to me.

Bleh, I was thinking that dev->iommu pointed directly to a struct 
iommu_device there, sorry. There are too many things and not enough 
distinct names for the things.

But yeah, basically that if the device's "I am associated with an IOMMU" 
data is set, then by construction it must lead to a set of ops which are 
definitely valid. Conceptually it's cleaner than combining two different 
data sources (the per-device info plus the bus ops which may or may not 
be relevant to a given device), even if cosmetically we have to juggle 
through practically every possible permutation of the names "iommu" and 
"device" to get there :/

Robin.
