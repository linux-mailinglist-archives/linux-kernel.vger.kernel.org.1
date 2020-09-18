Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A8326F4D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIRD5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:57:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbgIRD5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:57:18 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AFF254184C0DB64F4702;
        Fri, 18 Sep 2020 11:57:15 +0800 (CST)
Received: from [10.174.176.220] (10.174.176.220) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 11:57:07 +0800
Subject: Re: [PATCH v12 3/9] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel[_low]()
To:     Dave Young <dyoung@redhat.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-4-chenzhou10@huawei.com>
 <20200918030112.GA3356@dhcp-128-65.nay.redhat.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bhe@redhat.com>, <corbet@lwn.net>, <John.P.donnelly@oracle.com>,
        <prabhakar.pkin@gmail.com>, <bhsharma@redhat.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <d4296985-7296-b5c9-45f3-b03d28bc7bd8@huawei.com>
Date:   Fri, 18 Sep 2020 11:57:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200918030112.GA3356@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,


On 2020/9/18 11:01, Dave Young wrote:
> On 09/07/20 at 09:47pm, Chen Zhou wrote:
>> To make the functions reserve_crashkernel[_low]() as generic,
>> replace some hard-coded numbers with macro CRASH_ADDR_LOW_MAX.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  arch/x86/kernel/setup.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index d7fd90c52dae..71a6a6e7ca5b 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -430,7 +430,7 @@ static int __init reserve_crashkernel_low(void)
>>  	unsigned long total_low_mem;
>>  	int ret;
>>  
>> -	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
>> +	total_low_mem = memblock_mem_size(CRASH_ADDR_LOW_MAX >> PAGE_SHIFT);
> total_low_mem != CRASH_ADDR_LOW_MAX
I just replace the magic number with macro, no other change.
Besides, function memblock_mem_size(limit_pfn) will compute the memory size
according to the actual system ram.

Thanks,
Chen Zhou
>
>>  
>>  	/* crashkernel=Y,low */
>>  	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
> The param total_low_mem is for dynamically change crash_size according
> to system ram size.
>
> Is above change a must for your arm64 patches?
See above.
>
>> @@ -451,7 +451,7 @@ static int __init reserve_crashkernel_low(void)
>>  			return 0;
>>  	}
>>  
>> -	low_base = memblock_find_in_range(CRASH_ALIGN, 1ULL << 32, low_size, CRASH_ALIGN);
>> +	low_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MAX, low_size, CRASH_ALIGN);
>>  	if (!low_base) {
>>  		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>>  		       (unsigned long)(low_size >> 20));
>> @@ -504,8 +504,9 @@ static void __init reserve_crashkernel(void)
>>  	if (!crash_base) {
>>  		/*
>>  		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
>> -		 * crashkernel=x,high reserves memory over 4G, also allocates
>> -		 * 256M extra low memory for DMA buffers and swiotlb.
>> +		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
>> +		 * also allocates 256M extra low memory for DMA buffers
>> +		 * and swiotlb.
>>  		 * But the extra memory is not required for all machines.
>>  		 * So try low memory first and fall back to high memory
>>  		 * unless "crashkernel=size[KMG],high" is specified.
>> @@ -539,7 +540,7 @@ static void __init reserve_crashkernel(void)
>>  		return;
>>  	}
>>  
>> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
>> +	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
>>  		memblock_free(crash_base, crash_size);
>>  		return;
>>  	}
>> -- 
>> 2.20.1
>>
> .
>

