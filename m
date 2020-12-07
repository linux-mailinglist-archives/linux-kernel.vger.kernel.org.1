Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483D92D1040
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgLGMQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:16:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9027 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgLGMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:16:14 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqMh45cdtzhntL;
        Mon,  7 Dec 2020 20:15:00 +0800 (CST)
Received: from [10.174.187.37] (10.174.187.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 20:15:22 +0800
Subject: Re: [PATCH] iommu: Up front sanity check in the arm_lpae_map
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20201205082957.12544-1-zhukeqian1@huawei.com>
 <b85e98c8-0117-49c5-97ad-896ff88f7b88@arm.com>
 <20201207120527.GA4474@willie-the-truck>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, Marc Zyngier <maz@kernel.org>,
        "Joerg Roedel" <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "James Morse" <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>
From:   zhukeqian <zhukeqian1@huawei.com>
Message-ID: <2b0ec25b-0fa4-65ca-7c1b-109ce766197f@huawei.com>
Date:   Mon, 7 Dec 2020 20:15:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201207120527.GA4474@willie-the-truck>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/12/7 20:05, Will Deacon wrote:
> On Mon, Dec 07, 2020 at 12:01:09PM +0000, Robin Murphy wrote:
>> On 2020-12-05 08:29, Keqian Zhu wrote:
>>> ... then we have more chance to detect wrong code logic.
>>
>> I don't follow that justification - it's still the same check with the same
>> outcome, so how does moving it have any effect on the chance to detect
>> errors?

>>
>> AFAICS the only difference it would make is to make some errors *less*
>> obvious - if a sufficiently broken caller passes an empty prot value
>> alongside an invalid size or already-mapped address, this will now quietly
>> hide the warnings from the more serious condition(s).
>>
>> Yes, it will bail out a bit faster in the specific case where the prot value
>> is the only thing wrong, but since when do we optimise for fundamentally
>> incorrect API usage?
> 
> I thought it was the other way round -- doesn't this patch move the "empty
> prot" check later, so we have a chance to check the size and addresses
> first?

Yes, this is my original idea.
For that we treat iommu_prot with no permission as success at early start, defer
this early return can expose hidden errors.

Thanks,
Keqian
> 
> Will
> 
>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> ---
>>>   drivers/iommu/io-pgtable-arm.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>>> index a7a9bc08dcd1..8ade72adab31 100644
>>> --- a/drivers/iommu/io-pgtable-arm.c
>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>> @@ -444,10 +444,6 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>>>   	arm_lpae_iopte prot;
>>>   	long iaext = (s64)iova >> cfg->ias;
>>> -	/* If no access, then nothing to do */
>>> -	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
>>> -		return 0;
>>> -
>>>   	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
>>>   		return -EINVAL;
>>> @@ -456,6 +452,10 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>>>   	if (WARN_ON(iaext || paddr >> cfg->oas))
>>>   		return -ERANGE;
>>> +	/* If no access, then nothing to do */
>>> +	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
>>> +		return 0;
>>> +
>>>   	prot = arm_lpae_prot_to_pte(data, iommu_prot);
>>>   	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep, gfp);
>>>   	/*
>>>
> .
> 
