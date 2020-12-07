Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D512D1024
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgLGMKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:10:51 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2331 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgLGMKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:10:51 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CqMYR1xCjz13RDD;
        Mon,  7 Dec 2020 20:09:15 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 7 Dec 2020 20:10:06 +0800
Received: from [10.174.185.137] (10.174.185.137) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 7 Dec 2020 20:10:05 +0800
Subject: Re: [PATCH] iommu/io-pgtalbe-arm: Remove "iopte_type(pte, l)" extra
 parameter "l"
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <20201207081404.1699-1-jiangkunkun@huawei.com>
 <20201207102458.GB3825@willie-the-truck>
From:   Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <83f3f9f5-43d8-e02b-39e2-70edd42799a8@huawei.com>
Date:   Mon, 7 Dec 2020 20:09:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201207102458.GB3825@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.185.137]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020/12/7 18:24, Will Deacon wrote:
> On Mon, Dec 07, 2020 at 04:14:04PM +0800, Kunkun Jiang wrote:
>> Knowing from the code, the macro "iopte_type(pte, l)" doesn't use the
>> parameter "l" (level). So we'd better to remove it.
>>
>> Fixes: e1d3c0fd701df(iommu: add ARM LPAE page table allocator)
>> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
>> ---
>>   drivers/iommu/io-pgtable-arm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index a7a9bc08dcd1..925ae2b713d6 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -130,7 +130,7 @@
>>   /* IOPTE accessors */
>>   #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
>>   
>> -#define iopte_type(pte,l)					\
>> +#define iopte_type(pte)					\
>>   	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
> Shouldn't we update all the users of the macro too?
>
> Will
> .

Sorry for my carelessness.  :(

I have resent it.


Thanks,

Kunkun Jiang

