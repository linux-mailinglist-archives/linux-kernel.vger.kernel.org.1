Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4162B6E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgKQT1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgKQT1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:27:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C33C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=68h4/CMO0Xb/f6x4VOJA0yG7fXJsrNZzip6hN7Yjkww=; b=mal+kPD2tLwLCrmU89SxDTWHKr
        WgjLsbokjB/Ta3AhdyDKMgVMLrKADxz5QsVU2VnVZ7Y59udY9qVXCa6FI5f4mJ+KsX1K1YjwvP16h
        520UTX4JvdZEkllui4tRjGEBe/wclezTZ+XxaLADDkNi4crhea00/ZiYXTG8l1x9oclm4/PJvZ3r4
        y0rbvzy8AqE0UhJJEwEEcxbf/IUrZ37yNpJTCRaA6VjDkHnLpB3l4UXQy7z5cnGd92d+n/GQacurS
        H8+VdN0miuNELGEUUyo10iN75dnKg5Tct6Sx+li3kRmqfrmE5iEQHaeB37U1jaVkNjfTATb8Cybg+
        aGnO/Nnw==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf6dY-0005Zb-Re; Tue, 17 Nov 2020 19:27:33 +0000
Subject: Re: [PATCH] RISC-V: fix barrier() use in <vdso/processor.h>
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-riscv@lists.infradead.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20201117013951.7827-1-rdunlap@infradead.org>
 <CAKwvOdmESwnF14TLjRfzJg8Dau8XW0LgoDvXtdPjPOqdf211SQ@mail.gmail.com>
 <9ab43756-6c48-c5e8-3a5d-e44bba070a97@infradead.org>
Message-ID: <fe040988-c076-8dec-8268-3fbaa8b39c0f@infradead.org>
Date:   Tue, 17 Nov 2020 11:27:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9ab43756-6c48-c5e8-3a5d-e44bba070a97@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/20 11:22 AM, Randy Dunlap wrote:
> On 11/17/20 11:00 AM, Nick Desaulniers wrote:
>> On Mon, Nov 16, 2020 at 5:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> riscv's <vdso/processor.h> uses barrier() so it should
>>> #include <asm/barrier.h> to prevent build errors.
>>>
>>> Fixes this build error:
>>>   CC [M]  drivers/net/ethernet/emulex/benet/be_main.o
>>> In file included from ./include/vdso/processor.h:10,
>>>                  from ./arch/riscv/include/asm/processor.h:11,
>>>                  from ./include/linux/prefetch.h:15,
>>>                  from drivers/net/ethernet/emulex/benet/be_main.c:14:
>>> ./arch/riscv/include/asm/vdso/processor.h: In function 'cpu_relax':
>>> ./arch/riscv/include/asm/vdso/processor.h:14:2: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
>>>    14 |  barrier();
>>>
>>> This happens with a total of 5 networking drivers -- they all use
>>> <linux/prefetch.h>.
>>>
>>> rv64 allmodconfig now builds cleanly after this patch.
>>>
>>> Fixes fallout from:
>>> 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
>>>
>>> Fixes: ad5d1122b82f ("riscv: use vDSO common flow to reduce the latency of the time-related functions")
>>
>> Hi Randy,
>> Thanks for the patch, it looks good to me.  I only had a question on
>> the commit message.
>>
>> Is this also related to:
>> commit 3347acc6fcd4 ("compiler.h: fix barrier_data() on clang")
> 
> Hi Nick,
> Yes, it looks like I tagged the wrong commit in Fixes:
> Thanks for noticing that.
> 

I'll send a v2 with corrections.

> 
>> I plan to backport 3347acc6fcd4, so it would be good if all of the
>> follow ups are all tagged accordingly with fixes tags, so that I don't
>> break anything backporting 3347acc6fcd4 because I forgot or missed any
>> follow ups that also needed to be backported.
>>
>>> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>>> Cc: Arvind Sankar <nivedita@alum.mit.edu>
>>> Cc: linux-riscv@lists.infradead.org
>>> Cc: clang-built-linux@googlegroups.com
>>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>>> Cc: Nathan Chancellor <natechancellor@gmail.com>
>>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>>> ---
>>>  arch/riscv/include/asm/vdso/processor.h |    2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> --- lnx-510-rc4.orig/arch/riscv/include/asm/vdso/processor.h
>>> +++ lnx-510-rc4/arch/riscv/include/asm/vdso/processor.h
>>> @@ -4,6 +4,8 @@
>>>
>>>  #ifndef __ASSEMBLY__
>>>
>>> +#include <asm/barrier.h>
>>> +
>>>  static inline void cpu_relax(void)
>>>  {
>>>  #ifdef __riscv_muldiv


-- 
~Randy

