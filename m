Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C5927AD63
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgI1L55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:57:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14253 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbgI1L55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:57:57 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9FACA390B4AB410C5106;
        Mon, 28 Sep 2020 19:57:53 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 28 Sep 2020
 19:57:44 +0800
Subject: Re: [PATCH 2/2] ARM: decompressor: relax the loading restriction of
 the decompressed kernel
To:     Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200928092641.2070-1-thunder.leizhen@huawei.com>
 <20200928092641.2070-3-thunder.leizhen@huawei.com>
 <CAMj1kXGK8x4eBL55mLMWVQWpFZKa+FSCaQj9_gieWCQSgG=xAQ@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e2d45592-ffc3-395e-0657-dcff0e094c1f@huawei.com>
Date:   Mon, 28 Sep 2020 19:57:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGK8x4eBL55mLMWVQWpFZKa+FSCaQj9_gieWCQSgG=xAQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/28 18:14, Ard Biesheuvel wrote:
> On Mon, 28 Sep 2020 at 11:27, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> mov     r4, pc
>> and     r4, r4, #0xf8000000     //truncated to 128MiB boundary
>> add     r4, r4, #TEXT_OFFSET    //PA(_start)
>>
>> Currently, the decompressed kernel must be placed at the position: 128MiB
>> boundary + TEXT_OFFSET. This limitation is just because we masked PC with
>> 0xf80000000. Actually, we can directly obtain PA(_start) by using formula
>> : VA(_start) + (PHYS_OFFSET - PAGE_OFFSET).
>>
>> So the "PA(_start) - TEXT_OFFSET" can be 2MiB boundary, 1MiB boundary,
>> and so on.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> No, this won't work.

But it works well on my board.

> 
> The whole reason for rounding to a multiple of 128 MB is that we
> cannot infer the start of DRAM from the placement of the zImage (which
> provides _start).

Maybe this is further guaranteed by the following code:
        /*
	 * Set up a page table only if it won't overwrite ourself.
	 * That means r4 < pc || r4 - 16k page directory > &_end.
	 * Given that r4 > &_end is most unfrequent, we add a rough
	 * additional 1MB of room for a possible appended DTB.
	 */

In addition, the Image has already been loaded when this position is reached.

----------- <--128MiB boundary
|          |
----------- <--TEXT_OFFSET <--
| (1)Image |                 |
------------                 |
|          |                 |
-----------  (2)--copyto-----
| (2)Image |
-----------

I don't think it's the case of (2), but (1). Because no code modification is
required for the case (2).

By the way, I'm not familiar with the arm32 code, so I'm just speculating.

> 
> There are patches on the list by Geert [0] to obtain the start of DRAM
> from the device tree directly, to work around this masking. And when
> booting via EFI (which is supported by u-boot too these days), the
> zImage could be anywhere in [32-bit addressable] memory, and the start
> of DRAM is obtained from the EFI memory map.
> 
> Note to Geert: this is a followup to an effort by Zhen Lei and myself
> [1] to lower the minimum alignment of PHYS_OFFSET from 16 MiB to 2
> MiB, and this affects your patch as well.
> 
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20200902153606.13652-1-geert+renesas@glider.be/
> [1] https://lore.kernel.org/linux-arm-kernel/20200921154117.757-1-ardb@kernel.org/
> 
> 
>> ---
>>  arch/arm/boot/compressed/head.S | 33 ++++++++++++++-------------------
>>  1 file changed, 14 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
>> index 434a16982e344fe..e5ba2ad2ea4700f 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -255,26 +255,16 @@ not_angel:
>>
>>  #ifdef CONFIG_AUTO_ZRELADDR
>>                 /*
>> -                * Find the start of physical memory.  As we are executing
>> -                * without the MMU on, we are in the physical address space.
>> -                * We just need to get rid of any offset by aligning the
>> -                * address.
>> -                *
>> -                * This alignment is a balance between the requirements of
>> -                * different platforms - we have chosen 128MB to allow
>> -                * platforms which align the start of their physical memory
>> -                * to 128MB to use this feature, while allowing the zImage
>> -                * to be placed within the first 128MB of memory on other
>> -                * platforms.  Increasing the alignment means we place
>> -                * stricter alignment requirements on the start of physical
>> -                * memory, but relaxing it means that we break people who
>> -                * are already placing their zImage in (eg) the top 64MB
>> -                * of this range.
>> +                * Find ZRELADDR (Address where the decompressed kernel was
>> +                * placed, usually == PHYS_OFFSET + TEXT_OFFSET). That's the
>> +                * start physical address of the text section, PA(_start).
>> +                * As we are executing without the MMU on, we are in the
>> +                * physical address space.
>>                  */
>> -               mov     r4, pc
>> -               and     r4, r4, #0xf8000000
>> -               /* Determine final kernel image address. */
>> -               add     r4, r4, #TEXT_OFFSET
>> +               adr     r0, LC2
>> +               ldmia   r0, {r3-r4}
>> +               sub     r3, r0, r3              @ PHYS_OFFSET - PAGE_OFFSET
>> +               add     r4, r4, r3              @ PA(_start)
>>  #else
>>                 ldr     r4, =zreladdr
>>  #endif
>> @@ -660,6 +650,11 @@ LC1:               .word   .L_user_stack_end - LC1 @ sp
>>                 .word   _edata - LC1            @ r6
>>                 .size   LC1, . - LC1
>>
>> +               .align  2
>> +               .type   LC2, #object
>> +LC2:           .word   LC2
>> +               .word   _start                  @ start VA of text section
>> +
>>  .Lheadroom:
>>                 .word   _end - restart + 16384 + 1024*1024
>>
>> --
>> 1.8.3
>>
>>
> 
> .
> 

