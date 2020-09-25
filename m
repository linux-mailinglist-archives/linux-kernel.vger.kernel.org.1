Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17F0278B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgIYOhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:37:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2920 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728038AbgIYOhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:37:33 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 124BC412629B66515EF8;
        Fri, 25 Sep 2020 15:37:32 +0100 (IST)
Received: from [127.0.0.1] (10.47.7.140) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 25 Sep
 2020 15:37:31 +0100
Subject: Re: [PATCH 1/2] iommu/iova: Flush CPU rcache for when a depot fills
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, <linuxarm@huawei.com>,
        <xiyou.wangcong@gmail.com>, <thunder.leizhen@huawei.com>
References: <1601027469-221812-1-git-send-email-john.garry@huawei.com>
 <1601027469-221812-2-git-send-email-john.garry@huawei.com>
 <bede311f-9a07-98e1-e728-9acd4ad13b51@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <11d30dc2-0b2d-fc30-a07a-9c5f18064d2b@huawei.com>
Date:   Fri, 25 Sep 2020 15:34:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <bede311f-9a07-98e1-e728-9acd4ad13b51@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.7.140]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2020 12:53, Robin Murphy wrote:
>> ---
>>   drivers/iommu/iova.c | 25 ++++++++++++++++---------
>>   1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 45a251da5453..05e0b462e0d9 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -892,9 +892,8 @@ static bool __iova_rcache_insert(struct 
>> iova_domain *iovad,
>>                    struct iova_rcache *rcache,
>>                    unsigned long iova_pfn)
>>   {
>> -    struct iova_magazine *mag_to_free = NULL;
>>       struct iova_cpu_rcache *cpu_rcache;
>> -    bool can_insert = false;
>> +    bool can_insert = false, flush = false;
>>       unsigned long flags;
>>       cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
>> @@ -913,13 +912,19 @@ static bool __iova_rcache_insert(struct 
>> iova_domain *iovad,
>>               if (rcache->depot_size < MAX_GLOBAL_MAGS) {
>>                   rcache->depot[rcache->depot_size++] =
>>                           cpu_rcache->loaded;
>> +                can_insert = true;
>> +                cpu_rcache->loaded = new_mag;
>>               } else {
>> -                mag_to_free = cpu_rcache->loaded;
>> +                /*
>> +                 * The depot is full, meaning that a very large
>> +                 * cache of IOVAs has built up, which slows
>> +                 * down RB tree accesses significantly
>> +                 * -> let's flush at this point.
>> +                 */
>> +                flush = true;
>> +                iova_magazine_free(new_mag);
>>               }
>>               spin_unlock(&rcache->lock);
>> -
>> -            cpu_rcache->loaded = new_mag;
>> -            can_insert = true;
>>           }
>>       }
>> @@ -928,9 +933,11 @@ static bool __iova_rcache_insert(struct 
>> iova_domain *iovad,
>>       spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>> -    if (mag_to_free) {
>> -        iova_magazine_free_pfns(mag_to_free, iovad);
>> -        iova_magazine_free(mag_to_free);
>> +    if (flush) {
> 
> Do you really need this flag, or is it effectively just mirroring 
> "!can_insert" - in theory if there wasn't enough memory to allocate a 
> new magazine, then freeing some more IOVAs wouldn't necessarily be a bad 
> thing to do anyway.

Right, I can reuse can_insert.

> 
> Other than that, I think this looks reasonable. Every time I look at 
> __iova_rcache_insert() I'm convinced there must be a way to restructure 
> it to be more streamlined overall, but I can never quite see exactly how...
> 

We could remove the new_mag check, but the code cannot safely handle 
loaded/prev = NULL. Indeed, I think that the mainline code has a bug:

If the initial allocation for the loaded/prev magazines fail (give NULL) 
in init_iova_rcaches(), then in __iova_rcache_insert():

if (!iova_magazine_full(cpu_rcache->loaded)) {
	can_insert = true;

If cpu_rcache->loaded == NULL, then can_insert is assigned true -> bang, 
as I experimented, below. This needs to be fixed...

Thanks,
john



ereference at virtual address 0000000000000000
[ 10.195299] Mem abort info:
[ 10.198080] ESR = 0x96000004
[ 10.201121] EC = 0x25: DABT (current EL), IL = 32 bits
[ 10.206418] SET = 0, FnV = 0
[ 10.209459] EA = 0, S1PTW = 0
[ 10.212585] Data abort info:
[ 10.215452] ISV = 0, ISS = 0x00000004
[ 10.219274] CM = 0, WnR = 0
[ 10.222228] [0000000000000000] user address but active_mm is swapper
[ 10.228569] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[ 10.234127] Modules linked in:
[ 10.237170] CPU: 11 PID: 696 Comm: irq/40-hisi_sas Not tainted 
5.9.0-rc5-47738-gb1ead657a3fa-dirty #658
[ 10.246548] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 
- V1.16.01 03/15/2019
[ 10.255058] pstate: 60c00089 (nZCv daIf +PAN +UAO BTYPE=--)
[ 10.260620] pc : free_iova_fast+0xfc/0x280
[ 10.264703] lr : free_iova_fast+0x94/0x280
[ 10.268785] sp : ffff80002477bbb0
[ 10.272086] x29: ffff80002477bbb0 x28: 0000000000000000
[ 10.277385] x27: ffff002bc8fbb940 x26: ffff002bc727e26c
[ 10.282684] x25: 0000000000000000 x24: ffff002bc9439008
[ 10.287982] x23: 00000000000fdffe x22: 0000000000000080
[ 10.293280] x21: ffff002bc9439008 x20: 0000000000000000
[ 10.298579] x19: fffff403e9ebb700 x18: ffffffffffffffff
[ 10.303877] x17: 0000000000000001 x16: 0000000000000000
[ 10.309176] x15: 000000000000ffff x14: 0000000000000040
[ 10.314474] x13: 0000000000007fff x12: 000000000001ffff
[ 10.319772] x11: 000000000000000f x10: 0000000000006000
[ 10.325070] x9 : 0000000000000000 x8 : ffff80002477b768
[ 10.330368] x7 : 0000000000000000 x6 : 000000000000003f
[ 10.335666] x5 : 0000000000000040 x4 : 0000000000000000
[ 10.340964] x3 : fffff403e9ebb700 x2 : 0000000000000000
[ 10.346262] x1 : 0000000000000000 x0 : 0000000000000000
[ 10.351561] Call trace:
[ 10.353995]free_iova_fast+0xfc/0x280
[ 10.357731]iommu_dma_free_iova+0x64/0x70
[ 10.361814]__iommu_dma_unmap+0x9c/0xf8
[ 10.365723]iommu_dma_unmap_sg+0xa8/0xc8
[ 10.369720]dma_unmap_sg_attrs+0x28/0x50
[ 10.373717]cq_thread_v3_hw+0x2dc/0x528
[ 10.377626]irq_thread_fn+0x2c/0xa0
[ 10.381188]irq_thread+0x130/0x1e0
[ 10.384664]kthread+0x154/0x158
[ 10.387879]ret_from_fork+0x10/0x34
