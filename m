Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7123D2D0F86
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgLGLiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:38:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9025 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgLGLhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:37:55 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqLqs5J27zhmfP;
        Mon,  7 Dec 2020 19:36:41 +0800 (CST)
Received: from [10.174.187.37] (10.174.187.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 19:37:05 +0800
Subject: Re: [PATCH] iommu: Up front sanity check in the arm_lpae_map
To:     Will Deacon <will@kernel.org>
References: <20201205082957.12544-1-zhukeqian1@huawei.com>
 <20201207105900.GB4198@willie-the-truck>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, Marc Zyngier <maz@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>
From:   zhukeqian <zhukeqian1@huawei.com>
Message-ID: <94799248-f9d1-3a2e-6b82-23d613d4e74b@huawei.com>
Date:   Mon, 7 Dec 2020 19:37:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201207105900.GB4198@willie-the-truck>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020/12/7 18:59, Will Deacon wrote:
> On Sat, Dec 05, 2020 at 04:29:57PM +0800, Keqian Zhu wrote:
>> ... then we have more chance to detect wrong code logic.
> 
> This could do with being a bit more explicit. Something like:
> 
> 	Although handling a mapping request with no permissions is a
> 	trivial no-op, defer the early return until after the size/range
> 	checks so that we are consistent with other mapping requests.
This looks well, thanks.

> 
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>  drivers/iommu/io-pgtable-arm.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index a7a9bc08dcd1..8ade72adab31 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -444,10 +444,6 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>>  	arm_lpae_iopte prot;
>>  	long iaext = (s64)iova >> cfg->ias;
>>  
>> -	/* If no access, then nothing to do */
>> -	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
>> -		return 0;
>> -
>>  	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
>>  		return -EINVAL;
>>  
>> @@ -456,6 +452,10 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>>  	if (WARN_ON(iaext || paddr >> cfg->oas))
>>  		return -ERANGE;
>>  
>> +	/* If no access, then nothing to do */
>> +	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
>> +		return 0;
> 
> This looks sensible to me, but please can you make the same change for
> io-pgtable-arm-v7s.c so that the behaviour is consistent across the two
> formats?
> 
OK. I can do it right now.


Thanks,
Keqian
> Thanks,
> 
> Will
> .
> 
