Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9980526F8ED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIRJHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:07:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgIRJHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:07:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 88B488C1D3F7D245D2D1;
        Fri, 18 Sep 2020 17:07:04 +0800 (CST)
Received: from [10.174.176.220] (10.174.176.220) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 17:06:38 +0800
Subject: Re: [PATCH v12 3/9] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel[_low]()
To:     Baoquan He <bhe@redhat.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-4-chenzhou10@huawei.com>
 <20200918072526.GD25604@MiWiFi-R3L-srv>
 <fa6634dd-4438-4e5d-f350-fc19d5fa7d97@huawei.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dyoung@redhat.com>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <bhsharma@redhat.com>, <horms@verge.net.au>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <nsaenzjulienne@suse.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <rppt@linux.ibm.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <14e22d92-1601-fc1c-a1c8-e3936d63db42@huawei.com>
Date:   Fri, 18 Sep 2020 17:06:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <fa6634dd-4438-4e5d-f350-fc19d5fa7d97@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,


On 2020/9/18 16:59, chenzhou wrote:
> Hi Baoquan,
>
> On 2020/9/18 15:25, Baoquan He wrote:
>> Hi,
>>
>> On 09/07/20 at 09:47pm, Chen Zhou wrote:
>>> To make the functions reserve_crashkernel[_low]() as generic,
>>> replace some hard-coded numbers with macro CRASH_ADDR_LOW_MAX.
>>>
>>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>>> ---
>>>  arch/x86/kernel/setup.c | 11 ++++++-----
>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>>> index d7fd90c52dae..71a6a6e7ca5b 100644
>>> --- a/arch/x86/kernel/setup.c
>>> +++ b/arch/x86/kernel/setup.c
>>> @@ -430,7 +430,7 @@ static int __init reserve_crashkernel_low(void)
>>>  	unsigned long total_low_mem;
>>>  	int ret;
>>>  
>>> -	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
>>> +	total_low_mem = memblock_mem_size(CRASH_ADDR_LOW_MAX >> PAGE_SHIFT);
>> Just note that the replacement has been done in another patch from Mike
>> Rapoport, partially. He seems to have done reserve_crashkernel_low()
>> part, there's one left in reserve_crashkernel(), you might want to check
>> that. 
>>
>> Mike's patch which is from a patchset has been merged into Andrew's next
>> tree.
>>
>> commit 6e50f7672ffa362e9bd4bc0c0d2524ed872828c5
>> Author: Mike Rapoport <rppt@linux.ibm.com>
>> Date:   Wed Aug 26 15:22:32 2020 +1000
>>
>>     x86/setup: simplify reserve_crashkernel()
As Baoquan said, some functions have been changed in the next tree,
if i need to rebase on top of the next tree.

Thanks,
Chen Zhou
> Yeah, the function reserve_crashkernel() has been changed in the next tree.
> Thanks for your review and reminder.
>
> Thanks,
> Chen Zhou
>>>  
>>>  	/* crashkernel=Y,low */
>>>  	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
>>> @@ -451,7 +451,7 @@ static int __init reserve_crashkernel_low(void)
>>>  			return 0;
>>>  	}
>>>  
>>> -	low_base = memblock_find_in_range(CRASH_ALIGN, 1ULL << 32, low_size, CRASH_ALIGN);
>>> +	low_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MAX, low_size, CRASH_ALIGN);
>>>  	if (!low_base) {
>>>  		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>>>  		       (unsigned long)(low_size >> 20));
>>> @@ -504,8 +504,9 @@ static void __init reserve_crashkernel(void)
>>>  	if (!crash_base) {
>>>  		/*
>>>  		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
>>> -		 * crashkernel=x,high reserves memory over 4G, also allocates
>>> -		 * 256M extra low memory for DMA buffers and swiotlb.
>>> +		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
>>> +		 * also allocates 256M extra low memory for DMA buffers
>>> +		 * and swiotlb.
>>>  		 * But the extra memory is not required for all machines.
>>>  		 * So try low memory first and fall back to high memory
>>>  		 * unless "crashkernel=size[KMG],high" is specified.
>>> @@ -539,7 +540,7 @@ static void __init reserve_crashkernel(void)
>>>  		return;
>>>  	}
>>>  
>>> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
>>> +	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
>>>  		memblock_free(crash_base, crash_size);
>>>  		return;
>>>  	}
>>> -- 
>>> 2.20.1
>>>
>> .
>>

