Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3662E6EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 07:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgL2Gqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 01:46:47 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9940 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgL2Gqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 01:46:46 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D4lKb5s1HzhyLV;
        Tue, 29 Dec 2020 14:45:23 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Tue, 29 Dec 2020
 14:46:00 +0800
Subject: Re: [PATCH 1/1] ARM: LPAE: use phys_addr_t instead of unsigned long
 in outercache hooks
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201225114458.1334-1-thunder.leizhen@huawei.com>
 <CAK8P3a1-zTyd9WoWxaqZ3s1ye44t1CUuZaU0a5w9bE+krk2cBA@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8c384744-dee3-6ed8-a4b2-753c329c8def@huawei.com>
Date:   Tue, 29 Dec 2020 14:45:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1-zTyd9WoWxaqZ3s1ye44t1CUuZaU0a5w9bE+krk2cBA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/12/28 15:00, Arnd Bergmann wrote:
> On Fri, Dec 25, 2020 at 12:48 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> The outercache of some Hisilicon SOCs support physical addresses wider
>> than 32-bits. The unsigned long datatype is not sufficient for mapping
>> physical addresses >= 4GB. The commit ad6b9c9d78b9 ("ARM: 6671/1: LPAE:
>> use phys_addr_t instead of unsigned long in outercache functions") has
>> already modified the outercache functions. But the parameters of the
>> outercache hooks are not changed. This patch use phys_addr_t instead of
>> unsigned long in outercache hooks: inv_range, clean_range, flush_range.
>>
>> To ensure the outercache that does not support LPAE works properly, do
>> cast phys_addr_t to unsigned long by adding a middle-tier function.
>> For example:
>> -static void l2c220_inv_range(unsigned long start, unsigned long end)
>> +static void __l2c220_inv_range(unsigned long start, unsigned long end)
>>  {
>>         ...
>>  }
>> +static void l2c220_inv_range(phys_addr_t start, phys_addr_t end)
>> +{
>> +  __l2c220_inv_range(start, end);
>> +}
>>
>> Note that the outercache functions have been doing this cast before this
>> patch. So now, the cast is just moved to the middle-tier function.
>>
>> No functional change.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> This looks reasonable in principle, but it would be helpful to
> understand better which SoCs are affected. In which way is
> this specific to Hisilicon implementations, and why would others
> not need this?

I answered at the end.

> 
> Wouldn't this also be needed by an Armada XP that supports
> more than 4GB of RAM but has an outer cache?

I don't know about the armada XP environment.

> 
> I suppose those SoCs using off-the-shelf Arm cores are either
> pre-LPAE and cannot address memory above 4GB, or they do
> not need the outer_cache interfaces.

I think so.

> 
>> diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
>> index 5c1b7a7b9af6300..ab1d8051bf832c9 100644
>> --- a/arch/arm/mm/cache-feroceon-l2.c
>> +++ b/arch/arm/mm/cache-feroceon-l2.c
>> @@ -168,7 +168,7 @@ static unsigned long calc_range_end(unsigned long start, unsigned long end)
>>         return range_end;
>>  }
>>
>> -static void feroceon_l2_inv_range(unsigned long start, unsigned long end)
>> +static void __feroceon_l2_inv_range(unsigned long start, unsigned long end)
>>  {
>>         /*
>>          * Clean and invalidate partial first cache line.
>> @@ -198,7 +198,12 @@ static void feroceon_l2_inv_range(unsigned long start, unsigned long end)
>>         dsb();
>>  }
>>
>> -static void feroceon_l2_clean_range(unsigned long start, unsigned long end)
>> +static void feroceon_l2_inv_range(phys_addr_t start, phys_addr_t end)
>> +{
>> +       __feroceon_l2_inv_range(start, end);
>> +}
>> +
> 
> What is this indirection for? It looks like you do this for all implementations,
> so the actual address gets truncated here.

Because these environments are all 32-bit physical addresses or only the lower
32-bit physical addresses need to be operated. But my environment operates 64-bit
physical address and sizeof(long) is 32. So need to change the datatype of the
outchache hooks.

 struct outer_cache_fns {
-	void (*inv_range)(unsigned long, unsigned long);
-	void (*clean_range)(unsigned long, unsigned long);
-	void (*flush_range)(unsigned long, unsigned long);
+	void (*inv_range)(phys_addr_t, phys_addr_t);
+	void (*clean_range)(phys_addr_t, phys_addr_t);
+	void (*flush_range)(phys_addr_t, phys_addr_t);
 	void (*flush_all)(void);

I added middle-tier function for all implementations, just to ensure that the
above changes do not have side effects on them.

> 
>        Arnd
> 
> .
> 

