Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11A027A536
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 03:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgI1BaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 21:30:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14305 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbgI1BaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 21:30:09 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D396556E722F403AD9F1;
        Mon, 28 Sep 2020 09:30:19 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 28 Sep 2020
 09:30:09 +0800
Subject: Re: [PATCH v2 2/2] ARM: support PHYS_OFFSET minimum aligned at 64KiB
 boundary
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Jianguo Chen <chenjianguo3@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        patches-armlinux <patches@armlinux.org.uk>
References: <20200915131615.3138-1-thunder.leizhen@huawei.com>
 <20200915131615.3138-3-thunder.leizhen@huawei.com>
 <20200915190143.GP1551@shell.armlinux.org.uk>
 <CAMj1kXHdX5cCZKvbBO+hCkkt46aOgf4NjK2jba2Gb2tziZm2DQ@mail.gmail.com>
 <a196451d-fbef-bab6-e042-00a817db611c@huawei.com>
 <CAMj1kXGdFj8KxqJB8WMOdKYWPChkHbM7+nLaAWBZ29o=q7N0Aw@mail.gmail.com>
 <5180c217-a9d3-18d1-c4ad-9cad33247e96@huawei.com>
 <de14b500-6485-d542-b65b-ddb60b2042d2@huawei.com>
Message-ID: <b6a777af-51f4-07b4-3036-b81e3008b0e8@huawei.com>
Date:   Mon, 28 Sep 2020 09:30:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <de14b500-6485-d542-b65b-ddb60b2042d2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/22 20:30, Leizhen (ThunderTown) wrote:
> 
> 
> On 2020/9/21 16:53, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2020/9/21 14:47, Ard Biesheuvel wrote:
>>> On Mon, 21 Sep 2020 at 05:35, Leizhen (ThunderTown)
>>> <thunder.leizhen@huawei.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2020/9/17 22:00, Ard Biesheuvel wrote:
>>>>> On Tue, 15 Sep 2020 at 22:06, Russell King - ARM Linux admin
>>>>> <linux@armlinux.org.uk> wrote:
>>>>>>
>>>>>> On Tue, Sep 15, 2020 at 09:16:15PM +0800, Zhen Lei wrote:
>>>>>>> Currently, only support the kernels where the base of physical memory is
>>>>>>> at a 16MiB boundary. Because the add/sub instructions only contains 8bits
>>>>>>> unrotated value. But we can use one more "add/sub" instructions to handle
>>>>>>> bits 23-16. The performance will be slightly affected.
>>>>>>>
>>>>>>> Since most boards meet 16 MiB alignment, so add a new configuration
>>>>>>> option ARM_PATCH_PHYS_VIRT_RADICAL (default n) to control it. Say Y if
>>>>>>> anyone really needs it.
>>>>>>>
>>>>>>> All r0-r7 (r1 = machine no, r2 = atags or dtb, in the start-up phase) are
>>>>>>> used in __fixup_a_pv_table() now, but the callee saved r11 is not used in
>>>>>>> the whole head.S file. So choose it.
>>>>>>>
>>>>>>> Because the calculation of "y = x + __pv_offset[63:24]" have been done,
>>>>>>> so we only need to calculate "y = y + __pv_offset[23:16]", that's why
>>>>>>> the parameters "to" and "from" of __pv_stub() and __pv_add_carry_stub()
>>>>>>> in the scope of CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL are all passed "t"
>>>>>>> (above y).
>>>>>>>
>>>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>>>> ---
>>>>>>>  arch/arm/Kconfig              | 18 +++++++++++++++++-
>>>>>>>  arch/arm/include/asm/memory.h | 16 +++++++++++++---
>>>>>>>  arch/arm/kernel/head.S        | 25 +++++++++++++++++++------
>>>>>>>  3 files changed, 49 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>>>>> index e00d94b16658765..19fc2c746e2ce29 100644
>>>>>>> --- a/arch/arm/Kconfig
>>>>>>> +++ b/arch/arm/Kconfig
>>>>>>> @@ -240,12 +240,28 @@ config ARM_PATCH_PHYS_VIRT
>>>>>>>         kernel in system memory.
>>>>>>>
>>>>>>>         This can only be used with non-XIP MMU kernels where the base
>>>>>>> -       of physical memory is at a 16MB boundary.
>>>>>>> +       of physical memory is at a 16MiB boundary.
>>>>>>>
>>>>>>>         Only disable this option if you know that you do not require
>>>>>>>         this feature (eg, building a kernel for a single machine) and
>>>>>>>         you need to shrink the kernel to the minimal size.
>>>>>>>
>>>>>>> +config ARM_PATCH_PHYS_VIRT_RADICAL
>>>>>>> +     bool "Support PHYS_OFFSET minimum aligned at 64KiB boundary"
>>>>>>> +     default n
>>>>>>
>>>>>> Please drop the "default n" - this is the default anyway.
>>>>>>
>>>>>>> @@ -236,6 +243,9 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>>>>>>>        * in place where 'r' 32 bit operand is expected.
>>>>>>>        */
>>>>>>>       __pv_stub((unsigned long) x, t, "sub", __PV_BITS_31_24);
>>>>>>> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
>>>>>>> +     __pv_stub((unsigned long) t, t, "sub", __PV_BITS_23_16);
>>>>>>
>>>>>> t is already unsigned long, so this cast is not necessary.
>>>>>>
>>>>>> I've been debating whether it would be better to use "movw" for this
>>>>>> for ARMv7.  In other words:
>>>>>>
>>>>>>         movw    tmp, #16-bit
>>>>>>         adds    %Q0, %1, tmp, lsl #16
>>>>>>         adc     %R0, %R0, #0
>>>>>>
>>>>>> It would certainly be less instructions, but at the cost of an
>>>>>> additional register - and we'd have to change the fixup code to
>>>>>> know about movw.
>>>>>>
>>>>>> Thoughts?
>>>>>>
>>>>>
>>>>> Since LPAE implies v7, we can use movw unconditionally, which is nice.
>>>>>
>>>>> There is no need to use an additional temp register, as we can use the
>>>>> register holding the high word. (There is no need for the mov_hi macro
>>>>> to be separate)
>>>>>
>>>>> 0:     movw    %R0, #low offset >> 16
>>>>>        adds    %Q0, %1, %R0, lsl #16
>>>>> 1:     mov     %R0, #high offset
>>>>>        adc     %R0, %R0, #0
>>>>>        .pushsection .pv_table,"a"
>>>>>        .long 0b, 1b
>>>>>        .popsection
>>>>>
>>>>> The only problem is distinguishing the two mov instructions from each
>>>>
>>>> The #high offset can also consider use movw, it just save two bytes in
>>>> the thumb2 scenario. We can store different imm16 value for high_offset
>>>> and low_offset, so that we can distinguish them in __fixup_a_pv_table().
>>>>
>>>> This will make the final implementation of the code look more clear and
>>>> consistent, especially THUMB2.
>>>>
>>>> Let me try it.
>>>>
>>>
>>> Hello Zhen Lei,
>>>
>>> I am looking into this as well:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm-p2v-v2
>>>
>>> Could you please test this version on your hardware?
>>
>> OK, I will test it on my boards.
> Hi Ard Biesheuvel:
>   I have tested it on 16MiB aligned + LE board, it works well. I've asked my colleagues
> from other departments to run it on 2MiB aligned + BE board. He will do it tomorrow.

Hi, Ard Biesheuvel:
  I'm sorry to keep you waiting so long. You patch series works well on 2MiB aligned + BE board
also. I spent a lot of time, because our 2MiB aligned + BE board loads zImage. Therefore, special
processing is required for the following code:

arch/arm/boot/compressed/head.S:
#ifdef CONFIG_AUTO_ZRELADDR
                mov     r4, pc
                and     r4, r4, #0xf8000000		//currently only support 128MiB alignment
                add     r4, r4, #TEXT_OFFSET
#else

This is a special scenario that does not conflict with your code framework. So I'm trying to fix it.

Tested-by: Zhen Lei <thunder.leizhen@huawei.com>


> 
> 
>>
>>>
>>> .
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>> .
>>

