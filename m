Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4921A2EE3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 07:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgDIFxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 01:53:14 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47675 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgDIFxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 01:53:14 -0400
Received: from [192.168.1.101] (lfbn-lyo-1-453-25.w2-7.abo.wanadoo.fr [2.7.45.25])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9D6A5240003;
        Thu,  9 Apr 2020 05:53:12 +0000 (UTC)
Subject: Re: [PATCH RFC 6/8] riscv/kaslr: clear the original kernel image
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <cover.1584352425.git.zong.li@sifive.com>
 <8373a9d18958b99b72ed9499786dffe45adf9617.1584352425.git.zong.li@sifive.com>
 <772ee8e0-f5ff-cf40-4e84-3f703953cd08@ghiti.fr>
 <CANXhq0p7A2HeyFDRQaw5brzembsFM0-v3kPwQKvFZuyeCm6tsg@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <9e980cce-2d6a-c854-0a09-886ac525d176@ghiti.fr>
Date:   Thu, 9 Apr 2020 01:53:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CANXhq0p7A2HeyFDRQaw5brzembsFM0-v3kPwQKvFZuyeCm6tsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/20 7:18 AM, Zong Li wrote:
> On Tue, Apr 7, 2020 at 1:11 PM Alex Ghiti <alex@ghiti.fr> wrote:
>>
>> On 3/24/20 3:30 AM, Zong Li wrote:
>>> After completing final page table, we can clear original kernel image
>>> and remove executable permission.
>>>
>>> Signed-off-by: Zong Li <zong.li@sifive.com>
>>> ---
>>>    arch/riscv/include/asm/kaslr.h | 12 ++++++++++++
>>>    arch/riscv/kernel/kaslr.c      | 12 ++++++++++++
>>>    arch/riscv/mm/init.c           |  6 ++++++
>>>    3 files changed, 30 insertions(+)
>>>    create mode 100644 arch/riscv/include/asm/kaslr.h
>>>
>>> diff --git a/arch/riscv/include/asm/kaslr.h b/arch/riscv/include/asm/kaslr.h
>>> new file mode 100644
>>> index 000000000000..b165fe71dd4a
>>> --- /dev/null
>>> +++ b/arch/riscv/include/asm/kaslr.h
>>> @@ -0,0 +1,12 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (C) 2020 SiFive
>>> + * Copyright (C) 2020 Zong Li <zong.li@sifive.com>
>>> + */
>>> +
>>> +#ifndef _ASM_RISCV_KASLR_H
>>> +#define _ASM_RISCV_KASLR_H
>>> +
>>> +void __init kaslr_late_init(void);
>>> +
>>> +#endif /* _ASM_RISCV_KASLR_H */
>>> diff --git a/arch/riscv/kernel/kaslr.c b/arch/riscv/kernel/kaslr.c
>>> index 59001d6fdfc3..0bd30831c455 100644
>>> --- a/arch/riscv/kernel/kaslr.c
>>> +++ b/arch/riscv/kernel/kaslr.c
>>> @@ -356,6 +356,18 @@ static __init uintptr_t get_random_offset(u64 seed, uintptr_t kernel_size)
>>>        return get_legal_offset(random, kernel_size_align);
>>>    }
>>>
>>> +void __init kaslr_late_init(void)
>>> +{
>>> +     uintptr_t kernel_size;
>>> +
>>> +     /* Clear original kernel image. */
>>> +     if (kaslr_offset) {
>>> +             kernel_size = (uintptr_t) _end - (uintptr_t) _start;
>>
>> kernel_size = (uintptr_t) _end - (uintptr_t) _start + 1;
> 
> OK, change it in the next version. Thanks.
> 
>>
>>> +             memset((void *)PAGE_OFFSET, 0, kernel_size);
>>
>> I have been thinking again about our discussion regarding PAGE_OFFSET:
>> PAGE_OFFSET actually points to the address where the kernel was loaded,
>> not the beginning of memory, that's a bit weird.
>>
>> Just saying that here, because it took me a few seconds to remember that
>> and understand what you were doing here.
> 
> In non-kaslr case, we load the kernel to PAGE_OFFSET which points to,
> so we clear the old kernel image through PAGE_OFFSET here. Certainly,
> we could use a symbol to record the start address of the old kernel
> image instead of PAGE_OFFSET here. I don't see other architectures
> changing PAGE_OFFSET after copying the kernel to the new location in
> kaslr. If you think the PAGE_OFFSET needs to be changed, we need to
> give another way to make the page table could create the mappings for
> the whole memory and memblock/buddy system could see the whole memory
> after the kernel moves.
>  >>
>>> +             set_memory_nx(PAGE_OFFSET, kaslr_offset >> PAGE_SHIFT);
>>
>> Again, I certainly missed something but when do you use old kernel
>> mappings ?
> 
> We use old kernel mappings when KASLR calculates the random offset, at
> that moment, kernel is running on old kernel location.

Yes but haven't you already cleared the page table from the mappings for 
the old kernel in clear_page_tables called in setup_vm of the new kernel ?

Alex

> 
>>
>>> +     }
>>> +}
>>> +
>>>    uintptr_t __init kaslr_early_init(void)
>>>    {
>>>        u64 seed;
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index 34c6ecf2c599..08e2ce170533 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -15,6 +15,7 @@
>>>    #include <linux/set_memory.h>
>>>    #ifdef CONFIG_RELOCATABLE
>>>    #include <linux/elf.h>
>>> +#include <asm/kaslr.h>
>>>    #endif
>>>
>>>    #include <asm/fixmap.h>
>>> @@ -649,6 +650,11 @@ static void __init setup_vm_final(void)
>>>        /* Move to swapper page table */
>>>        csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
>>>        local_flush_tlb_all();
>>> +
>>> +#ifdef CONFIG_RANDOMIZE_BASE
>>> +     /* Clear orignial kernel image and set the right permission. */
>>> +     kaslr_late_init();
>>> +#endif
>>>    }
>>>
>>>    void free_initmem(void)
>>>
>>
>> Alex
