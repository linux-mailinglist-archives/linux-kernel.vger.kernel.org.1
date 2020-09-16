Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A90F26B98D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIPB5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:57:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbgIPB53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:57:29 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D2C6D40F7D51F7671BF7;
        Wed, 16 Sep 2020 09:57:26 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 09:57:16 +0800
Subject: Re: [PATCH v2 2/2] ARM: support PHYS_OFFSET minimum aligned at 64KiB
 boundary
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        patches-armlinux <patches@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Jianguo Chen" <chenjianguo3@huawei.com>
References: <20200915131615.3138-1-thunder.leizhen@huawei.com>
 <20200915131615.3138-3-thunder.leizhen@huawei.com>
 <20200915190143.GP1551@shell.armlinux.org.uk>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2d12f7da-aef4-85dc-0ba6-a06fb5eab59c@huawei.com>
Date:   Wed, 16 Sep 2020 09:57:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200915190143.GP1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/16 3:01, Russell King - ARM Linux admin wrote:
> On Tue, Sep 15, 2020 at 09:16:15PM +0800, Zhen Lei wrote:
>> Currently, only support the kernels where the base of physical memory is
>> at a 16MiB boundary. Because the add/sub instructions only contains 8bits
>> unrotated value. But we can use one more "add/sub" instructions to handle
>> bits 23-16. The performance will be slightly affected.
>>
>> Since most boards meet 16 MiB alignment, so add a new configuration
>> option ARM_PATCH_PHYS_VIRT_RADICAL (default n) to control it. Say Y if
>> anyone really needs it.
>>
>> All r0-r7 (r1 = machine no, r2 = atags or dtb, in the start-up phase) are
>> used in __fixup_a_pv_table() now, but the callee saved r11 is not used in
>> the whole head.S file. So choose it.
>>
>> Because the calculation of "y = x + __pv_offset[63:24]" have been done,
>> so we only need to calculate "y = y + __pv_offset[23:16]", that's why
>> the parameters "to" and "from" of __pv_stub() and __pv_add_carry_stub()
>> in the scope of CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL are all passed "t"
>> (above y).
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/arm/Kconfig              | 18 +++++++++++++++++-
>>  arch/arm/include/asm/memory.h | 16 +++++++++++++---
>>  arch/arm/kernel/head.S        | 25 +++++++++++++++++++------
>>  3 files changed, 49 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index e00d94b16658765..19fc2c746e2ce29 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -240,12 +240,28 @@ config ARM_PATCH_PHYS_VIRT
>>  	  kernel in system memory.
>>  
>>  	  This can only be used with non-XIP MMU kernels where the base
>> -	  of physical memory is at a 16MB boundary.
>> +	  of physical memory is at a 16MiB boundary.
>>  
>>  	  Only disable this option if you know that you do not require
>>  	  this feature (eg, building a kernel for a single machine) and
>>  	  you need to shrink the kernel to the minimal size.
>>  
>> +config ARM_PATCH_PHYS_VIRT_RADICAL
>> +	bool "Support PHYS_OFFSET minimum aligned at 64KiB boundary"
>> +	default n
> 
> Please drop the "default n" - this is the default anyway.

OK, I will remove it.

> 
>> @@ -236,6 +243,9 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>>  	 * in place where 'r' 32 bit operand is expected.
>>  	 */
>>  	__pv_stub((unsigned long) x, t, "sub", __PV_BITS_31_24);
>> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
>> +	__pv_stub((unsigned long) t, t, "sub", __PV_BITS_23_16);
> 
> t is already unsigned long, so this cast is not necessary.

Oh, yes, yes, I copied from the above statement, but forgot to remove it.

> 
> I've been debating whether it would be better to use "movw" for this
> for ARMv7.  In other words:
> 
> 	movw	tmp, #16-bit
> 	adds	%Q0, %1, tmp, lsl #16
> 	adc	%R0, %R0, #0
> 
> It would certainly be less instructions, but at the cost of an
> additional register - and we'd have to change the fixup code to
> know about movw.

It's one less instruction for 64KiB boundary && (sizeof(phys_addr_t) == 8),
and no increase or decrease for 64KiB boundary && (sizeof(phys_addr_t) == 4),
but one more instruction for 16MiB boundary.

And maybe: 16MiB is widely used, but 64KiB is rarely used.

So I'm inclined to the current revision.

> 
> Thoughts?
> 

