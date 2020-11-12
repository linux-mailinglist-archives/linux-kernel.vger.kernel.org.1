Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E243E2B060C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgKLNLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:11:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7180 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgKLNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:11:37 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CX26k3fPJz15QkN;
        Thu, 12 Nov 2020 21:11:26 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Nov 2020 21:11:30 +0800
Subject: Re: [PATCH v13 6/8] arm64: kdump: reimplement crashkernel=X
To:     Baoquan He <bhe@redhat.com>, Mike Rapoport <rppt@kernel.org>
References: <20201031074437.168008-1-chenzhou10@huawei.com>
 <20201031074437.168008-7-chenzhou10@huawei.com>
 <20201111015926.GD24747@MiWiFi-R3L-srv>
 <23389389-2855-50fd-25b7-4f7d4246bf0c@huawei.com>
 <20201111135448.GF8486@MiWiFi-R3L-srv> <20201112082509.GL4758@kernel.org>
 <20201112083645.GL8486@MiWiFi-R3L-srv>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <dyoung@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <bhsharma@redhat.com>,
        <prabhakar.pkin@gmail.com>, <wangkefeng.wang@huawei.com>,
        <arnd@arndb.de>, <linux-doc@vger.kernel.org>,
        <xiexiuqi@huawei.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <horms@verge.net.au>, <james.morse@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <huawei.libin@huawei.com>,
        <guohanjun@huawei.com>, <nsaenzjulienne@suse.de>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <14e0f384-5a3b-9d9f-f8f4-06b1dba807d7@huawei.com>
Date:   Thu, 12 Nov 2020 21:11:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201112083645.GL8486@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/12 16:36, Baoquan He wrote:
> On 11/12/20 at 10:25am, Mike Rapoport wrote:
>> On Wed, Nov 11, 2020 at 09:54:48PM +0800, Baoquan He wrote:
>>> On 11/11/20 at 09:27pm, chenzhou wrote:
>>>> Hi Baoquan,
>>> ...
>>>>>>  #ifdef CONFIG_CRASH_DUMP
>>>>>>  static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
>>>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>>>> index 1c0f3e02f731..c55cee290bbb 100644
>>>>>> --- a/arch/arm64/mm/mmu.c
>>>>>> +++ b/arch/arm64/mm/mmu.c
>>>>>> @@ -488,6 +488,10 @@ static void __init map_mem(pgd_t *pgdp)
>>>>>>  	 */
>>>>>>  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>>>>>>  #ifdef CONFIG_KEXEC_CORE
>>>>>> +	if (crashk_low_res.end)
>>>>>> +		memblock_mark_nomap(crashk_low_res.start,
>>>>>> +				    resource_size(&crashk_low_res));
>>>>>> +
>>>>>>  	if (crashk_res.end)
>>>>>>  		memblock_mark_nomap(crashk_res.start,
>>>>>>  				    resource_size(&crashk_res));
>>>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>>>> index d39892bdb9ae..cdef7d8c91a6 100644
>>>>>> --- a/kernel/crash_core.c
>>>>>> +++ b/kernel/crash_core.c
>>>>>> @@ -321,7 +321,7 @@ int __init parse_crashkernel_low(char *cmdline,
>>>>>>  
>>>>>>  int __init reserve_crashkernel_low(void)
>>>>>>  {
>>>>>> -#ifdef CONFIG_X86_64
>>>>>> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
>>>>> Not very sure if a CONFIG_64BIT checking is better.
>>>> If doing like this, there may be some compiling errors for other 64-bit kernel, such as mips.
>>>>>>  	unsigned long long base, low_base = 0, low_size = 0;
>>>>>>  	unsigned long low_mem_limit;
>>>>>>  	int ret;
>>>>>> @@ -362,12 +362,14 @@ int __init reserve_crashkernel_low(void)
>>>>>>  
>>>>>>  	crashk_low_res.start = low_base;
>>>>>>  	crashk_low_res.end   = low_base + low_size - 1;
>>>>>> +#ifdef CONFIG_X86_64
>>>>>>  	insert_resource(&iomem_resource, &crashk_low_res);
>>>>>> +#endif
>>>>>>  #endif
>>>>>>  	return 0;
>>>>>>  }
>>>>>>  
>>>>>> -#ifdef CONFIG_X86
>>>>>> +#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
>>>>> Should we make this weak default so that we can remove the ARCH config?
>>>> The same as above, some arch may not support kdump, in that case,  compiling errors occur.
>>> OK, not sure if other people have better idea, oterwise, we can leave with it. 
>>> Thanks for telling.
>> I think it would be better to have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
>> in arch/Kconfig and select this by X86 and ARM64.
>>
>> Since reserve_crashkernel() implementations are quite similart on other
>> architectures as well, we can have more users of this later.
> Yes, this sounds like a nice way.
I will think about this in next version.

Thanks,
Chen Zhou
>
> .
>

