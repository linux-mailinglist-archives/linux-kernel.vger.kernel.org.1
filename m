Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C4F2E34C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 08:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgL1Hdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 02:33:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9651 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgL1Hdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 02:33:39 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D48Q04dk6z15kqm;
        Mon, 28 Dec 2020 15:32:08 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 15:32:50 +0800
Subject: Re: [PATCH 2/2] arm64: mm: fix kdump broken with ZONE_DMA
 reintroduced
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        <catalin.marinas@arm.com>, <will@kernel.org>
References: <20201226033557.116251-1-chenzhou10@huawei.com>
 <20201226033557.116251-3-chenzhou10@huawei.com>
 <653d43ed326e6a3974660c0ca2ad8a847a4ff986.camel@suse.de>
CC:     <ardb@kernel.org>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
        <song.bao.hua@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <deeb19d6-29e2-f76e-9e28-6ad77c7cb1fa@huawei.com>
Date:   Mon, 28 Dec 2020 15:32:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <653d43ed326e6a3974660c0ca2ad8a847a4ff986.camel@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thanks for your review.


On 2020/12/26 18:34, Nicolas Saenz Julienne wrote:
> Hi Chen, thanks for looking at this.
>
> On Sat, 2020-12-26 at 11:35 +0800, Chen Zhou wrote:
>> If the memory reserved for crash dump kernel falled in ZONE_DMA32,
>> the devices in crash dump kernel need to use ZONE_DMA will alloc fail.
>>
>> Fix this by reserving low memory in ZONE_DMA if CONFIG_ZONE_DMA is
>> enabled, otherwise, reserving in ZONE_DMA32.
>>
>> Fixes: bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in ZONE_DMA32")
> I'm not so sure this counts as a fix, if someone backports it it'll probably
> break things as it depends on the series that dynamically sizes DMA zones.
I write this just because kdump is broken from this commit.
>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
> Why not doing the same with CMA? You'll probably have to move the
> dma_contiguous_reserve() call into bootmem_init() so as to make sure that
> arm64_dma_phys_limit is populated.
You are right, CMA also need this. I will do this in next version.

Thanks,
Chen Zhou
>
> Regards,
> Nicolas
>
>>  arch/arm64/mm/init.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 7b9809e39927..5074e945f1a6 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -85,7 +85,8 @@ static void __init reserve_crashkernel(void)
>>  
>>
>>  	if (crash_base == 0) {
>>  		/* Current arm64 boot protocol requires 2MB alignment */
>> -		crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
>> +		crash_base = memblock_find_in_range(0,
>> +				arm64_dma_phys_limit ? : arm64_dma32_phys_limit,
>>  				crash_size, SZ_2M);
>>  		if (crash_base == 0) {
>>  			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>

