Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6562B6E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgKQTW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgKQTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:22:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69244C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=t0Ko6hqbyKkoaE2Zp9g1QeIuYu7rk/KOlj3Y3oin9Ng=; b=iC49Y/Wp4zg3nKkl05NMMRZEvi
        6gzzOVa5WqsNW4zLHwFvmzgnmoCfT5eHf/5lSf6lk5pubJcTlNyqrmRJg9RpiBkIQORATm4jGAzTj
        fucR6rBiyeVFh8OgH9MbfxbobcXd0VEXJZaKVjh4tk7pJ/VQac40WBkZ9Jmhm/JGxeqrAn+erwCAc
        /fJwaJQn1pUhhBejXUeMaQ0RfPzlUoR+Rkw38IrUp7K3JgVJNrdAqBnYC9ezxDqkx6H5dVHxXWa68
        pU/MBGvqPcFumvEsIn8TxNi5L21Ul/O7ZKGRZwnp1+3n/txC+WDhLMaYClilVlgNwdG+7WA9SvBuz
        DP7eEcaw==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf6Yt-0005HV-Qs; Tue, 17 Nov 2020 19:22:44 +0000
Subject: Re: [PATCH] RISC-V: fix barrier() use in <vdso/processor.h>
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9ab43756-6c48-c5e8-3a5d-e44bba070a97@infradead.org>
Date:   Tue, 17 Nov 2020 11:22:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmESwnF14TLjRfzJg8Dau8XW0LgoDvXtdPjPOqdf211SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/20 11:00 AM, Nick Desaulniers wrote:
> On Mon, Nov 16, 2020 at 5:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> riscv's <vdso/processor.h> uses barrier() so it should
>> #include <asm/barrier.h> to prevent build errors.
>>
>> Fixes this build error:
>>   CC [M]  drivers/net/ethernet/emulex/benet/be_main.o
>> In file included from ./include/vdso/processor.h:10,
>>                  from ./arch/riscv/include/asm/processor.h:11,
>>                  from ./include/linux/prefetch.h:15,
>>                  from drivers/net/ethernet/emulex/benet/be_main.c:14:
>> ./arch/riscv/include/asm/vdso/processor.h: In function 'cpu_relax':
>> ./arch/riscv/include/asm/vdso/processor.h:14:2: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
>>    14 |  barrier();
>>
>> This happens with a total of 5 networking drivers -- they all use
>> <linux/prefetch.h>.
>>
>> rv64 allmodconfig now builds cleanly after this patch.
>>
>> Fixes fallout from:
>> 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
>>
>> Fixes: ad5d1122b82f ("riscv: use vDSO common flow to reduce the latency of the time-related functions")
> 
> Hi Randy,
> Thanks for the patch, it looks good to me.  I only had a question on
> the commit message.
> 
> Is this also related to:
> commit 3347acc6fcd4 ("compiler.h: fix barrier_data() on clang")

Hi Nick,
Yes, it looks like I tagged the wrong commit in Fixes:
Thanks for noticing that.


> I plan to backport 3347acc6fcd4, so it would be good if all of the
> follow ups are all tagged accordingly with fixes tags, so that I don't
> break anything backporting 3347acc6fcd4 because I forgot or missed any
> follow ups that also needed to be backported.
> 
>> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Arvind Sankar <nivedita@alum.mit.edu>
>> Cc: linux-riscv@lists.infradead.org
>> Cc: clang-built-linux@googlegroups.com
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: Nathan Chancellor <natechancellor@gmail.com>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> ---
>>  arch/riscv/include/asm/vdso/processor.h |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> --- lnx-510-rc4.orig/arch/riscv/include/asm/vdso/processor.h
>> +++ lnx-510-rc4/arch/riscv/include/asm/vdso/processor.h
>> @@ -4,6 +4,8 @@
>>
>>  #ifndef __ASSEMBLY__
>>
>> +#include <asm/barrier.h>
>> +
>>  static inline void cpu_relax(void)
>>  {
>>  #ifdef __riscv_muldiv
> 
> 
> 


-- 
~Randy

