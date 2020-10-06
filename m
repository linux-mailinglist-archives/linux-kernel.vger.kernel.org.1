Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9915E2843D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 03:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJFBeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 21:34:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbgJFBeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 21:34:25 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 37E85699AB092B3F594E;
        Tue,  6 Oct 2020 09:34:23 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 6 Oct 2020 09:34:15 +0800
Subject: Re: [PATCH v12 7/9] kdump: add threshold for the required memory
To:     Catalin Marinas <catalin.marinas@arm.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-8-chenzhou10@huawei.com> <20201005171248.GB14576@gaia>
CC:     <will@kernel.org>, <james.morse@arm.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <dyoung@redhat.com>, <bhe@redhat.com>,
        <corbet@lwn.net>, <John.P.donnelly@oracle.com>,
        <prabhakar.pkin@gmail.com>, <bhsharma@redhat.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <8777c5be-a8d1-50bd-a44d-168dea009e13@huawei.com>
Date:   Tue, 6 Oct 2020 09:34:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201005171248.GB14576@gaia>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/10/6 1:12, Catalin Marinas wrote:
> On Mon, Sep 07, 2020 at 09:47:43PM +0800, Chen Zhou wrote:
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 3f735cb37ace..d11d597a470d 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -378,6 +378,15 @@ int __init reserve_crashkernel_low(void)
>>  }
>>  
>>  #if defined(CONFIG_X86) || defined(CONFIG_ARM64)
>> +
>> +/*
>> + * Add a threshold for required memory size of crashkernel. If required memory
>> + * size is greater than threshold, just go for high allocation directly. The
>> + * value of threshold is set as half of the total low memory.
>> + */
>> +#define REQUIRED_MEMORY_THRESHOLD	(memblock_mem_size(CRASH_ADDR_LOW_MAX >> \
>> +			PAGE_SHIFT) >> 1)
>> +
>>  #ifdef CONFIG_KEXEC_CORE
>>  /*
>>   * reserve_crashkernel() - reserves memory for crash kernel
>> @@ -422,7 +431,7 @@ void __init reserve_crashkernel(void)
>>  		 * So try low memory first and fall back to high memory
>>  		 * unless "crashkernel=size[KMG],high" is specified.
>>  		 */
>> -		if (!high)
>> +		if (!high && crash_size <= REQUIRED_MEMORY_THRESHOLD)
>>  			crash_base = memblock_find_in_range(CRASH_ALIGN,
>>  						CRASH_ADDR_LOW_MAX,
>>  						crash_size, CRASH_ALIGN);
> Since any change now is affecting the x86 semantics slightly, I'd
> suggest you drop this patch. We can add it later if needed, once the
> core changes are in.
Ok, i will drop this patch in next version.

Thanks,
Chen Zhou
>
> Thinking about this, if one requires a crashkernel reservation that
> allocates all of the ZONE_DMA, it would probably be noticed and explicit
> ,high/,low options can be used.
>
> Note that we are also trying to make ZONE_DMA full 32-bit on non-RPi4
> hardware.
>

