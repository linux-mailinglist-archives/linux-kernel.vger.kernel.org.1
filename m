Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317972B4E96
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbgKPRxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731843AbgKPRxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:53:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97896C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ePseZts8+sY/Qq1NpQZifi/yR1ZOAX2fbODxhYzGnJ4=; b=B0IYZ8EH+FGra1v/AcYrqI98vC
        TDAIs2dpqzgrXLrekdRwdsgsCiGf8WnzAkPegUYHUGo23yVR6y5ux+ETaHDN2hq4wzCbYQSsfbS/A
        Qb0RlJO/iqXbY6z93NOHeBKXdQyxWpXCj/Bf5P/9WQaMVaWOKKdJU2UTTarucWpQ3hz9c2a0KqE0g
        JBmPPia3W/Wr69GQvrWdeUNLgt/MIlCe4/dosu1nG04RY39pcppvwK5AL0b4TFxCRyaMKoTbyX54r
        bChyLCOUzXEFt9KI1KJT2ndV253z+vUeBSpfRPZiIYrhlzpz7RRKPDnBTb5nNY+2r65YFzr9kHJRt
        dtSKd0Og==;
Received: from [2601:1c0:6280:3f0::f32]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1keihJ-0002bH-L2; Mon, 16 Nov 2020 17:53:50 +0000
Subject: Re: [PATCH] compiler.h: Fix barrier_data() on clang
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20201014212631.207844-1-nivedita@alum.mit.edu>
 <87sg999ot0.fsf@igel.home>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0dbaca2d-9ad0-8c1a-a280-97be01cac2bd@infradead.org>
Date:   Mon, 16 Nov 2020 09:53:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87sg999ot0.fsf@igel.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/20 9:47 AM, Andreas Schwab wrote:
> On Okt 14 2020, Arvind Sankar wrote:
> 
>> Commit
>>   815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
>>
>> neglected to copy barrier_data() from compiler-gcc.h into
>> compiler-clang.h. The definition in compiler-gcc.h was really to work
>> around clang's more aggressive optimization, so this broke
>> barrier_data() on clang, and consequently memzero_explicit() as well.
>>
>> For example, this results in at least the memzero_explicit() call in
>> lib/crypto/sha256.c:sha256_transform() being optimized away by clang.
>>
>> Fix this by moving the definition of barrier_data() into compiler.h.
>>
>> Also move the gcc/clang definition of barrier() into compiler.h,
>> __memory_barrier() is icc-specific (and barrier() is already defined
>> using it in compiler-intel.h) and doesn't belong in compiler.h.
>>
>> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> 
> This breaks build on riscv:
> 
>   CC [M]  drivers/net/ethernet/emulex/benet/be_main.o
> In file included from ./include/vdso/processor.h:10,
>                  from ./arch/riscv/include/asm/processor.h:11,
>                  from ./include/linux/prefetch.h:15,
>                  from drivers/net/ethernet/emulex/benet/be_main.c:14:
> ./arch/riscv/include/asm/vdso/processor.h: In function 'cpu_relax':
> ./arch/riscv/include/asm/vdso/processor.h:14:2: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
>    14 |  barrier();
>       |  ^~~~~~~
> cc1: some warnings being treated as errors
> make[5]: *** [scripts/Makefile.build:283: drivers/net/ethernet/emulex/benet/be_main.o] Error 1
> make[4]: *** [scripts/Makefile.build:500: drivers/net/ethernet/emulex/benet] Error 2
> make[3]: *** [scripts/Makefile.build:500: drivers/net/ethernet/emulex] Error 2
> make[2]: *** [scripts/Makefile.build:500: drivers/net/ethernet] Error 2
> make[1]: *** [scripts/Makefile.build:500: drivers/net] Error 2
> make: *** [Makefile:1799: drivers] Error 2

Hi,
What kernel version are you building?
This should be fixed in 5.10-rc4 by
commit 3347acc6fcd4ee71ad18a9ff9d9dac176b517329;
specifically this portion of it:

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 798027bb89be..640f09479bdf 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -13,6 +13,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/compiler.h>
 #include <asm/rwonce.h>
 
 #ifndef nop



-- 
~Randy

