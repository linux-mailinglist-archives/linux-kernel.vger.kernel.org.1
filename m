Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A86E2F3724
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405725AbhALRaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:30:08 -0500
Received: from foss.arm.com ([217.140.110.172]:50140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbhALRaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:30:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83E6B1063;
        Tue, 12 Jan 2021 09:29:21 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BC073F719;
        Tue, 12 Jan 2021 09:29:20 -0800 (PST)
Subject: Re: [PATCH] iommu: check for the deferred attach when attaching a
 device
To:     lijiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "Lendacky, Thomas" <thomas.lendacky@amd.com>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, will@kernel.org
References: <20201226053959.4222-1-lijiang@redhat.com>
 <33b6f925-71e6-5d9e-74c3-3e1eaf13398e@redhat.com>
 <b385db3b-4506-6d75-49e1-e11064e65d6a@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8273ce28-5ba6-2a39-5073-ec0f2b12dd2f@arm.com>
Date:   Tue, 12 Jan 2021 17:29:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b385db3b-4506-6d75-49e1-e11064e65d6a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-05 07:52, lijiang wrote:
> 在 2021年01月05日 11:55, lijiang 写道:
>> Hi,
>>
>> Also add Joerg to cc list.
>>
> 
> Also add more people to cc list, Jerry Snitselaar and Tom Lendacky.
> 
> Thanks.
> 
>> Thanks.
>> Lianbo
>> 在 2020年12月26日 13:39, Lianbo Jiang 写道:
>>> Currently, because domain attach allows to be deferred from iommu
>>> driver to device driver, and when iommu initializes, the devices
>>> on the bus will be scanned and the default groups will be allocated.
>>>
>>> Due to the above changes, some devices could be added to the same
>>> group as below:
>>>
>>> [    3.859417] pci 0000:01:00.0: Adding to iommu group 16
>>> [    3.864572] pci 0000:01:00.1: Adding to iommu group 16
>>> [    3.869738] pci 0000:02:00.0: Adding to iommu group 17
>>> [    3.874892] pci 0000:02:00.1: Adding to iommu group 17
>>>
>>> But when attaching these devices, it doesn't allow that a group has
>>> more than one device, otherwise it will return an error. This conflicts
>>> with the deferred attaching. Unfortunately, it has two devices in the
>>> same group for my side, for example:
>>>
>>> [    9.627014] iommu_group_device_count(): device name[0]:0000:01:00.0
>>> [    9.633545] iommu_group_device_count(): device name[1]:0000:01:00.1
>>> ...
>>> [   10.255609] iommu_group_device_count(): device name[0]:0000:02:00.0
>>> [   10.262144] iommu_group_device_count(): device name[1]:0000:02:00.1
>>>
>>> Finally, which caused the failure of tg3 driver when tg3 driver calls
>>> the dma_alloc_coherent() to allocate coherent memory in the tg3_test_dma().
>>>
>>> [    9.660310] tg3 0000:01:00.0: DMA engine test failed, aborting
>>> [    9.754085] tg3: probe of 0000:01:00.0 failed with error -12
>>> [    9.997512] tg3 0000:01:00.1: DMA engine test failed, aborting
>>> [   10.043053] tg3: probe of 0000:01:00.1 failed with error -12
>>> [   10.288905] tg3 0000:02:00.0: DMA engine test failed, aborting
>>> [   10.334070] tg3: probe of 0000:02:00.0 failed with error -12
>>> [   10.578303] tg3 0000:02:00.1: DMA engine test failed, aborting
>>> [   10.622629] tg3: probe of 0000:02:00.1 failed with error -12
>>>
>>> In addition, the similar situations also occur in other drivers such
>>> as the bnxt_en driver. That can be reproduced easily in kdump kernel
>>> when SME is active.
>>>
>>> Add a check for the deferred attach in the iommu_attach_device() and
>>> allow to attach the deferred device regardless of how many devices
>>> are in a group.

Is this iommu_attach_device() call is coming from iommu-dma? (if not, 
then whoever's calling it probably shouldn't be)

Assuming so, then probably what should happen is to move the handling 
currently in iommu_dma_deferred_attach() into the core so that it can 
call __iommu_attach_device() directly - the intent is just to replay 
that exact call skipped in iommu_group_add_device(), so the legacy 
external iommu_attach_device() interface isn't really the right tool for 
the job anyway. That's just slightly awkward since ideally it wants to 
be done in a way that doesn't result in a redundant out-of-line call for 
!kdump.

Alternatively I suppose it *could* just call ops->attach_dev directly, 
but then we miss out on the tracepoint, and deferred attach is arguably 
one of the cases where that's most useful :/

Robin.

>>>
>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>> ---
>>>   drivers/iommu/iommu.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index ffeebda8d6de..dccab7b133fb 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -1967,8 +1967,11 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>>>   	 */
>>>   	mutex_lock(&group->mutex);
>>>   	ret = -EINVAL;
>>> -	if (iommu_group_device_count(group) != 1)
>>> +	if (!iommu_is_attach_deferred(domain, dev) &&
>>> +	    iommu_group_device_count(group) != 1) {
>>> +		dev_err_ratelimited(dev, "Group has more than one device\n");
>>>   		goto out_unlock;
>>> +	}
>>>   
>>>   	ret = __iommu_attach_group(domain, group);
>>>   
>>>
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
