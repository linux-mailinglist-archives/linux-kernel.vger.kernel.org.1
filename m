Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEF62FBFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392106AbhASTMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:12:48 -0500
Received: from foss.arm.com ([217.140.110.172]:45490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbhASSzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:55:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5A9611B3;
        Tue, 19 Jan 2021 10:54:23 -0800 (PST)
Received: from [10.37.8.29] (unknown [10.37.8.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ECF33F719;
        Tue, 19 Jan 2021 10:54:22 -0800 (PST)
Subject: Re: [PATCH] kasan: Add explicit preconditions to kasan_report()
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>
References: <20210119172607.18400-1-vincenzo.frascino@arm.com>
 <CAAeHK+zpB6GZcAbWnmvKu5mk_HuNEaXV2OwRuSNnVjddjBqZMQ@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <cc3a5a99-5c99-e526-a5e1-a566f8c412fb@arm.com>
Date:   Tue, 19 Jan 2021 18:58:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+zpB6GZcAbWnmvKu5mk_HuNEaXV2OwRuSNnVjddjBqZMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 1/19/21 6:27 PM, Andrey Konovalov wrote:
> On Tue, Jan 19, 2021 at 6:26 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> With the introduction of KASAN_HW_TAGS, kasan_report() dereferences
>> the address passed as a parameter.
>>
>> Add a comment to make sure that the preconditions to the function are
>> explicitly clarified.
>>
>> Note: An invalid address (e.g. NULL pointer address) passed to the
>> function when, KASAN_HW_TAGS is enabled, leads to a kernel panic.
>>
>> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: Alexander Potapenko <glider@google.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Leon Romanovsky <leonro@mellanox.com>
>> Cc: Andrey Konovalov <andreyknvl@google.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  mm/kasan/report.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index c0fb21797550..2485b585004d 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -403,6 +403,17 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>>         end_report(&flags);
>>  }
>>
>> +/**
>> + * kasan_report - report kasan fault details
>> + * @addr: valid address of the allocation where the tag fault was detected
>> + * @size: size of the allocation where the tag fault was detected
>> + * @is_write: the instruction that caused the fault was a read or write?
>> + * @ip: pointer to the instruction that cause the fault
>> + *
>> + * Note: When CONFIG_KASAN_HW_TAGS is enabled kasan_report() dereferences
>> + * the address to access the tags, hence it must be valid at this point in
>> + * order to not cause a kernel panic.
>> + */
> 
> It doesn't dereference the address, it just checks the tags, right?
> 

This is correct, just realized that the use of "dereference" here is misleading.

> Ideally, kasan_report() should survive that with HW_TAGS like with the
> other modes. The reason it doesn't is probably because of a blank
> addr_has_metadata() definition for HW_TAGS in mm/kasan/kasan.h. I
> guess we should somehow check that the memory comes from page_alloc or
> kmalloc. Or otherwise make sure that it has tags. Maybe there's an arm
> instruction to check whether the memory has tags?
> 

I agree, looking a second time at the code the problem comes from
addr_has_metadata():

...

[   18.127273] BUG: KASAN: invalid-access in 0x0
[   18.128604] Read at addr 0000000000000000 by task swapper/0/1
[   18.130311] Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000000
[   18.131291] Mem abort info:
[   18.131696]   ESR = 0x96000004
[   18.132169]   EC = 0x25: DABT (current EL), IL = 32 bits
[   18.132953]   SET = 0, FnV = 0
[   18.133433]   EA = 0, S1PTW = 0
[   18.133907] Data abort info:
[   18.134308]   ISV = 0, ISS = 0x00000004
[   18.134883]   CM = 0, WnR = 0
[   18.135436] [0000000000000000] user address but active_mm is swapper
[   18.136372] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   18.137280] Modules linked in:
[   18.138182] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
5.11.0-rc4-00007-g86cba71f117-dirty #2
[   18.139275] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[   18.140342] pstate: 60400085 (nZCv daIf +PAN -UAO -TCO BTYPE=--)
[   18.141324] pc : mte_get_mem_tag+0x24/0x40
[   18.142487] lr : print_tags+0x1c/0x40
[   18.143095] sp : ffff80001004bcf0
[   18.143570] x29: ffff80001004bcf0 x28: 0000000000000000
[   18.144526] x27: ffffd042f0bf04e0 x26: ffffd042f0ca1068
[   18.145369] x25: ffffd042f0bdde58 x24: ffffd042f1458000
[   18.146209] x23: 0000000000000000 x22: 0000000000000000
[   18.147047] x21: 0000000000000000 x20: 0000000000000000
[   18.147928] x19: 0000000000000000 x18: ffffffffffffffff
[   18.148928] x17: 000000000000000e x16: 0000000000000001
[   18.149837] x15: ffff80009004ba17 x14: 0000000000000006
[   18.150774] x13: ffffd042f11b27e0 x12: 0000000000000399
[   18.151653] x11: 0000000000000133 x10: ffffd042f11b27e0
[   18.152544] x9 : ffffd042f11b27e0 x8 : 00000000ffffefff
[   18.153443] x7 : ffffd042f120a7e0 x6 : ffffd042f120a7e0
[   18.154272] x5 : 000000000000bff4 x4 : 0000000000000000
[   18.155096] x3 : 0000000000000000 x2 : 0000000000000000
[   18.155958] x1 : 0000000000000000 x0 : 0000000000000000
[   18.157145] Call trace:
[   18.157615]  mte_get_mem_tag+0x24/0x40
[   18.158258]  kasan_report+0xec/0x1b0

...

I noticed it differently but you can easily reproduce it calling
kasan_report(0,0,0,0); from somewhere.

I will send a patch tomorrow that checks if the memory comes from page_alloc or
kmalloc. Not sure what you mean for "instruction to check whether the memory has
tags".

Thanks!

-- 
Regards,
Vincenzo
